import Foundation
import CoreLocation

final class WeatherViewModel {
    
    private let weatherService = WeatherService()
    
    var onWeatherUpdate: ((WeatherModel) -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchWeather(for city: String) {
        let trimmedCity = city.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedCity.isEmpty else {
            onError?("Please enter a city name")
            return
        }
        
        weatherService.fetchWeather(city: trimmedCity) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                
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
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        weatherService.fetchWeather(latitude: latitude, longitude: longitude) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                
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
}
