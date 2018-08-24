//
//  ProfileViewController.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 18.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ProfileViewController: UIViewController {
    
    @IBAction func loginFacebook(_ sender: Any) {
        loginFacebook()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Segues
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "userDetail" {
//            let nameFB = ""
//            let emailFB = ""
//            
//            let destinationViewController = segue.destination as! UserDetailViewController
//            destinationViewController.name = nameFB
//            destinationViewController.email = nameFB
//        }
//    }
}
