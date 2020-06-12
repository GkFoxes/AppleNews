//
//  TodayViewController.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий on 17.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import PravdaUIKit

final class TodayViewController: UIViewController {

	init() {
		super.init(nibName: nil, bundle: nil)
		self.title = StringConstants.todayTabTitle
		self.navigationItem.title = StringConstants.todayNavigationTitle
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.view.backgroundColor = .red

		if let splitController = self.splitViewController {
			self.navigationItem.leftBarButtonItem = splitController.displayModeButtonItem
		}
	}
}
