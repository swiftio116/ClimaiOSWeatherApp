import Foundation
import CoreLocation

/// Concrete implementation of `WeatherServicing` that loads weather data
/// from the OpenWeather API using `URLSession`.
final class WeatherService {
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey = "YOUR_API_KEY"
    
    func fetchWeather(city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let cityQuery = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "\(baseURL)?appid=\(apiKey)&units=metric&q=\(cityQuery)"
        performRequest(urlString: urlString, completion: completion)
    }
    
    func fetchWeather(latitude: CLLocationDegrees,
                      longitude: CLLocationDegrees,
                      completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "\(baseURL)?appid=\(apiKey)&units=metric&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString, completion: completion)
    }
    /// Performs a network request and decodes the response into `WeatherData`.
    ///
    /// - Parameters:
    ///   - urlString: Full OpenWeather API URL string.
    ///   - completion: Completion handler returning either decoded `WeatherData` or an error.
    private func performRequest(urlString: String,
                                completion: @escaping (Result<WeatherData, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
extension WeatherService: WeatherServicing {}
