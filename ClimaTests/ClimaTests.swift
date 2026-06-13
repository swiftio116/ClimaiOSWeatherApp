import Testing
@testable import Clima

struct ClimaTests {
    
    @Test func weatherModelCreatesCorrectCityName() {
        let weatherData = WeatherData(
            name: "Kazan",
            main: Main(temp: 21.5),
            weather: [Weather(id: 800, description: "clear sky")]
        )
        
        let sut = WeatherModel(weatherData: weatherData)
        
        #expect(sut.cityName == "Kazan")
    }
    
    @Test func weatherModelCreatesCorrectTemperature() {
        let weatherData = WeatherData(
            name: "Kazan",
            main: Main(temp: 21.5),
            weather: [Weather(id: 800, description: "clear sky")]
        )
        
        let sut = WeatherModel(weatherData: weatherData)
        
        #expect(sut.temperature == 21.5)
    }
    
    @Test func temperatureStringFormatsToOneDecimalPlace() {
        let weatherData = WeatherData(
            name: "Kazan",
            main: Main(temp: 21.56),
            weather: [Weather(id: 800, description: "clear sky")]
        )
        
        let sut = WeatherModel(weatherData: weatherData)
        
        #expect(sut.temperatureString == "21.6")
    }
    
    @Test func conditionNameReturnsSunForClearWeather() {
        let weatherData = WeatherData(
            name: "Kazan",
            main: Main(temp: 25.0),
            weather: [Weather(id: 800, description: "clear sky")]
        )
        
        let sut = WeatherModel(weatherData: weatherData)
        
        #expect(sut.conditionName == "sun.max")
    }
    
    @Test func conditionNameReturnsRainForRainWeather() {
        let weatherData = WeatherData(
            name: "Kazan",
            main: Main(temp: 14.0),
            weather: [Weather(id: 500, description: "rain")]
        )
        
        let sut = WeatherModel(weatherData: weatherData)
        
        #expect(sut.conditionName == "cloud.rain")
    }
}
@Test func conditionNameReturnsSnowForSnowWeather() {
    let weatherData = WeatherData(
        name: "Kazan",
        main: Main(temp: -5.0),
        weather: [Weather(id: 600, description: "snow")]
    )
    
    let sut = WeatherModel(weatherData: weatherData)
    
    #expect(sut.conditionName == "cloud.snow")
}

@Test func conditionNameReturnsFogForAtmosphereWeather() {
    let weatherData = WeatherData(
        name: "Kazan",
        main: Main(temp: 3.0),
        weather: [Weather(id: 741, description: "fog")]
    )
    
    let sut = WeatherModel(weatherData: weatherData)
    
    #expect(sut.conditionName == "cloud.fog")
}

@Test func conditionNameReturnsCloudForUnknownWeather() {
    let weatherData = WeatherData(
        name: "Kazan",
        main: Main(temp: 10.0),
        weather: [Weather(id: 999, description: "unknown")]
    )
    
    let sut = WeatherModel(weatherData: weatherData)
    
    #expect(sut.conditionName == "cloud")
}
