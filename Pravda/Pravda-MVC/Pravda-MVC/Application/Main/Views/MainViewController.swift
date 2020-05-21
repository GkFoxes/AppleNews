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

	/// The interface is always compact, except when the width and height are equal to (.regular, .regular).
	var isInterfaceCompact: Bool?

	/// The current arrangement of the split view controller’s contents Master and Detail views.
	var regularInterfaceSplitDisplayMode: UISplitViewController.DisplayMode?

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

	/// Change interface to compact or regular, when iPad change size classes.
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		changeInterfaceIfNeeded()
	}

	/// Write correct displayMode for correct display compact interface, when previous display regular
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)

		guard let regularInterfaceSplitViewController = regularInterfaceSplitViewController else { return }
		regularInterfaceSplitDisplayMode = regularInterfaceSplitViewController.displayMode
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
		//In regular always two sections in Master view
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

	func setupCompactInterfaceToFront(withSelectedIndex selectedIndex: Int = 0) {
		//In compact always three sections in tab
		sectionsTabBarController.viewControllers = [
			todayNavigationViewController,
			spotlightNavigationViewController,
			favoritesNavigationViewController
		]

		sectionsTabBarController.selectedIndex = selectedIndex
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

		//To select the same section, even after changing interface to regular
		var selectedIndex = sectionsTabBarController.selectedIndex

		//Remove Today from sections and setup selected Index
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

		//To select the same section, even after changing interface to compact
		var selectedIndex = sectionsTabBarController.selectedIndex

		//When change interface from regular to compact
		if sectionsTabBarController.viewControllers?.count == 2 {
			//If Master view hidden or Today in read, show Today in compact tab
			if regularInterfaceSplitDisplayMode == .primaryHidden || regularInterfaceSplitDisplayMode == .allVisible {
				selectedIndex = 0
			} else {
				selectedIndex += 1
			}
		}

		setupCompactInterfaceToFront(withSelectedIndex: selectedIndex)
	}
}
