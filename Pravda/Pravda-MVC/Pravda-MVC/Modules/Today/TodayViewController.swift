//
//  TodayViewController.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий on 17.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import Models
import PravdaUIKit

final class TodayViewController: UIViewController {

	// MARK: Views

	var todayView: TodayViewProtocol {
		guard let todayView = view as? TodayViewProtocol else { fatalError() }
		return todayView
	}

	// MARK: Properties

	private var isCollectionCompact: Bool {
		switch getHorizontalAndVerticalSizeClasses() {
		case (.compact, .regular): return true
		default: return false
		}
	}

	// MARK: Life Cycle

	init() {
		super.init(nibName: nil, bundle: nil)

		self.navigationItem.title = Strings.todayNavigationTitle.rawValue
		self.tabBarItem.title = Strings.todayTabTitle.rawValue
		self.tabBarItem.image = Assets.todayTab.image
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationController?.setupBlackDesignAppearances()
		self.view = createTodayView()

		
		//if let splitController = self.splitViewController {
			self.navigationItem.leftBarButtonItem = self.displayModeButtonItem
			//change button
		//}
	}

	// MARK: Changes Cycle

	public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		todayView.updateCollectionView(isCollectionCompact: isCollectionCompact, items: getTodayNewsItems())
	}
}

// MARK: Setup Today View

private extension TodayViewController {
	func createTodayView() -> UIView {
		let todayView: TodayViewProtocol = TodayView(isCollectionCompact: isCollectionCompact, frame: view.bounds)
		todayView.setItems(getTodayNewsItems())
		todayView.selectedItemHandler = { [weak self] indexPath in
			guard let self = self else { return assertionFailure() }
			self.pushTodayDetailViewController(with: indexPath)
		}

		return todayView
	}

	func pushTodayDetailViewController(with indexPath: IndexPath) {
		guard let item = todayView.getItem(for: indexPath) else { return }
		print(item)
	}
}

// MARK: News Items Interface

private extension TodayViewController {
	func getTodayNewsItems() -> TodayNewsItems {
		return TodayNewsItems(
			topStoriesItems: TodayNewsItem.makeTopStoriesMock(isOnlyOneItem: isCollectionCompact),
			otherTopStoriesItems: TodayNewsItem.makeOtherTopStoriesMock(),
			scienceItems: TodayNewsItem.makeScienceMock(isOnlyOneItem: isCollectionCompact),
			otherScienceItems: TodayNewsItem.makeOtherScienceMock())
	}
}
