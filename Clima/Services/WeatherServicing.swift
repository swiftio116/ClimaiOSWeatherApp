import Foundation
import CoreLocation

protocol WeatherServicing {

    func fetchWeather(
        city: String,
        completion: @escaping (Result<WeatherData, Error>) -> Void
    )

    func fetchWeather(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees,
        completion: @escaping (Result<WeatherData, Error>) -> Void
    )
}
