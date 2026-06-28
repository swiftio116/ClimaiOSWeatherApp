import Foundation

nonisolated struct WeatherData: Codable, Sendable {
    let name: String
    let main: Main
    let weather: [Weather]
}

nonisolated struct Main: Codable, Sendable {
    let temp: Double
}

nonisolated struct Weather: Codable, Sendable {
    let id: Int
    let description: String
}
