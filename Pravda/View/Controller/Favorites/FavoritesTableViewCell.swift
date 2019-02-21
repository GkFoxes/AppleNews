//
//  FavoritesTableViewCell.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 21/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    weak var favoritesViewModel: FavoritesTableViewCellViewModelType? {
        willSet(favoritesViewModel) {
            guard let favoritesViewModel = favoritesViewModel else { return }
            
            titleLabel.text = favoritesViewModel.title
            authorLabel.text = favoritesViewModel.author
            dateLabel.text = favoritesViewModel.date
            favoriteImageView.image = favoritesViewModel.image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
