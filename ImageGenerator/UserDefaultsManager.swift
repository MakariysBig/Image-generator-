import Foundation

enum UserDefaultsManager {
    static var courseArray: [FavoriteModel] {
        get {
            var array = [FavoriteModel]()
            if let data = UserDefaults.standard.value(forKey: "FavoriteModel") as? Data {
                if let dataFromDB = try? PropertyListDecoder().decode(Array<FavoriteModel>.self, from: data) {
                    array = dataFromDB
                }
            }
            return array
        }
        
        set {
            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(newValue), forKey:"FavoriteModel")
        }
    }
}

