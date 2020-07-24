//
//  regularInterfaceSplitViewController.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 24.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

protocol RegularInterfaceSplitViewControllerProtocol: UIViewController {
	var previousSplitDisplayMode: UISplitViewController.DisplayMode? { get }
	func setViewControllers(_ viewControllers: [UIViewController])
	func setupRegularInterfaceViewControllersIfNeeded(
		sectionsTabBarController: UIViewController,
		firstSectionViewController: UIViewController)
}

final class RegularInterfaceSplitViewController: UISplitViewController {

	/// Arrangement of the split view controller’s contents Master and Detail views.
	public var previousSplitDisplayMode: UISplitViewController.DisplayMode?

	// MARK: Changes Cycle

	/// Write displayMode for correct display compact interface, when previous display regular
	public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)

		previousSplitDisplayMode = self.displayMode
	}
}

extension RegularInterfaceSplitViewController: RegularInterfaceSplitViewControllerProtocol {
	func setViewControllers(_ viewControllers: [UIViewController]) {
		self.viewControllers = viewControllers
	}

	func setupRegularInterfaceViewControllersIfNeeded(
		sectionsTabBarController: UIViewController,
		firstSectionViewController: UIViewController
	) {
		// Check if there are not two of them, we haven't added controllers to the array before
		if viewControllers.count != 2 {
			viewControllers.append(sectionsTabBarController)
			viewControllers.append(firstSectionViewController)
		}
	}
}
