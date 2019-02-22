//
//  FavoritesTableViewController.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 21/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit
import SafariServices

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
        
        let favoritesCellViewModel = favoritesViewModel.cellViewModel(forIndexPath: indexPath)
        
        favoritesCell.favoritesViewModel = favoritesCellViewModel
        
        return favoritesCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let favoritesViewModel = favoritesViewModel else { return }
        guard let favoritesNews = favoritesViewModel.favoritesNews else { return }
        guard let link = favoritesNews[indexPath.row].url else { return }
        
        if let url = URL(string: link) {
            if  UIApplication.shared.canOpenURL(url) {
                let svc = SFSafariViewController(url: url)
                self.present(svc, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Can not open this website", message: "Please check the existence of the website", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
