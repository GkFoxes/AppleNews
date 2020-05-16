//
//  MainTabBarController.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 19/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

	@IBInspectable var defaultIndex: Int = 0

	override func viewDidLoad() {
		super.viewDidLoad()
		selectedIndex = defaultIndex
	}
}
