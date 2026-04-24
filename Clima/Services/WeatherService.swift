import Foundation
import CoreLocation

final class WeatherService {
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey = "f9ca1dd22a79f15fad1b4355f12e64f1"
    
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
