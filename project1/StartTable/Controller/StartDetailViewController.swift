//
//  StartDetailViewController.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 16.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import SafariServices

class StartDetailViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBAction func openWithSafari(sender: AnyObject) {
        if let girlUrl = URL(string: girlLink) {
            let svc = SFSafariViewController(url: girlUrl)
            self.present(svc, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Can not open this website", message: "Please check the existence of the website", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var textOnButton: UIButton!

    var girlBiography = ""
    var girlLink = ""
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true  

        detailLabel.text = girlBiography
        textOnButton.setTitle(girlLink, for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
