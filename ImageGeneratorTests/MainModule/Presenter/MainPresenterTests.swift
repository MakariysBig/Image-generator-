import XCTest
@testable import ImageGenerator

final class MainPresenterTests: XCTestCase {
    
    let limit = 3
    var presenter: MainPresenter!
    var mockView: MockMainView!
    var mockNetworkManager: MockNetworkManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockView = MockMainView()
        mockNetworkManager = MockNetworkManager()
        presenter = MainPresenter(VC: mockView, networkManager: mockNetworkManager)
    }

    override func tearDownWithError() throws {
        presenter = nil
        mockView = nil
        mockNetworkManager = nil
        try super.tearDownWithError()
    }
    
    func testGenerateImageSuccess() {
        // Given
        let expectedImage = UIImage()
        let newText = "test"
        mockNetworkManager.expectedResult = .success(expectedImage)
        
        // When
        presenter.generateImage(with: newText)
        
        // Then
        XCTAssertEqual(mockView.updatedImage, expectedImage)
        XCTAssertNil(mockView.alertTitle)
        XCTAssertNil(mockView.alertMessage)
    }
    
    func testGenerateImageFailure() {
        // Given
        let newText = "test"
        mockNetworkManager.expectedResult = .failure(NetworkErrors.invalidResponse)
        
        // When
        presenter.generateImage(with: newText)
        
        // Then
        XCTAssertNil(mockView.updatedImage)
        XCTAssertEqual(mockView.alertTitle, "Broken image")
        XCTAssertEqual(mockView.alertMessage, "Try to make a new request")
    }
    
    func testAddToFavorite() {
        // Given
        let expectedImage = UIImage()
        let expectedText = "test"
        let model = FavoriteModel(image: expectedImage, text: expectedText)
        
        // When
        presenter.addToFavorite(with: expectedImage, text: expectedText)
        
        // Then
        XCTAssertEqual(UserDefaultsManager.courseArray[0], model)
        XCTAssertLessThanOrEqual(UserDefaultsManager.courseArray.count, limit)
    }
    
    func testCheckIfTheTextSame() {
        // Given
        let lastText = "Hello"
        
        // When/Then
        XCTAssertTrue(presenter.checkIfTheTextSame(oldText: lastText, newText: "World"))
        XCTAssertFalse(presenter.checkIfTheTextSame(oldText: lastText, newText: "Hello"))
    }
}

final class MockMainView: MainViewProtocol {
    var updatedImage: UIImage?
    var alertTitle: String?
    var alertMessage: String?
    
    func updateImage(with image: UIImage) {
        updatedImage = image
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
    }
    
    func startSpinner() {}
    
    func stopSpinner() {}
}

final class MockNetworkManager: NetworkProtocol {
    var expectedResult: Result<UIImage, Error>?
    
    func fetchImage(text: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let result = expectedResult {
            completion(result)
        }
    }
}
