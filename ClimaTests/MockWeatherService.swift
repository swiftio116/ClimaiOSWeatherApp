import Foundation
import CoreLocation
@testable import Clima

final class MockWeatherService: WeatherServicing {
    
    var result: Result<WeatherData, Error>?
    
    func fetchWeather(
        city: String,
        completion: @escaping (Result<WeatherData, Error>) -> Void
    ) {
        if let result {
            completion(result)
        }
    }
    
    func fetchWeather(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees,
        completion: @escaping (Result<WeatherData, Error>) -> Void
    ) {
        if let result {
            completion(result)
        }
    }
}
