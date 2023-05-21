import UIKit

//MARK: - View

protocol MainViewProtocol: AnyObject {
    func updateImage(with image: UIImage)
    func showAlert(title: String, message: String)
}

//MARK: - Presenter

protocol MainPresenterProtocol {
    init(VC: MainViewProtocol)
    
    func generateImage(with text: String?)
    func addToFavorite(with image: UIImage, text: String)
}
