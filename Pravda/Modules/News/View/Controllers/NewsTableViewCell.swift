//
//  NewsTableViewCell.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 18/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    weak var newsViewModel: NewsTableViewCellViewModelType? {
        willSet(newsViewModel) {
            guard let newsViewModel = newsViewModel else { return }
            
            titleLabel.text = newsViewModel.title
            authorLabel.text = newsViewModel.author
            dateLabel.text = newsViewModel.date
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
