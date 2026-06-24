# 🌦 Clima iOS Weather App

A modern iOS weather application built with **Swift**, **UIKit**, **MVVM architecture**, **Dependency Injection**, **Programmatic UI**, **Native Auto Layout**, and **Unit Testing**.

The app provides real-time weather information using the [OpenWeather API](https://openweathermap.org/api), supports weather lookup by city name and current device location, and demonstrates testable architecture through protocol-based service abstraction.

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
- 🧭 AppCoordinator for dependency assembly
- 🧪 Unit testing with mock services
- 🎨 Programmatic UIKit interface
- 📐 Native Auto Layout without Storyboard, XIB, or SnapKit
- 📱 Responsive layout using `NSLayoutConstraint`

---

## 🛠 Tech Stack

- [Swift](https://www.swift.org/)
- [UIKit](https://developer.apple.com/documentation/uikit)
- [CoreLocation](https://developer.apple.com/documentation/corelocation)
- [URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [Codable](https://developer.apple.com/documentation/swift/codable)
- MVVM
- AppCoordinator
- Dependency Injection
- [XCTest](https://developer.apple.com/documentation/xctest)
- Native Auto Layout
- Git & GitHub

---

## 🧩 Architecture

The project follows the **MVVM (Model-View-ViewModel)** pattern with dependency injection assembled through `AppCoordinator`.

```text
AppCoordinator
        ↓
WeatherViewController
        ↓
WeatherViewModel
        ↓
WeatherServicing
        ↓
WeatherService
```

### AppCoordinator

`AppCoordinator` creates the main application flow and injects all required dependencies into the weather screen.

It creates:

- `WeatherService`
- `WeatherViewModel`
- `CLLocationManager`
- `WeatherViewController`

This keeps `WeatherViewController` independent from concrete service creation and avoids creating dependencies inside the controller.

### ViewController

`WeatherViewController` is responsible for:

- building UI in code
- handling user interactions
- forwarding user actions to the ViewModel
- receiving ViewModel callbacks
- updating labels and weather icons
- working with location permission callbacks

The screen is built fully with **UIKit programmatic UI** and **native Auto Layout**.

No Storyboard, XIB, IBOutlet, IBAction, or third-party layout framework is used.

### ViewModel

`WeatherViewModel` contains presentation logic:

- validates city input
- requests weather by city name
- requests weather by coordinates
- converts API response data into `WeatherModel`
- exposes callbacks for successful UI updates and errors

### Model

The model layer contains:

- API response models decoded with `Codable`
- `WeatherModel`, which converts raw API data into UI-friendly values

### Service Layer

`WeatherService` is responsible for networking and API communication.

It conforms to the `WeatherServicing` protocol, which allows the app to use a real service in production and mock services in tests.

---

## 🎨 Programmatic UI

The main weather screen was refactored from Storyboard-based layout to fully programmatic UIKit layout.

The project now uses:

- `UIImageView`
- `UILabel`
- `UITextField`
- `UIButton`
- `NSLayoutConstraint.activate`
- `safeAreaLayoutGuide`

The interface is created entirely in Swift code.

```text
No Storyboard
No XIB
No IBOutlet
No IBAction
No SnapKit
Native UIKit Auto Layout only
```

This approach demonstrates understanding of UIKit layout, view hierarchy, and native Auto Layout constraints.

---

## 🔌 Dependency Injection

`WeatherViewModel` depends on the `WeatherServicing` protocol instead of a concrete `WeatherService`.

```swift
init(weatherService: WeatherServicing) {
    self.weatherService = weatherService
}
```

`WeatherViewController` receives its dependencies through initializer injection:

```swift
init(
    viewModel: WeatherViewModel,
    locationManager: CLLocationManager
) {
    self.viewModel = viewModel
    self.locationManager = locationManager
    super.init(nibName: nil, bundle: nil)
}
```

The dependencies are created outside the controller in `AppCoordinator`.

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

The project uses `MockWeatherService` and dependency injection to keep tests isolated from real API calls.

---

## 🌐 API Integration

The application fetches real-time weather data from the [OpenWeather API](https://openweathermap.org/api) using:

- URLSession
- Codable
- JSONDecoder

The networking layer is isolated inside `WeatherService`, while the ViewModel communicates with it through the `WeatherServicing` protocol.

---

## 📂 Project Structure

```text
Clima
├── App
│   └── AppCoordinator.swift
├── Controllers
│   └── WeatherViewController.swift
├── ViewModels
│   └── WeatherViewModel.swift
├── Models
│   ├── WeatherData.swift
│   └── WeatherModel.swift
├── Services
│   ├── WeatherService.swift
│   └── WeatherServicing.swift
├── Resources
├── ClimaTests
└── screenshot
```

---

## ✅ Project Improvements

- Refactored weather flow using Dependency Injection
- Added `WeatherServicing` protocol
- Added `MockWeatherService` for unit tests
- Added `AppCoordinator` for dependency assembly
- Moved dependency creation out of `WeatherViewController`
- Refactored main screen from Storyboard to programmatic UIKit UI
- Removed IBOutlet and IBAction usage from the main weather screen
- Added native Auto Layout constraints in code
- Removed reliance on third-party layout frameworks
- Added additional unit tests for model and ViewModel logic
- Added concise code documentation for key components
- Removed `.DS_Store` files from Git
- Updated `.gitignore` to prevent macOS service files from being committed

---

## 📚 What I Learned

- MVVM architecture in UIKit applications
- Dependency Injection through protocols
- Building testable code using mocks
- Creating UIKit screens fully in code
- Native Auto Layout with `NSLayoutConstraint`
- App flow assembly through Coordinator
- REST API integration with URLSession
- JSON parsing with Codable
- Location services using CoreLocation
- Writing Unit Tests with XCTest
- Git and GitHub workflow

---

## 🎯 Why I Built This Project

This project was created to strengthen my iOS development skills and gain practical experience with:

- Real-world networking
- MVVM architecture
- Dependency Injection
- Testable ViewModel logic
- UIKit application development
- Programmatic UI
- Native Auto Layout
- Working with REST APIs

---

## 📌 Future Improvements

- ⭐ Favorite cities
- 🌍 Multiple saved locations
- 📅 5-day weather forecast
- ⚡ Async/Await networking
- 🎨 SwiftUI version of the weather screen
- Better error presentation in UI
- Loading state while fetching weather
- Improved accessibility support
- More UI tests

---

## 👨‍💻 Author

**Aiaz Muzafarov**

- GitHub: [swiftio116](https://github.com/swiftio116)
- LinkedIn: [Aiaz Muzafarov](https://www.linkedin.com/in/aiaz-muzafarov-546a4a288/)
