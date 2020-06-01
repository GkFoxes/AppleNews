//
//  SectionsTabBarController.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 27.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import UIKit

public class SectionsTabBarController: UITabBarController {

	// MARK: Properties

	/// When Safari news tapped from Spotlight or Favorites, changes in selectedIndex
	private var isSafariNewsTapped: Bool

	// MARK: View Controllers

	/// Sections Tab have today, spotlight, favorites in Compact interface.
	/// But in Regular interface Tab have only spotlight, favorites.
	private let todayNavigationViewController: UINavigationController
	private let spotlightNavigationViewController: UINavigationController
	private let favoritesNavigationViewController: UINavigationController

	// MARK: Life Cycle

	init(
		todayNavigationViewController: UINavigationController,
		spotlightNavigationViewController: UINavigationController,
		favoritesNavigationViewController: UINavigationController
	) {
		self.todayNavigationViewController = todayNavigationViewController
		self.spotlightNavigationViewController = spotlightNavigationViewController
		self.favoritesNavigationViewController = favoritesNavigationViewController

		self.isSafariNewsTapped = false

		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func viewDidLoad() {
		super.viewDidLoad()

		initialInterface()
	}
}

// MARK: Changes From Sections

public extension SectionsTabBarController {
	func safariNewsTapped() {
		isSafariNewsTapped = true
	}
}

// MARK: Changes From MainContainer

extension SectionsTabBarController {
	func changeInterfaceToRegularAppearance() {
		// Remove Today from sections and setup selected Index
		guard viewControllers?.count == 3 else { return }
		viewControllers?.removeLast()
		isSafariNewsTapped = false

		//To select the same section, even after changing interface to regular
		let selectedIndex = self.selectedIndex - 1
		setupRegularInterface(with: selectedIndex)
	}

	func changeInterfaceToCompactAppearance(with displayMode: UISplitViewController.DisplayMode?) {
		// When change interface from regular to compact
		guard viewControllers?.count == 2 else { return }

		// To select the same section, even after changing interface to regular
		var selectedIndex = self.selectedIndex

		// If change size classes when read news in Safari, show index where tap came from
		if isSafariNewsTapped == true {
			isSafariNewsTapped = false
			selectedIndex += 1
		} else {
			//If Master view hidden or Today in read, show Today in compact tab
			if displayMode == .primaryHidden || displayMode == .allVisible {
				selectedIndex = 0
			} else {
				selectedIndex += 1
			}
		}

		setupCompactInterface(with: selectedIndex)
	}
}

// MARK: Setup Interface

private extension SectionsTabBarController {
	func initialInterface() {
		switch getHorizontalAndVerticalSizeClasses() {
		case (.regular, .regular):
			setupRegularInterface()
		default:
			setupCompactInterface()
		}
	}

	func setupRegularInterface(with selectedIndex: Int = 0) {
		// In regular always two sections in tab
		viewControllers = [
			spotlightNavigationViewController,
			favoritesNavigationViewController
		]

		self.selectedIndex = selectedIndex
	}

	func setupCompactInterface(with selectedIndex: Int = 0) {
		// In compact always three sections in tab
		viewControllers = [
			todayNavigationViewController,
			spotlightNavigationViewController,
			favoritesNavigationViewController
		]

		self.selectedIndex = selectedIndex
	}
}
