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
    
    func loginFacebook() -> Void {
        let login: FBSDKLoginManager = FBSDKLoginManager()
        
        login.logIn(withReadPermissions: ["email", "public_profile"], from: self, handler: {(result, error) -> Void in
            if error != nil {
                NSLog("Process error")
            } else if (result?.isCancelled)! {
                NSLog("Cancelled")
            } else {
                let parameters = ["fields": "email, name, first_name, last_name, gender, picture",]
                FBSDKGraphRequest(graphPath: "me", parameters: parameters).start {(connection, result, error) -> Void in
                    if error != nil {
                        NSLog(error.debugDescription)
                        return
                    }
                    if let result = result as? [String: AnyObject], let email: String = result["email"] as! String?, let fbId: String = result["id"] as! String?, let name: String = result["name"] as! String? {
                        
                        print("fbID: \(fbId)")
                        print("name: \(name)")
                        print("Email: \(email)")
                        
                        //let picture = result["picture"] as? [String: AnyObject]
                        //let data = picture?["data"] as? [String: AnyObject]
                        //let imageURL = data?["url"] as! NSString
                        
                        self.view .endEditing(true)
                        
                        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
                        vc.name = name
                        vc.email = email
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        })
    }
}
