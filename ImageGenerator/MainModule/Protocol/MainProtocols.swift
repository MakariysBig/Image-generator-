import UIKit

//MARK: - View

protocol MainViewProtocol: AnyObject {
    func updateImage(with image: UIImage)
    func showAlert(title: String, message: String)
    func startSpinner()
    func stopSpinner()
}

//MARK: - Presenter

protocol MainPresenterProtocol {
    init(VC: MainViewProtocol, networkManager: NetworkProtocol)
    
    func generateImage(with text: String?)
    func addToFavorite(with image: UIImage, text: String)
    func checkIfTheTextSame(oldText: String?, newText: String?) -> Bool
}
