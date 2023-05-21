import XCTest

private enum Element: String {
    case generateTextField = "generateTextfield"
    case returnButton      = "Return"
    case generateButton    = "generateButton"
    case alert             = "Broken image"
}


final class ImageGeneratorUITests: XCTestCase {

    override func setUpWithError() throws {

        continueAfterFailure = false
    }

    override func tearDownWithError() throws {

    }

    func testGenerateImage() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.textFields[Element.generateTextField.rawValue].tap()
        app.textFields[Element.generateTextField.rawValue].typeText("New request")
        
        app.buttons[Element.returnButton.rawValue].tap()
        app.buttons[Element.generateButton.rawValue].tap()

        XCTAssert(!app.alerts[Element.alert.rawValue].waitForExistence(timeout: 2.0))
    }
}
