import UIKit

final class ModuleBuilder {
    func createMainModule() -> UIViewController {
        let VC = MainViewController()
        let networkManager = NetworkManager()
        let presenter = MainPresenter(VC: VC, networkManager: networkManager)
        VC.presenter = presenter
        
        return VC
    }
    
    func createFavoriteModule() -> UIViewController {
        let VC = FavoriteViewController()
        let presenter = FavoritePresenter(VC: VC)
        VC.presenter = presenter
        
        return VC
    }
}
