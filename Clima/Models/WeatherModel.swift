import Foundation

/// UI-friendly weather model used by the weather screen.
struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double

    /// Converts raw WeatherData from the API into values that are convenient for UI.
    init(weatherData: WeatherData) {
        conditionId = weatherData.weather.first?.id ?? 0
        cityName = weatherData.name
        temperature = weatherData.main.temp
    }

    /// Returns formatted temperature text for displaying in the UI.
    var temperatureString: String {
        String(format: "%.1f", temperature)
    }

    /// Returns an SF Symbol name based on the OpenWeather condition id.
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
}
