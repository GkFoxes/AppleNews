//
//  SectionsTabBarController.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 27.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public protocol SafariNewsTappedProtocol: UIViewController {
	func safariNewsTapped()
}

protocol SectionsTabBarControllerProtocol: UIViewController {
	func setupRegularInterface(with selectedIndex: Int)
	func setupCompactInterface(with selectedIndex: Int)
	func changeInterfaceToRegularAppearance()
	func changeInterfaceToCompactAppearance(with displayMode: UISplitViewController.DisplayMode?)
}

final class SectionsTabBarController: UITabBarController {

	// MARK: Properties

	/// When Safari news tapped from second or third sections, changes in selectedIndex
	/// default = false
	private var isSafariNewsTapped = false

	// MARK: View Controllers

	// Sections Tab have first, second, third in Compact interface.
	// But in Regular interface Tab have only second, third.
	private let firstSectionViewController: UIViewController
	private let secondSectionViewController: UIViewController
	private let thirdSectionViewController: UIViewController

	// MARK: Life Cycle

	init(
		firstSectionViewController: UIViewController,
		secondSectionViewController: UIViewController,
		thirdSectionViewController: UIViewController
	) {
		self.firstSectionViewController = firstSectionViewController
		self.secondSectionViewController = secondSectionViewController
		self.thirdSectionViewController = thirdSectionViewController

		super.init(nibName: nil, bundle: nil)
	}

	override func loadView() {
		super.loadView()

		setupDeisgnAppearances()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Changes From Sections

extension SectionsTabBarController: SafariNewsTappedProtocol {
	func safariNewsTapped() {
		isSafariNewsTapped = true
	}
}

// MARK: Changes From MainContainer

extension SectionsTabBarController: SectionsTabBarControllerProtocol {
	func setupRegularInterface(with selectedIndex: Int) {
		// In regular always two sections in tab
		viewControllers = [
			secondSectionViewController,
			thirdSectionViewController
		]

		self.selectedIndex = selectedIndex
	}

	func setupCompactInterface(with selectedIndex: Int) {
		// In compact always three sections in tab
		viewControllers = [
			firstSectionViewController,
			secondSectionViewController,
			thirdSectionViewController
		]

		self.selectedIndex = selectedIndex
	}

	func changeInterfaceToRegularAppearance() {
		guard viewControllers?.count == 3 else {
			//To select the same section, even after changing interface to regular
			return setupRegularInterface(with: selectedIndex)
		}

		// Remove first section from sections and after setup selected Index
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
				//If Master view hidden or first section in read, show it in compact tab
				selectedIndex = 0
			} else {
				selectedIndex += 1
			}
		}

		setupCompactInterface(with: selectedIndex)
	}
}

// MARK: Design

private extension SectionsTabBarController {
	func setupDeisgnAppearances() {
		let appearance = UITabBarAppearance()
		appearance.backgroundColor = .systemBackground

		let selectedColor = UIColor.systemPink

		appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
		appearance.inlineLayoutAppearance.selected.iconColor = selectedColor
		appearance.compactInlineLayoutAppearance.selected.iconColor = selectedColor

		let selectedTitleTextAttributes = [
			NSAttributedString.Key.foregroundColor: selectedColor
		]

		appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedTitleTextAttributes
		appearance.inlineLayoutAppearance.selected.titleTextAttributes = selectedTitleTextAttributes
		appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = selectedTitleTextAttributes

		tabBar.standardAppearance = appearance
	}
}
