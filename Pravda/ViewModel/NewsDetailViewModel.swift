//
//  DetailNewsViewModel.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 18/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class NewsDetailViewModel: NewsDetailViewModelType {
   
    private var article: NewsAPI
    
    var title: String? {
        return article.title ?? nil
    }
    var detailText: String? {
        return article.description ?? nil
    }
    
    var author: String? {
        guard let source = article.source else { return "" }
        return source.name ?? nil
    }
    
    var link: String? {
        return article.url ?? nil
    }
    
    var photoString: String? {
        return article.urlToImage ?? nil
    }
    
    var imageCache = NSCache<AnyObject, UIImage>()
    
    init(article: NewsAPI) {
        self.article = article
    }
    
    // MARK: - Networking
    
    func getPhoto(toImageView imageView: UIImageView, withImageBlur imageBlur: UIImageView, activityIndicator: UIActivityIndicatorView, completion: @escaping(UIImage) -> ()) {
        activityIndicator.startAnimating()
        guard let textLink = link else { return }
        guard let urlImage = photoString else {
            activityIndicator.isHidden = true
            imageView.isHidden = true
            imageBlur.isHidden = true
            return
        }
        print(urlImage)
        NetworkManager.obtainImage(toUrl: urlImage, with: textLink, forCache:imageCache) { (image) in
            let setImage = image
            completion(setImage)
        }
    }
}
