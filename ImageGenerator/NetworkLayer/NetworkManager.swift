import UIKit

enum NetworkErrors: Error {
    case invalidResponse
    case emptyResponse
}

final class NetworkManager: NetworkProtocol {
    func fetchImage(text: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: "https://dummyimage.com/500x500&text=\(text)") else {
            DispatchQueue.main.async {
                completion(.failure(NetworkErrors.invalidResponse))
            }
            return
        }

        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else if let data = data, let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(NetworkErrors.invalidResponse))
                }
            }
        }
        
        task.resume()
    }
}

protocol NetworkProtocol {
    func fetchImage(text: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}
