import XCTest

final class ClimaUITests: XCTestCase {

    func testAppLaunchesSuccessfully() {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.exists)
    }
}
