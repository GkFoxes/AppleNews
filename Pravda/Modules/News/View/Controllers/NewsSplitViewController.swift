//
//  MainSplitViewController.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 19/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class NewsSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        self.delegate = self
        self.preferredDisplayMode = .allVisible
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

