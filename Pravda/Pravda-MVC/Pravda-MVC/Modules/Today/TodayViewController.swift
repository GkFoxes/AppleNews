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

	private var todayView: TodayViewProtocol {
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

		setupSplitViewAppearancesIfNeeded()
		self.navigationController?.setupBlackDesignAppearances()
		self.view = createTodayView()
	}

	// MARK: Changes Cycle

	public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)

		setupSplitViewAppearancesIfNeeded()
		todayView.updateCollectionView(isCollectionCompact: isCollectionCompact, items: getTodayNewsItems())
	}
}

// MARK: Setup Split View

extension TodayViewController: UISplitViewControllerDelegate {
	func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewController.DisplayMode) {
		setNavigationItem(svc, displayMode: displayMode)
	}

	private func setupSplitViewAppearancesIfNeeded() {
		// After viewDidLoad() delegate == nil, at the moment when view is loaded in compact, and after rise to regular
		if splitViewController?.delegate == nil {
			splitViewController?.delegate = self
		}

		setNavigationItem(splitViewController, displayMode: splitViewController?.displayMode)
	}

	private func setNavigationItem(
		_ splitViewController: UISplitViewController?,
		displayMode: UISplitViewController.DisplayMode?
	) {
		if let splitViewController = splitViewController as? SplitViewDisplayModeButtonItem,
			displayMode == .primaryHidden {
			navigationItem.leftBarButtonItem = splitViewController.getDisplayModeButtonItem()
		} else {
			navigationItem.leftBarButtonItem = nil
		}
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
		navigationController?.pushViewController(DetailNewsFactory.make(detailNews: item), animated: true)
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
