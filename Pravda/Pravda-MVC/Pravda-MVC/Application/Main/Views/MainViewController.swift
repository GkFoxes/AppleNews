//
//  MainViewController.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий on 20.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	// MARK: Properties

	/// The interface is always compact, except when the width and height are equal to (.regular, .regular)
	var isInterfaceCompact: Bool?

	// MARK: View Controllers

	private var sectionsTabBarController = UITabBarController()
	private let todayNavigationViewController = UINavigationController(rootViewController: TodayViewController())
	private let spotlightNavigationViewController = UINavigationController(rootViewController: SpotlightViewController())
	private let favoritesNavigationViewController = UINavigationController(rootViewController: FavoritesViewController())

	private var regularInterfaceSplitViewController: UISplitViewController?
	private var compactInterfaceTabBarController: UITabBarController?

	// MARK: Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()

		initialInterface()
	}

	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		changeInterfaceIfNeeded()
	}
}

// MARK: Setup Interface

private extension MainViewController {
	func initialInterface() {
		switch getHorizontalAndVerticalSizeClasses() {
		case (.regular, .regular):
			isInterfaceCompact = false
			setupRegularInterfaceToFront()
		default:
			isInterfaceCompact = true
			setupCompactInterfaceToFront()
		}
	}

	func setupRegularInterfaceToFront(withSelectedIndex selectedIndex: Int = 0) {
		//In regular always two sections in master view
		sectionsTabBarController.viewControllers = [
			spotlightNavigationViewController,
			favoritesNavigationViewController
		]

		sectionsTabBarController.selectedIndex = selectedIndex
		regularInterfaceSplitViewController = UISplitViewController()

		guard let regularInterfaceSplitViewController = regularInterfaceSplitViewController else { return }
		regularInterfaceSplitViewController.viewControllers = [
			sectionsTabBarController,
			todayNavigationViewController
		]

		add(asChild: regularInterfaceSplitViewController)
	}

	func setupCompactInterfaceToFront() {
		//In compact always three sections in tab
		sectionsTabBarController.viewControllers = [
			todayNavigationViewController,
			spotlightNavigationViewController,
			favoritesNavigationViewController
		]

		//To select first section, even after changing interface size class
		sectionsTabBarController.selectedIndex = 0
		compactInterfaceTabBarController = sectionsTabBarController

		guard let compactInterfaceTabBarController = compactInterfaceTabBarController else { return }
		add(asChild: compactInterfaceTabBarController)
	}

	func add(asChild childViewController: UIViewController) {
		addChild(childViewController)
		self.view.addSubview(childViewController.view)

		childViewController.view.frame = self.view.bounds
		childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		childViewController.didMove(toParent: self)
	}

	func remove(asChild childViewController: UIViewController) {
		childViewController.willMove(toParent: nil)
		childViewController.view.removeFromSuperview()
		childViewController.removeFromParent()
	}
}

// MARK: Size Class Change Interface

private extension MainViewController {
	func changeInterfaceIfNeeded() {
		switch getHorizontalAndVerticalSizeClasses() {
		case (.regular, .regular):
			guard isInterfaceCompact != false else { return }
			isInterfaceCompact = false
			changeInterfaceToRegularAppearance()
		default:
			guard isInterfaceCompact != true else { return }
			isInterfaceCompact = true
			changeInterfaceToCompactAppearance()
		}
	}

	func changeInterfaceToRegularAppearance() {
		if let compactInterfaceTabBarController = compactInterfaceTabBarController {
			remove(asChild: compactInterfaceTabBarController)
		}

		//To select the same section, even after changing interface size class
		var selectedIndex = sectionsTabBarController.selectedIndex

		//When change interface from compact to regular
		if sectionsTabBarController.viewControllers?.count == 3 {
			sectionsTabBarController.viewControllers?.removeLast()
			selectedIndex -= 1
		}

		setupRegularInterfaceToFront(withSelectedIndex: selectedIndex)
	}

	func changeInterfaceToCompactAppearance() {
		if let regularInterfaceSplitViewController = regularInterfaceSplitViewController {
			remove(asChild: regularInterfaceSplitViewController)
		}

		setupCompactInterfaceToFront()
	}
}
