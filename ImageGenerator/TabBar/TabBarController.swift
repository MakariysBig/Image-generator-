import UIKit

final class TabBarController: UITabBarController {
    
    private var moduleBuilder = ModuleBuilder()
    
    private lazy var generateVC: UINavigationController = {
        let vc = UINavigationController(rootViewController: moduleBuilder.createMainModule())
        vc.title = "Generate"
        vc.tabBarItem.image  = UIImage(named: "settings")
        return vc
    }()
    
    private lazy var favoriteVC: UINavigationController = {
        let vc = UINavigationController(rootViewController: moduleBuilder.createFavoriteModule())
        vc.title = "Favorite"
        vc.tabBarItem.image  = UIImage(named: "education")
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        self.setViewControllers([generateVC, favoriteVC], animated: true)
        self.tabBar.tintColor               = .systemBlue
        self.tabBar.unselectedItemTintColor = .systemGray
        self.tabBar.backgroundColor = .white
    }
}
