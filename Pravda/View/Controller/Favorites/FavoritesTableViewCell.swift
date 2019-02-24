//
//  FavoritesTableViewCell.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 21/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit
import SwipeCellKit

class FavoritesTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var shadowLabel: UILabel!
    @IBOutlet weak var activityPhotoView: UIActivityIndicatorView!
    
    var imageCache = NSCache<AnyObject, UIImage>()
    
    weak var favoritesViewModel: FavoritesTableViewCellViewModelType? {
        willSet(favoritesViewModel) {
            guard let favoritesViewModel = favoritesViewModel else { return }
            
            titleLabel.text = favoritesViewModel.title
            authorLabel.text = favoritesViewModel.author
            dateLabel.text = favoritesViewModel.date
            
            if let urlImage = favoritesViewModel.urlImage {
                self.activityPhotoView.startAnimating()
                guard let url = favoritesViewModel.url else { return }
                
                NetworkManager.obtainImage(toUrl: urlImage, with: url, forCache:imageCache) { (image) in
                    DispatchQueue.main.async {
                        self.activityPhotoView.stopAnimating()
                        self.favoriteImageView.image = image
                    }
                }
            } else {
                self.activityPhotoView.stopAnimating()
                favoriteImageView.image = UIImage(named: "noImage")
            }

            authorLabel.layer.cornerRadius = 20
            authorLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            authorLabel.layer.masksToBounds = true
            favoriteImageView.layer.cornerRadius = 20
            favoriteImageView.layer.masksToBounds = true
            shadowLabel.layer.cornerRadius = 20
            shadowLabel.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            shadowLabel.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
