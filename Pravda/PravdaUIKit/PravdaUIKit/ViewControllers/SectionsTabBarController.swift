//
//  SectionsTabBarController.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 27.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public final class SectionsTabBarController: UITabBarController {

	// MARK: Properties

	/// When Safari news tapped from Spotlight or Favorites, changes in selectedIndex
	/// default = false
	private var isSafariNewsTapped = false

	// MARK: View Controllers

	// Sections Tab have today, spotlight, favorites in Compact interface.
	// But in Regular interface Tab have only spotlight, favorites.
	private let todayNavigationViewController: UIViewController
	private let spotlightNavigationViewController: UIViewController
	private let favoritesNavigationViewController: UIViewController

	// MARK: Life Cycle

	init(
		todayNavigationViewController: UIViewController,
		spotlightNavigationViewController: UIViewController,
		favoritesNavigationViewController: UIViewController
	) {
		self.todayNavigationViewController = todayNavigationViewController
		self.spotlightNavigationViewController = spotlightNavigationViewController
		self.favoritesNavigationViewController = favoritesNavigationViewController

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
		guard viewControllers?.count == 3 else {
			//To select the same section, even after changing interface to regular
			return setupRegularInterface(with: selectedIndex)
		}

		// Remove Today from sections and after setup selected Index
		var selectedIndex = self.selectedIndex
		viewControllers?.removeLast()
		isSafariNewsTapped = false
		selectedIndex -= 1

		setupRegularInterface(with: selectedIndex)
	}

	func changeInterfaceToCompactAppearance(with displayMode: UISplitViewController.DisplayMode?) {
		guard viewControllers?.count == 2 else {
			// To select the same section, even after changing interface to compact
			return setupCompactInterface(with: selectedIndex)
		}

		var selectedIndex = self.selectedIndex

		if isSafariNewsTapped == true {
			// If change size classes when read news in Safari, show index where tap came from
			isSafariNewsTapped = false
			selectedIndex += 1
		} else {
			if displayMode == .primaryHidden || displayMode == .allVisible {
				//If Master view hidden or Today in read, show Today in compact tab
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
