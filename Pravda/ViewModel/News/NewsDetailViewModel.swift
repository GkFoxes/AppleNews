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
    
    func getPhoto(completion: @escaping(UIImage) -> ()) {
        guard let textLink = link else { return }
        guard let urlImage = photoString else { return }

        NetworkManager.obtainImage(toUrl: urlImage, with: textLink, forCache:imageCache) { (image) in
            let setImage = image
            completion(setImage)
        }
    }
    
    func setBlur(forImageView imageView: UIImageView) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.addSubview(blurEffectView)
    }
}
