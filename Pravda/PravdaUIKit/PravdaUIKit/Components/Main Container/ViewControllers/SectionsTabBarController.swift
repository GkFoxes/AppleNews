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
	func setupRegularInterface()
	func setupCompactInterface()
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

	override func viewDidLoad() {
		super.viewDidLoad()

		setupDesignAppearances()
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
	func setupRegularInterface() {
		// In regular always two sections in tab
		self.viewControllers = [
			secondSectionViewController,
			thirdSectionViewController
		]
	}

	func setupCompactInterface() {
		// In compact always three sections in tab
		self.viewControllers = [
			firstSectionViewController,
			secondSectionViewController,
			thirdSectionViewController
		]
	}

	func changeInterfaceToRegularAppearance() {
		isSafariNewsTapped = false

		self.viewControllers?.removeFirst()
	}

	func changeInterfaceToCompactAppearance(with displayMode: UISplitViewController.DisplayMode?) {
		var selectedIndex = self.selectedIndex

		if isSafariNewsTapped == true {
			// If change size classes when read news in Safari, show index where tap came from
			isSafariNewsTapped = false
			selectedIndex += 1
		} else {
			if displayMode == .primaryOverlay {
				//If Master view in read, show it in tabs
				selectedIndex += 1
			} else {
				selectedIndex = 0
			}
		}

		self.viewControllers?.insert(firstSectionViewController, at: 0)
		self.selectedIndex = selectedIndex
	}
}

// MARK: Setup Design Appearances

private extension SectionsTabBarController {
	func setupDesignAppearances() {
		let appearance = UITabBarAppearance()
		appearance.backgroundColor = .systemBackground

		let selectedColor = UIColor.systemPink
		appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
		appearance.inlineLayoutAppearance.selected.iconColor = selectedColor
		appearance.compactInlineLayoutAppearance.selected.iconColor = selectedColor

		let selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: selectedColor]
		appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedTitleTextAttributes
		appearance.inlineLayoutAppearance.selected.titleTextAttributes = selectedTitleTextAttributes
		appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = selectedTitleTextAttributes

		tabBar.standardAppearance = appearance
	}
}
