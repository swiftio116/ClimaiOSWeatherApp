import XCTest

final class ClimaUITestsLaunchTests: XCTestCase {

    func testLaunch() {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.exists)
    }
}
