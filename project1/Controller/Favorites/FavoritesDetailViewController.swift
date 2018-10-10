//
//  FavoritesDetailViewController.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 29.08.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import SafariServices
import RealmSwift

class FavoritesDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var textOnButton: UIButton!
    
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var imageBlurDetail: UIImageView!
    @IBOutlet weak var activityPhotoView: UIActivityIndicatorView!
    
    @IBAction func openWithSafari(_ sender: Any) {
        if let url = URL(string: link) {
            if  UIApplication.shared.canOpenURL(url) == true {
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
    
    var titleDetail = ""
    var descriptionText = ""
    var link = ""
    var photoString = ""
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        realm = try! Realm()
        
        titleLabel.text = titleDetail
        detailLabel.text = descriptionText
        
        if photoString != "" {
            activityPhotoView.startAnimating()
            obtainImage(with: String(link)) { (image) in
                DispatchQueue.main.async {
                    self.imageDetail.image = image
                    self.imageBlurDetail.image = image
                }
            }
            activityPhotoView.stopAnimating()
        } else {
            self.imageDetail.image = #imageLiteral(resourceName: "primer")
            self.imageBlurDetail.image = #imageLiteral(resourceName: "primer")
        }
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageBlurDetail.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageBlurDetail.addSubview(blurEffectView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
