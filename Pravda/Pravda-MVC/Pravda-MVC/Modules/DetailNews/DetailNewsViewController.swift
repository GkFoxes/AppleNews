//
//  DetailNewsViewController.swift
//  Pravda-MVC
//
//  Created by Дмитрий Матвеенко on 05.08.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import PravdaUIKit

class DetailNewsViewController: UIViewController {

	// MARK: Views

	private let detailNewsView = DetailNewsView()

	// MARK: Life Cycle

	public override func loadView() {
		self.view = detailNewsView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
