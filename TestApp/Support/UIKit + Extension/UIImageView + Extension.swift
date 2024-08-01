import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit, compressionFactor: CGFloat = 1, completion: ((UIImage)->Void)? = nil) {
        contentMode = mode
        let request = URLRequest(url: url, timeoutInterval: 5)
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.global(qos: .utility).async { [weak self] in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let compressedData = UIImage(data: data)?.jpegData(compressionQuality: compressionFactor),
                    let image = UIImage(data: compressedData)
                else {
                    DispatchQueue.main.async(qos: .background) { [weak self] in
                        self?.image = .placeholder
                        completion?(.placeholder)
                    }
                    return
                }
            DispatchQueue.main.async(qos: .background) { [weak self] in
                    self?.image = image
                    completion?(image)
                }
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit, compressionFactor: CGFloat = 1, completion: ((UIImage)->Void)? = nil) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode, compressionFactor: compressionFactor, completion: completion)
    }
}
