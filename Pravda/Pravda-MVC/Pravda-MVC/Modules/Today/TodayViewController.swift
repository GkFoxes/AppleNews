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

//	override func loadView() {
//		view = shareView
//	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationController?.setupBlackDesignAppearances()
		self.view = createTodayView(isCollectionCompact: isCollectionCompact, frame: self.view.bounds)

		/*
		if let splitController = self.splitViewController {
			self.navigationItem.leftBarButtonItem = splitController.displayModeButtonItem
		}*/
	}
}

// MARK: Setup View

private extension TodayViewController {
	func createTodayView(isCollectionCompact: Bool, frame: CGRect) -> UIView {
		let view: TodayViewProtocol = TodayView(isCollectionCompact: isCollectionCompact, frame: self.view.bounds)

		let todayNewsItems = TodayNewsItems(
			topStoriesItems: TodayNewsItem.makeTopStoriesMock(isOnlyOneItem: isCollectionCompact),
			otherTopStoriesItems: TodayNewsItem.makeOtherTopStoriesMock(),
			scienceItems: TodayNewsItem.makeScienceMock(isOnlyOneItem: isCollectionCompact),
			otherScienceItems: TodayNewsItem.makeOtherScienceMock())

		view.setItems(todayNewsItems)
		view.selectedItemHandler = { [weak self] indexPath in
			guard let self = self else { return assertionFailure() }
			self.pushTodayDetailViewController(from: view, with: indexPath)
		}

		return view
	}

	func pushTodayDetailViewController(from view: TodayViewProtocol, with indexPath: IndexPath) {
		guard let item = view.getItem(for: indexPath) else { return }
		print(item)
		//let photoDetailVC = PhotoDetailViewController(photoURL: item.photoURL)
		//navigationController?.pushViewController(photoDetailVC, animated: true)
	}
}
