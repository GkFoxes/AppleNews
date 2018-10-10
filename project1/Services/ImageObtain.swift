//
//  ImageObtain.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 10/10/2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit

extension StartDetailViewController {
    func obtainImage(with text: String, completion: @escaping (UIImage) -> ()) {
        if let image = shared.imageCache.object(forKey: text as AnyObject) {
            completion(image)
        } else {
            let request = URLRequest(url: URL(string: photoString)!)
            
            URLSession.shared.dataTask(with: request) { (data, responce, error) in
                guard error == nil else {
                    print("Error: \(String(describing:error?.localizedDescription))")
                    DispatchQueue.main.async {
                        self.imageDetail.image = #imageLiteral(resourceName: "primer")
                        self.imageBlurDetail.image = #imageLiteral(resourceName: "primer")
                    }
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                    shared.imageCache.setObject(image, forKey: text as AnyObject)
                }
                }.resume()
        }
    }
}

extension FavoritesDetailViewController {
    func obtainImage(with text: String, completion: @escaping (UIImage) -> ()) {
        if let image = shared.imageCache.object(forKey: text as AnyObject) {
            completion(image)
        } else {
            let request = URLRequest(url: URL(string: photoString)!)
            
            URLSession.shared.dataTask(with: request) { (data, responce, error) in
                guard error == nil else {
                    print("Error: \(String(describing:error?.localizedDescription))")
                    DispatchQueue.main.async {
                        self.imageDetail.image = #imageLiteral(resourceName: "primer")
                        self.imageBlurDetail.image = #imageLiteral(resourceName: "primer")
                    }
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                    shared.imageCache.setObject(image, forKey: text as AnyObject)
                }
                }.resume()
        }
    }
}

extension FavoritesTableViewController {
    func obtainImage(with text: String, to: String, completion: @escaping (UIImage) -> ()) {
        if let image = shared.imageCache.object(forKey: text as AnyObject) {
            completion(image)
        } else {
            let request = URLRequest(url: URL(string: to)!)
            
            URLSession.shared.dataTask(with: request) { (data, responce, error) in
                guard error == nil else {
                    print("Error: \(String(describing:error?.localizedDescription))")
                    var image = UIImage()
                    image = #imageLiteral(resourceName: "primer")
                    completion(image)
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                    self.shared.imageCache.setObject(image, forKey: text as AnyObject)
                }
                }.resume()
        }
    }
}
