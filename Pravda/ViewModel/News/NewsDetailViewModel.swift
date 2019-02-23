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
    
    var date: String? {
        let dateString = article.publishedAt
        let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let newFormat = DateFormatter()
        newFormat.dateFormat = "MM-dd HH:mm"
        
        guard let preDate = dateString, let date = dateFormatter.date(from: preDate) else { return nil }
        let articleDate = newFormat.string(from: date)
        
        return articleDate
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
        guard let textLink = link, let urlImage = photoString else { return }
        
        NetworkManager.obtainImage(toUrl: urlImage, with: textLink, forCache:imageCache) { (image) in
            let setImage = image
            completion(setImage)
        }
    }
    
    // MARK: - Methods
    
    func setBlur(forImageView imageView: UIImageView) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.addSubview(blurEffectView)
    }
    
    func setFavoriteButton (forNavigationItem navigationItem: UINavigationItem) {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "favoriteWhite"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(saveAdPressed), for: .touchUpInside)
        button.addTarget(self, action: #selector(favoriteTap), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func saveAdPressed(sender: UIBarButtonItem) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let favoriteArticle = FavoritesNews(context: context)
            favoriteArticle.title = title
            favoriteArticle.author = author
            favoriteArticle.publishedAt = date
            favoriteArticle.url = link
            favoriteArticle.urlToImage = photoString
            
            do {
                try context.save()
            } catch let error as NSError{
                print("\(error.userInfo)")
            }
        }
    }
    
    @objc func favoriteTap(sender: UIButton) {
        sender.setImage(UIImage(named: "favoriteRed.png"), for: .normal)
        sender.isUserInteractionEnabled = false
    }
}
