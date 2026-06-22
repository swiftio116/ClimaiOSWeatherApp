import UIKit
import CoreLocation

final class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    private let viewModel: WeatherViewModel
    private let locationManager: CLLocationManager
    
    init(
        viewModel: WeatherViewModel = WeatherViewModel(weatherService: WeatherService()),
        locationManager: CLLocationManager = CLLocationManager()
    ) {
        self.viewModel = viewModel
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = WeatherViewModel(weatherService: WeatherService())
        self.locationManager = CLLocationManager()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        locationManager.delegate = self
        
        bindViewModel()
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func bindViewModel() {
        viewModel.onWeatherUpdate = { [weak self] weather in
            guard let self else { return }
            
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
        
        viewModel.onError = { errorMessage in
            print("ERROR:", errorMessage)
        }
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        let city = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        guard !city.isEmpty else { return }
        
        viewModel.fetchWeather(for: city)
        searchTextField.endEditing(true)
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}
extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text,
              !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            textField.placeholder = "Type something"
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let city = searchTextField.text else { return }
        
        viewModel.fetchWeather(for: city)
        searchTextField.text = ""
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        
        locationManager.stopUpdatingLocation()
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        viewModel.fetchWeather(latitude: latitude, longitude: longitude)
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Location error:", error.localizedDescription)
    }
}
