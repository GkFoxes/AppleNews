//
//  MainContainerViewController.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий on 20.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public final class MainContainerViewController: UIViewController {

	// MARK: Properties

	/// The current arrangement of the split view controller’s contents Master and Detail views.
	private var regularInterfaceSplitDisplayMode: UISplitViewController.DisplayMode?

	/// The interface is always compact, except when the width and height are equal to (.regular, .regular).
	/// default = true
	private var isInterfaceCompact = true

	// MARK: Views

	private let mainContainerView: MainContainerViewProtocol = MainContainerView()

	// Main Tab have only Sections TabBar in Compact interface.
	// But in Regular interface have Sections in Master and Today in Detail.
	private let todayNavigationViewController: UIViewController
	private let sectionsTabBarController: SectionsTabBarControllerProtocol
	private var regularInterfaceSplitViewController = UISplitViewController()

	// MARK: Life Cycle

	public init(
		todayNavigationViewController: UIViewController,
		spotlightNavigationViewController: UIViewController,
		favoritesNavigationViewController: UIViewController
	) {
		self.todayNavigationViewController = todayNavigationViewController
		self.sectionsTabBarController = SectionsTabBarController(
			todayNavigationViewController: todayNavigationViewController,
			spotlightNavigationViewController: spotlightNavigationViewController,
			favoritesNavigationViewController: favoritesNavigationViewController
		)

		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func loadView() {
		self.view = mainContainerView
		initialInterface()
	}

	/// Change interface to compact or regular, when iPad change size classes.
	public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		changeInterfaceIfNeeded()
	}

	/// Write displayMode for correct display compact interface, when previous display regular
	public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)

		regularInterfaceSplitDisplayMode = regularInterfaceSplitViewController.displayMode
	}
}

// MARK: Setup Interface

private extension MainContainerViewController {
	func initialInterface() {
		switch getHorizontalAndVerticalSizeClasses() {
		case (.regular, .regular):
			isInterfaceCompact = false
			sectionsTabBarController.setupRegularInterface(with: 0)
			setupRegularInterfaceToFront()
		default:
			isInterfaceCompact = true
			sectionsTabBarController.setupCompactInterface(with: 0)
			setupCompactInterfaceToFront()
		}
	}

	func setupRegularInterfaceToFront() {
		regularInterfaceSplitViewController = UISplitViewController()
		regularInterfaceSplitViewController.viewControllers = [
			sectionsTabBarController,
			todayNavigationViewController
		]

		add(asChild: regularInterfaceSplitViewController)
	}

	func setupCompactInterfaceToFront() {
		add(asChild: sectionsTabBarController)
	}

	func add(asChild childViewController: UIViewController) {
		addChild(childViewController)
		mainContainerView.add(asChild: childViewController.view)
		childViewController.didMove(toParent: self)
	}

	func remove(asChild childViewController: UIViewController) {
		childViewController.willMove(toParent: nil)
		childViewController.view.removeFromSuperview()
		childViewController.removeFromParent()
	}
}

// MARK: Size Class Change Interface

private extension MainContainerViewController {
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
		remove(asChild: sectionsTabBarController)

		sectionsTabBarController.changeInterfaceToRegularAppearance()
		setupRegularInterfaceToFront()
	}

	func changeInterfaceToCompactAppearance() {
		remove(asChild: regularInterfaceSplitViewController)

		sectionsTabBarController.changeInterfaceToCompactAppearance(with: regularInterfaceSplitDisplayMode)
		setupCompactInterfaceToFront()
	}
}
