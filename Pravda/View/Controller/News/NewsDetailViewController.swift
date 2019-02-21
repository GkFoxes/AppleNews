//
//  DetailViewController.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 04/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit
import SafariServices

class NewsDetailViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var imageBlurDetail: UIImageView!
    @IBOutlet weak var activityPhotoView: UIActivityIndicatorView!
    
    var detailViewModel: NewsDetailViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let detailViewModel = detailViewModel else { return }
        self.titleLabel.text = detailViewModel.title
        self.detailLabel.text = detailViewModel.detailText
        
        if detailViewModel.photoString != nil {
            self.activityPhotoView.startAnimating()
            detailViewModel.getPhoto() { (image) in
                DispatchQueue.main.async {
                    self.activityPhotoView.stopAnimating()
                    self.imageDetail.image = image
                    self.imageBlurDetail.image = image
                    detailViewModel.setBlur(forImageView: self.imageBlurDetail)
                }
            }
        } else {
            self.activityPhotoView.stopAnimating()
            imageDetail.image = UIImage(named: "noImage")
            imageBlurDetail.image = UIImage(named: "noImage")
        }
    }
    
    @IBAction func openWithSafari(_ sender: Any) {
        guard let detailViewModel = detailViewModel else { return }
        guard let link = detailViewModel.link else { return }
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
}
