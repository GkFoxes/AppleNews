//
//  StartDetailViewController.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 16.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit

class StartDetailViewController: UIViewController {
    
    @IBOutlet weak var detailLabel: UITextView!
    var girlName = "Detail"
    var girlBiography = "Biography"
    var girlLink = "Link"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = girlName
        detailLabel.text = girlBiography
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
