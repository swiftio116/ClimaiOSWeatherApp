import UIKit
import CoreLocation

final class WeatherViewController: UIViewController {

    private let backgroundImageView = UIImageView()
    private let conditionImageView = UIImageView()
    private let temperatureLabel = UILabel()
    private let cityLabel = UILabel()
    private let searchTextField = UITextField()
    private let searchButton = UIButton(type: .system)
    private let locationButton = UIButton(type: .system)
    private let viewModel: WeatherViewModel
    private let locationManager: CLLocationManager

    init(
        viewModel: WeatherViewModel,
        locationManager: CLLocationManager
    ) {
        self.viewModel = viewModel
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupKeyboardDismiss()

        searchTextField.delegate = self
        locationManager.delegate = self

        bindViewModel()
        locationManager.requestWhenInUseAuthorization()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(named: "meatherColor") ?? .systemBackground

        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true

        locationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        locationButton.tintColor = .black
        locationButton.setPreferredSymbolConfiguration(
            UIImage.SymbolConfiguration(pointSize: 42, weight: .bold),
            forImageIn: .normal
        )
        locationButton.addTarget(self, action: #selector(locationPressed), for: .touchUpInside)

        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .black
        searchButton.setPreferredSymbolConfiguration(
            UIImage.SymbolConfiguration(pointSize: 42, weight: .regular),
            forImageIn: .normal
        )
        searchButton.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)

        searchTextField.placeholder = "Search"
        searchTextField.textAlignment = .right
        searchTextField.font = .systemFont(ofSize: 28, weight: .regular)
        searchTextField.borderStyle = .none
        searchTextField.returnKeyType = .search
        searchTextField.autocapitalizationType = .words
        searchTextField.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        searchTextField.textColor = .black
        searchTextField.tintColor = .black

        
        conditionImageView.contentMode = .scaleAspectFit
        conditionImageView.tintColor = UIColor(red: 0.12, green: 0.29, blue: 0.31, alpha: 1.0)
        conditionImageView.image = UIImage(systemName: "cloud")

        
        temperatureLabel.font = .systemFont(ofSize: 82, weight: .bold)
        temperatureLabel.textColor = .black
        temperatureLabel.textAlignment = .right
        temperatureLabel.text = "--°C"

        
        cityLabel.font = .systemFont(ofSize: 40, weight: .regular)
        cityLabel.textColor = .black
        cityLabel.textAlignment = .right
        cityLabel.text = "City"

        [
            backgroundImageView,
            locationButton,
            searchTextField,
            searchButton,
            conditionImageView,
            temperatureLabel,
            cityLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            
            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            locationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            locationButton.widthAnchor.constraint(equalToConstant: 56),
            locationButton.heightAnchor.constraint(equalToConstant: 56),

            
            searchButton.centerYAnchor.constraint(equalTo: locationButton.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            searchButton.widthAnchor.constraint(equalToConstant: 56),
            searchButton.heightAnchor.constraint(equalToConstant: 56),

            
            searchTextField.centerYAnchor.constraint(equalTo: locationButton.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: locationButton.trailingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 54),

            
            conditionImageView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 70),
            conditionImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -52),
            conditionImageView.widthAnchor.constraint(equalToConstant: 150),
            conditionImageView.heightAnchor.constraint(equalToConstant: 120),

            
            temperatureLabel.topAnchor.constraint(equalTo: conditionImageView.bottomAnchor, constant: 70),
            temperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            temperatureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),

            
            cityLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 28),
            cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            cityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48)
        ])
    }

    private func bindViewModel() {
        viewModel.onWeatherUpdate = { [weak self] weather in
            guard let self else { return }

            self.temperatureLabel.text = "\(weather.temperatureString)°C"
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }

        viewModel.onError = { errorMessage in
            print("ERROR:", errorMessage)
        }
    }

    private func setupKeyboardDismiss() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func searchPressed() {
        let city = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        guard !city.isEmpty else { return }

        viewModel.fetchWeather(for: city)
        view.endEditing(true)
    }

    @objc private func locationPressed() {
        locationManager.requestLocation()
    }
}

extension WeatherViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchPressed()
        return true
    }
}

extension WeatherViewController: CLLocationManagerDelegate {

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }

        viewModel.fetchWeather(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Location error:", error.localizedDescription)
    }
}
