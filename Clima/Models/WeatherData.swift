import Foundation

nonisolated struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

nonisolated struct Main: Codable {
    let temp: Double
}

nonisolated struct Weather: Codable {
    let id: Int
    let description: String
}
