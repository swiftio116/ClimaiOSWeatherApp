# 🌦 Clima iOS Weather App

A modern iOS weather application built with **Swift**, **UIKit**, **MVVM architecture**, **Dependency Injection**, and **Unit Testing**.

The app provides real-time weather information using the [OpenWeather API](https://openweathermap.org/api), supports weather lookup by city name and current device location, and demonstrates service abstraction through protocols.

---

## 📱 Demo

![Demo](screenshot/ClimaDemo.gif)

---

## 🖼 Screenshots

### 🌍 Different Cities

| Kazan | London | Orlando |
|------|--------|---------|
| ![Kazan](screenshot/Kazan.png) | ![London](screenshot/London.png) | ![Orlando](screenshot/Orlando.png) |

### 📲 App Interface

| Main Screen |
|------------|
| ![Main Screen](screenshot/weatherscreen.png) |

---

## 🚀 Features

- 🌍 Search weather by city name
- 📍 Get weather for the current device location
- 🌡 Display temperature and weather conditions
- ⚡ Real-time API integration
- 🧠 MVVM architecture
- 🔌 Dependency Injection using protocols
- 🧪 Unit testing with mock services
- 🎨 Clean UIKit interface
- 📱 Responsive Auto Layout

---

## 🛠 Tech Stack

- [Swift](https://www.swift.org/)
- [UIKit](https://developer.apple.com/documentation/uikit)
- [CoreLocation](https://developer.apple.com/documentation/corelocation)
- [URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [Codable](https://developer.apple.com/documentation/swift/codable)
- MVVM
- Dependency Injection
- [XCTest](https://developer.apple.com/documentation/xctest)
- Auto Layout
- Git & GitHub

---

## 🧩 Architecture

The project follows the **MVVM (Model-View-ViewModel)** pattern.

```text
WeatherViewController
        ↓
WeatherViewModel
        ↓
WeatherServicing
        ↓
WeatherService
```

### ViewController

Responsible for UI rendering, user interactions, and location permissions.

### ViewModel

Contains presentation logic, input validation, and communication with the weather service.

### Model

Represents API response structures and UI-friendly weather data.

### Service Layer

Responsible for networking and API communication.

---

## 🔌 Dependency Injection

`WeatherViewModel` depends on the `WeatherServicing` protocol instead of a concrete `WeatherService`.

```swift
init(weatherService: WeatherServicing) {
    self.weatherService = weatherService
}
```

This allows the app to use:

- `WeatherService` in production
- `MockWeatherService` in unit tests

As a result, ViewModel logic can be tested without real network requests.

---

## 🧪 Unit Tests

The project includes **15 Unit Tests**.

### WeatherModel Tests

- City name mapping
- Temperature mapping
- Temperature formatting
- Clear weather condition
- Rain condition
- Snow condition
- Fog condition
- Thunderstorm condition
- Drizzle condition
- Cloudy condition
- Unknown weather condition

### WeatherViewModel Tests

- Empty city validation and error handling
- Successful weather loading with `MockWeatherService`
- Error handling with `MockWeatherService`

The project uses **MockWeatherService** and dependency injection to keep tests isolated from real API calls.

---

## 🌐 API Integration

The application fetches real-time weather data from the [OpenWeather API](https://openweathermap.org/api) using:

- URLSession
- Codable
- JSONDecoder

---

## 📂 Project Structure

```text
Clima
├── Controllers
├── ViewModels
├── Models
├── Services
├── Resources
├── ClimaTests
└── screenshot
```

---

## ✅ Project Improvements

- Refactored weather flow using Dependency Injection
- Added `WeatherServicing` protocol
- Added `MockWeatherService` for unit tests
- Added additional unit tests for model and ViewModel logic
- Added concise code documentation for key components
- Removed `.DS_Store` files from Git
- Updated `.gitignore` to prevent macOS service files from being committed

---

## 📚 What I Learned

- MVVM architecture in UIKit applications
- Dependency Injection through protocols
- Building testable code using mocks
- REST API integration with URLSession
- JSON parsing with Codable
- Location services using CoreLocation
- Writing Unit Tests with XCTest
- Auto Layout and responsive interfaces
- Git and GitHub workflow

---

## 🎯 Why I Built This Project

This project was created to strengthen my iOS development skills and gain practical experience with:

- Real-world networking
- MVVM architecture
- Dependency Injection
- Testing ViewModel logic
- UIKit application development
- Working with REST APIs

---

## 📌 Future Improvements

- ⭐ Favorite cities
- 🌍 Multiple saved locations
- 📅 5-day weather forecast
- ⚡ Async/Await networking
- 🎨 Migration to SwiftUI
- Better error presentation in UI
- Loading state while fetching weather

---

## 👨‍💻 Author

**Aiaz Muzafarov**

- GitHub: [swiftio116](https://github.com/swiftio116)
- LinkedIn: [Aiaz Muzafarov](https://www.linkedin.com/in/aiaz-muzafarov-546a4a288/)
````
