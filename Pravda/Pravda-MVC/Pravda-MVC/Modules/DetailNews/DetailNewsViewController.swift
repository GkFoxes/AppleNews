//
//  DetailNewsViewController.swift
//  Pravda-MVC
//
//  Created by Дмитрий Матвеенко on 05.08.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import Models
import PravdaUIKit

protocol DetailNewsViewControllerProtocol: UIViewController {
	func setItem(_ detailNews: DetailNewsItem)
}

final class DetailNewsViewController: UIViewController {

	// MARK: Views

	private var detailNewsView: DetailNewsViewProtocol {
		guard let detailNewsView = view as? DetailNewsViewProtocol else { fatalError() }
		return detailNewsView
	}

	// MARK: Life Cycle

	public override func loadView() {
		self.view = DetailNewsView(viewController: self)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.largeTitleDisplayMode = .never
	}
}

// MARK: Interface

extension DetailNewsViewController: DetailNewsViewControllerProtocol, SafariViewControllerDelegate {
	func setItem(_ detailNews: DetailNewsItem) {
		detailNewsView.setItem(detailNews)
	}
}
