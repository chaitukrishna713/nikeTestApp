//
//  UIImageView+Extention.swift
//  nike coding test 2
//
//  Created by Chaitu Bk on 3/22/20.
//  Copyright © 2020 Chaitu Bk. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func storeImage(urlString: String, image: UIImage) {
        let path =  NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        let data = image.jpegData(compressionQuality: 0.5)
        try? data?.write(to: url)
        var cache = UserDefaults.standard.object(forKey: "ImageCache") as? [String: String]
        if cache ==  nil {
            cache = [String: String] ()
        }
        cache?[urlString] = path
        UserDefaults.standard.set(cache, forKey: "ImageCache")
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        if let cache = UserDefaults.standard.object(forKey: "ImageCache") as? [String: String],
            let path = cache[link],
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            self.image =  UIImage(data: data)
            return
        }
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
                self.storeImage(urlString: link, image: image)
            }
        }.resume()
    }
}
