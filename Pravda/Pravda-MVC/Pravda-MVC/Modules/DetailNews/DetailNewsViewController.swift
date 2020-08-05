//
//  DetailNewsViewController.swift
//  Pravda-MVC
//
//  Created by Дмитрий Матвеенко on 05.08.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import Models
import PravdaUIKit

public protocol DetailNewsViewControllerProtocol: UIViewController {
	func setItem(_ detailNews: DetailNewsItem)
}

class DetailNewsViewController: UIViewController {

	// MARK: Views

	private let detailNewsView: DetailNewsViewProtocol = DetailNewsView()

	// MARK: Life Cycle

	public override func loadView() {
		self.view = detailNewsView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

// MARK: Setup Interface

extension DetailNewsViewController: DetailNewsViewControllerProtocol {
	public func setItem(_ detailNews: DetailNewsItem) {
		detailNewsView.setItem(detailNews)
	}
}
