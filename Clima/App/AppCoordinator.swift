import UIKit
import CoreLocation

/// Creates the app flow and injects dependencies into screens.
final class AppCoordinator {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let weatherService: WeatherServicing = WeatherService()
        let viewModel = WeatherViewModel(weatherService: weatherService)
        let locationManager = CLLocationManager()

        let weatherViewController = WeatherViewController(
            viewModel: viewModel,
            locationManager: locationManager
        )

        window.rootViewController = weatherViewController
        window.makeKeyAndVisible()
    }
}
