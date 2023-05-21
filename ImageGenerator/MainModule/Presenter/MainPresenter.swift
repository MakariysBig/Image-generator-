import UIKit

final class MainPresenter: MainPresenterProtocol {
    //MARK: - Private properties
    
    private let limit = 3
    private let networkManager: NetworkProtocol?
    
    private var lastGenerate: String?
    private weak var VC: MainViewProtocol?

    //MARK: - Initialise
    
    init(VC: MainViewProtocol, networkManager: NetworkProtocol) {
        self.VC = VC
        self.networkManager = networkManager
    }
    
    //MARK: - Internal methods
    
    func generateImage(with text: String?) {
        let newText = text?.replacingOccurrences(of: " ", with: "+")
        
        if checkIfTheTextSame(oldText: lastGenerate, newText: newText) {
            lastGenerate = newText
            networkManager?.fetchImage(text: newText ?? "") { [weak self] result in
                guard let self = self else { return }
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
    
    func checkIfTheTextSame(oldText: String?, newText: String?) -> Bool {
        return oldText != newText
    }
}
