import UIKit

final class MainPresenter: MainPresenterProtocol {
  
    //MARK: - Private properties
    
    private let limit = 3
    private let networkLayer = NetworkManager()
    
    private var lastGenerate: String?
    private weak var VC: MainViewProtocol?

    //MARK: - Initialise
    
    init(VC: MainViewProtocol) {
        self.VC = VC
    }
    
    //MARK: - Internal methods
    
    func generateImage(with text: String?) {
        let newText = text?.replacingOccurrences(of: " ", with: "+")
        
        if lastGenerate != newText {
            lastGenerate = newText
            networkLayer.fetchImage(text: newText ?? "") { result in
                switch result {
                case .success(let image):
                    self.VC?.updateImage(with: image)
                case .failure(_):
                    self.VC?.showAlert(title: "Broken image", message: "Try to make a new request")
                }
            }
        }
    }
    
    func addToFavorite(with image: UIImage, text: String) {
        let model = FavoriteModel(image: image, text: text)
        UserDefaultsManager.courseArray.insert(model, at: 0)
        
        if UserDefaultsManager.courseArray.count > limit {
            UserDefaultsManager.courseArray.removeLast()
        }
    }
}
