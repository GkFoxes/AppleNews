//
//  regularInterfaceSplitViewController.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 24.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public protocol SplitViewDisplayModeButtonItem: UISplitViewController {
	func getDisplayModeButtonItem() -> UIBarButtonItem
}

protocol RegularInterfaceSplitViewControllerProtocol: UISplitViewController {
	func setupRegularInterfaceViewControllersIfNeeded()
}

final class RegularInterfaceSplitViewController: UISplitViewController {

	// MARK: View Controllers

	let sectionsTabBarController: UIViewController
	let firstSectionViewController: UIViewController

	// MARK: Life Cycle

	init(
		sectionsTabBarController: UIViewController,
		firstSectionViewController: UIViewController
	) {
		self.sectionsTabBarController = sectionsTabBarController
		self.firstSectionViewController = firstSectionViewController

		super.init(nibName: nil, bundle: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setViewControllers()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Changes From MainContainer

extension RegularInterfaceSplitViewController: RegularInterfaceSplitViewControllerProtocol {
	public func setupRegularInterfaceViewControllersIfNeeded() {
		setViewControllers()
	}
}

// MARK: DisplayModeButtonItem Interface

extension RegularInterfaceSplitViewController: SplitViewDisplayModeButtonItem {
	public func getDisplayModeButtonItem() -> UIBarButtonItem {
		let buttonItemImage = UIImage(systemName: "square.righthalf.fill")?.withTintColor(
			.systemPink, renderingMode: .alwaysOriginal)
		let buttonItem = UIBarButtonItem(
			image: buttonItemImage,
			style: .plain,
			target: self.displayModeButtonItem.target,
			action: self.displayModeButtonItem.action)
		return buttonItem
	}
}

// MARK: ViewControllers

private extension RegularInterfaceSplitViewController {
	func setViewControllers() {
		viewControllers = [sectionsTabBarController, firstSectionViewController]
	}
}
