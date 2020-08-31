//
//  SpotlightViewController.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий on 19.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import PravdaUIKit

final class SpotlightViewController: UIViewController {

	init() {
		super.init(nibName: nil, bundle: nil)

		self.navigationItem.title = "Test" // temp, should use name of categories
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationController?.setupBoldDesignAppearances()
		self.view.backgroundColor = .blue
	}
}
