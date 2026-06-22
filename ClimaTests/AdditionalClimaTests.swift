import XCTest
import Foundation
import CoreLocation
@testable import Clima

final class AdditionalClimaTests: XCTestCase {
    
    func testConditionNameReturnsBoltForThunderstormWeather() {
        let weatherData = WeatherData(
            name: "Kazan",
            main: Main(temp: 12.0),
            weather: [Weather(id: 200, description: "thunderstorm")]
        )
        
        let sut = WeatherModel(weatherData: weatherData)
        
        XCTAssertEqual(sut.conditionName, "cloud.bolt")
    }
    
    func testConditionNameReturnsDrizzleForDrizzleWeather() {
        let weatherData = WeatherData(
            name: "Kazan",
            main: Main(temp: 9.0),
            weather: [Weather(id: 300, description: "drizzle")]
        )
        
        let sut = WeatherModel(weatherData: weatherData)
        
        XCTAssertEqual(sut.conditionName, "cloud.drizzle")
    }
    
    func testConditionNameReturnsCloudForCloudyWeather() {
        let weatherData = WeatherData(
            name: "London",
            main: Main(temp: 15.0),
            weather: [Weather(id: 803, description: "broken clouds")]
        )
        
        let sut = WeatherModel(weatherData: weatherData)
        
        XCTAssertEqual(sut.conditionName, "cloud")
    }
    
    func testFetchWeatherWithMockServiceReturnsWeather() {
        let expectation = expectation(description: "Weather update received")
        
        let weatherData = WeatherData(
            name: "Kazan",
            main: Main(temp: 21.5),
            weather: [Weather(id: 800, description: "clear sky")]
        )
        
        let mockService = MockWeatherService()
        mockService.result = .success(weatherData)
        
        let sut = WeatherViewModel(weatherService: mockService)
        
        sut.onWeatherUpdate = { weather in
            XCTAssertEqual(weather.cityName, "Kazan")
            XCTAssertEqual(weather.temperature, 21.5)
            XCTAssertEqual(weather.conditionName, "sun.max")
            expectation.fulfill()
        }
        
        sut.fetchWeather(for: "Kazan")
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchWeatherFailureReturnsErrorMessage() {
        let expectation = expectation(description: "Error message received")
        
        let mockService = MockWeatherService()
        mockService.result = .failure(MockWeatherError.requestFailed)
        
        let sut = WeatherViewModel(weatherService: mockService)
        
        sut.onError = { errorMessage in
            XCTAssertEqual(errorMessage, "Mock request failed")
            expectation.fulfill()
        }
        
        sut.fetchWeather(for: "Kazan")
        
        wait(for: [expectation], timeout: 1.0)
    }
}

private enum MockWeatherError: LocalizedError {
    case requestFailed
    
    var errorDescription: String? {
        "Mock request failed"
    }
}
