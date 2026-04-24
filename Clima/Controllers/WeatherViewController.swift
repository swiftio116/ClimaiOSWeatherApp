import UIKit
import CoreLocation

final class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    private let viewModel = WeatherViewModel()
    private let locationManager = CLLocationManager()
    
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
        let city = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !city.isEmpty else { return true }
        
        viewModel.fetchWeather(for: city)
        textField.resignFirstResponder()
        return true
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        case .denied, .restricted:
            print("Location access denied")
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        viewModel.fetchWeather(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LOCATION ERROR:", error.localizedDescription)
    }
}
