//
//  SpotlightViewController.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий on 19.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import PravdaUIKit
import Models

final class SpotlightViewController: UIViewController {

	// MARK: Views

	private var spotlightView: SpotlightViewProtocol {
		guard let spotlightView = view as? SpotlightViewProtocol else { fatalError() }
		return spotlightView
	}

	// MARK: Life Cycle

	init(navigationTitle: String) {
		super.init(nibName: nil, bundle: nil)

		self.navigationItem.title = navigationTitle
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		self.view = createSpotlightView()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationController?.setupBoldDesignAppearances()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		spotlightView.viewWillAppear(animated)
	}
}

// MARK: Spotlight View

private extension SpotlightViewController {
	func createSpotlightView() -> UIView {
		let spotlightView: SpotlightViewProtocol = SpotlightView()
		spotlightView.setItems(SpotlightNewsItem.makeSpotlightMock()) // temp

		spotlightView.selectedItemHandler = { [weak self] indexPath in
			guard let self = self else { return assertionFailure() }
			self.pushTodayDetailViewController(with: indexPath)
		}

		return spotlightView
	}

	func pushTodayDetailViewController(with indexPath: IndexPath) {
		guard let item = spotlightView.getItem(for: indexPath),
			let detailNewsViewController = DetailNewsFactory.make(detailNewsItem:
				DetailNewsItem(spotlightNewsItem: item)) as? UIViewController
			else { return assertionFailure() }
		navigationController?.pushViewController(detailNewsViewController, animated: true)
	}
}
