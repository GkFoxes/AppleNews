//
//  FavoritesTableViewController.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 29.08.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import RealmSwift

class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageCell.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageCell.addSubview(blurEffectView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class FavoritesTableViewController: UITableViewController {
    
    @IBOutlet weak var tableFavoritesContent: UITableView!
    
    let shared = SharedManager.shared
    
    var newsRealmList: Results<NewsRealm>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm()
        
        tableFavoritesContent.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        newsRealmList = realm.objects(NewsRealm.self)
        newsRealmList = newsRealmList.sorted(byKeyPath: "createdAt", ascending: false)
        
        self.tableFavoritesContent.setEditing(false, animated: true)
        self.tableFavoritesContent.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableFavoritesContent.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if newsRealmList != nil {
            return newsRealmList.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoritesTableViewCell
        
        let item = newsRealmList[indexPath.row]
        cell.nameLabel.text = item.title
        cell.authorLabel.text = item.sourceName
        
        let dateString = item.publishedAt
        let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let newFormat = DateFormatter()
        newFormat.dateFormat = "MM.dd HH:mm"
        newFormat.locale = Locale(identifier: "ru_RU")
        
        let link = item.url
        let linkImage = item.urlToImage
        
        if linkImage != "" {
            obtainImage(with: link, to: linkImage) { (image) in
                DispatchQueue.main.async {
                    cell.imageCell.image = image
                }
            }
        } else {
            cell.imageCell.image = #imageLiteral(resourceName: "primer")
        }
        
        if let date = dateFormatter.date(from: dateString) {
            cell.dateLabel.text = newFormat.string(from: date)
        } else {
            cell.dateLabel.text = ""
        }
        
        return cell
    }
    
    // MARK: - Delete from table
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "Удалить") { (action, indexPath) in
            let item = self.newsRealmList[indexPath.row]
            try! realm.write({
                realm.delete(item)
            })
            
            tableView.deleteRows(at:[indexPath], with: .automatic)
        }
        delete.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        return [delete]
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoriteDetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                guard let details = newsRealmList else { return }
                let nameDetail = details[indexPath.row].sourceName
                let title = details[indexPath.row].title
                let descriptionDetal = details[indexPath.row].descriptionRealm
                let linkDetail = details[indexPath.row].url
                let photoDetailURL = details[indexPath.row].urlToImage
                
                let destinationViewController = segue.destination as! FavoritesDetailViewController
                
                destinationViewController.title = nameDetail
                destinationViewController.titleDetail = title
                destinationViewController.descriptionText = descriptionDetal
                destinationViewController.link = linkDetail
                destinationViewController.photoString = photoDetailURL
                
                destinationViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                destinationViewController.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
