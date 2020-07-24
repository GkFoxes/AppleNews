//
//  regularInterfaceSplitViewController.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 24.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

protocol RegularInterfaceSplitViewControllerProtocol: UIViewController {
	var previousSplitDisplayMode: UISplitViewController.DisplayMode? { get }
	func setupRegularInterfaceViewControllersIfNeeded()
}

final class RegularInterfaceSplitViewController: UISplitViewController {

	// MARK: Properties

	/// Arrangement of the split view controller’s contents Master and Detail views.
	public var previousSplitDisplayMode: UISplitViewController.DisplayMode?

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

		viewControllers = [sectionsTabBarController, firstSectionViewController]
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: Changes Cycle

	/// Write displayMode for correct display compact interface, when previous display regular
	public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)

		previousSplitDisplayMode = self.displayMode
	}
}

// MARK: Changes From MainContainer

extension RegularInterfaceSplitViewController: RegularInterfaceSplitViewControllerProtocol {
	func setupRegularInterfaceViewControllersIfNeeded() {
		// Check if there are not two of them, we haven't added controllers to the array before
		if viewControllers.count != 2 {
			viewControllers.append(sectionsTabBarController)
			viewControllers.append(firstSectionViewController)
		}
	}
}
