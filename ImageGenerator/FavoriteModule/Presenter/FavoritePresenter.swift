import Foundation

final class FavoritePresenter: FavoritePresenterProtocol {
    
    //MARK: - Properties
    
    weak var VC: FavoriteViewProtocol?
    
    //MARK: - Initialise
    
    init(VC: FavoriteViewProtocol) {
        self.VC = VC
    }
    
    //MARK: - Methods
    
    func getArrayCount() -> Int {
        UserDefaultsManager.courseArray.count
    }
    
    func getModel(with index: Int) -> FavoriteModel {
        UserDefaultsManager.courseArray[index]
    }
    
    func deleteModel(at index: Int) {
        UserDefaultsManager.courseArray.remove(at: index)
    }
}
