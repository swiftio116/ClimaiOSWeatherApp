import Foundation
import CoreLocation
@testable import Clima
/// Mock implementation used to test weather flow without network requests.

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
