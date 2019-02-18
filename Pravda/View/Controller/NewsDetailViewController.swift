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
    
    var detailViewModel: NewsDetailViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let detailViewModel = detailViewModel else { return }
        self.titleLabel.text = detailViewModel.title
    }
}
