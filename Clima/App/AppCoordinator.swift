import UIKit
import CoreLocation

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

        // Sets the first screen.
        window.rootViewController = weatherViewController
        window.makeKeyAndVisible()
    }
}
