//
//  FavoritesTableViewController.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 21/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    private let identifier = String(describing: FavoritesTableViewCell.self)
    
    private var favoritesViewModel: FavoritesTableViewViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesViewModel = FavoritesViewModel()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesViewModel?.numberOfRows() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FavoritesTableViewCell
        
         guard let favoritesCell = cell, let favoritesViewModel = favoritesViewModel else { return UITableViewCell() }
        
        favoritesCell.titleLabel.layer.cornerRadius = 10
        favoritesCell.titleLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        favoritesCell.titleLabel.layer.masksToBounds = true
        favoritesCell.favoriteImageView.layer.cornerRadius = 10
        favoritesCell.favoriteImageView.layer.masksToBounds = true
        
        let favoritesCellViewModel = favoritesViewModel.cellViewModel(forIndexPath: indexPath)
        
        favoritesCell.favoritesViewModel = favoritesCellViewModel
        
        return favoritesCell
    }
}
