//
//  UIImageView+ImageCache.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/11.
//

import UIKit

extension UIImageView {
    func setImage(with url: String) {
        DispatchQueue.global(qos: .background).async {
            let cachedKey = NSString(string: url)
            if let cachedImage = ImageCacheService.shared.object(forKey: cachedKey) {
                DispatchQueue.main.async { [weak self] in
                    self?.image = cachedImage
                }
                return
            }
            
            guard let url = URL(string: url) else { return }
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                guard error == nil else {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = UIImage()
                    }
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    if let data = data, let image = UIImage(data: data) {
                        ImageCacheService.shared.setObject(image, forKey: cachedKey)
                        self?.image = image
                    }
                }
            }.resume()
        }
    }
}
