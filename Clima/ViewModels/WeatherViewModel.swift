import Foundation
import CoreLocation

final class WeatherViewModel {

    var onWeatherUpdate: ((WeatherModel) -> Void)?
    var onError: ((String) -> Void)?

    private let weatherService: WeatherServicing

    init(weatherService: WeatherServicing) {
        self.weatherService = weatherService
    }

    func fetchWeather(for city: String) {
        let trimmedCity = city.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedCity.isEmpty else {
            onError?("Please enter a city name")
            return
        }

        weatherService.fetchWeather(city: trimmedCity) { [weak self] result in
            self?.handleResult(result)
        }
    }

    func fetchWeather(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees
    ) {
        weatherService.fetchWeather(latitude: latitude, longitude: longitude) { [weak self] result in
            self?.handleResult(result)
        }
    }

    // Converts service result to UI model.
    private func handleResult(_ result: Result<WeatherData, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let weatherData):
                let weather = WeatherModel(weatherData: weatherData)
                self.onWeatherUpdate?(weather)

            case .failure(let error):
                self.onError?(error.localizedDescription)
            }
        }
    }
}
