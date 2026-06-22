import Foundation
import CoreLocation

/// Defines a service responsible for loading weather data.
///
/// The protocol is used to decouple `WeatherViewModel` from a concrete
/// networking implementation. This makes the weather flow easier to test
/// because the real `WeatherService` can be replaced with `MockWeatherService`.
protocol WeatherServicing {
    
    /// Fetches weather data for the provided city name.
    ///
    /// - Parameters:
    ///   - city: City name entered by the user.
    ///   - completion: Completion handler returning either decoded `WeatherData` or an error.
    func fetchWeather(
        city: String,
        completion: @escaping (Result<WeatherData, Error>) -> Void
    )
    
    /// Fetches weather data for the provided geographic coordinates.
    ///
    /// - Parameters:
    ///   - latitude: Location latitude.
    ///   - longitude: Location longitude.
    ///   - completion: Completion handler returning either decoded `WeatherData` or an error.
    func fetchWeather(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees,
        completion: @escaping (Result<WeatherData, Error>) -> Void
    )
}
