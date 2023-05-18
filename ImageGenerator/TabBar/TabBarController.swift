import UIKit

final class TabBarController: UITabBarController {
    
    private let generateVC: UINavigationController = {
        let vc = UINavigationController(rootViewController: MainViewController())
        vc.title = "Generate"
        vc.tabBarItem.image  = UIImage(named: "settings")
        return vc
    }()
    
    private let favoriteVC: UINavigationController = {
        let vc = UINavigationController(rootViewController: FavoriteViewController())
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
