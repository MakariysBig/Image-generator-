import Foundation

protocol FavoriteViewProtocol: AnyObject {}

protocol FavoritePresenterProtocol {
    init(VC: FavoriteViewProtocol)
    
    func getArrayCount() -> Int
    func getModel(with index: Int) -> FavoriteModel
    func deleteModel(at index: Int)
}
