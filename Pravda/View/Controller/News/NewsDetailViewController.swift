//
//  DetailViewController.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 04/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

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
        
        detailViewModel.getPhoto(toImageView: imageDetail, withImageBlur: imageBlurDetail, activityIndicator: activityPhotoView) { (image) in
            DispatchQueue.main.async {
                self.activityPhotoView.stopAnimating()
                self.imageDetail.image = image
                self.imageBlurDetail.image = image
            }
        }
    }
    
    @IBAction func openWithSafari(_ sender: Any) {
        
    }
}
