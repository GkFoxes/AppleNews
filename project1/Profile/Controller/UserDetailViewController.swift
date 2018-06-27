//
//  UserDetailViewController.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 27.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var name: String!
    var email: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name
        emailLabel.text = email
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
