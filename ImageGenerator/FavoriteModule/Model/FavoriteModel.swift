import UIKit

struct FavoriteModel: Codable {
    let imageData: Data
    let text: String
    
    var image: UIImage? {
        return UIImage(data: imageData)
    }
    
    init(image: UIImage, text: String) {
        self.imageData = image.pngData() ?? Data()
        self.text = text
    }
    
    private enum CodingKeys: String, CodingKey {
        case imageData = "image"
        case text
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageData = try container.decode(Data.self, forKey: .imageData)
        self.text = try container.decode(String.self, forKey: .text)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(imageData, forKey: .imageData)
        try container.encode(text, forKey: .text)
    }
}

