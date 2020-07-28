//
//  MainContainerViewController.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий on 20.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

final class MainContainerViewController: UIViewController {

	// MARK: Properties

	/// The interface is always compact, except when the width and height are equal to (.regular, .regular)
	private var isInterfaceCompact: Bool?

	// MARK: Views

	private let mainContainerView: MainContainerViewProtocol = MainContainerView()

	// Main Tab have only Sections TabBar in Compact interface.
	// But in Regular interface have Sections in Master and first section in Detail.
	private let firstSectionViewController: UIViewController
	private let sectionsTabBarController: SectionsTabBarControllerProtocol
	private let regularInterfaceSplitViewController: RegularInterfaceSplitViewControllerProtocol

	// MARK: Life Cycle

	init(
		firstSectionViewController: UIViewController,
		sectionsTabBarController: SectionsTabBarControllerProtocol,
		regularInterfaceSplitViewController: RegularInterfaceSplitViewControllerProtocol
	) {
		self.firstSectionViewController = firstSectionViewController
		self.sectionsTabBarController = sectionsTabBarController
		self.regularInterfaceSplitViewController = regularInterfaceSplitViewController

		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func loadView() {
		self.view = mainContainerView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setupInterface()
	}

	// MARK: Changes Cycle

	/// Change interface to compact or regular only on iPad.
	public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		changeInterfaceIfNeeded()
	}
}

// MARK: Setup Interface

private extension MainContainerViewController {
	func setupInterface() {
		switch getHorizontalAndVerticalSizeClasses() {
		case (.regular, .regular): setupRegularInterfaceToFront()
		default: setupCompactInterfaceToFront()
		}
	}

	func setupRegularInterfaceToFront() {
		isInterfaceCompact = false
		sectionsTabBarController.setupRegularInterface()
		add(asChild: regularInterfaceSplitViewController)
	}

	func setupCompactInterfaceToFront() {
		isInterfaceCompact = true
		sectionsTabBarController.setupCompactInterface()
		add(asChild: sectionsTabBarController)
	}
}

// MARK: Size Class Change Interface

private extension MainContainerViewController {
	func changeInterfaceIfNeeded() {
		switch getHorizontalAndVerticalSizeClasses() {
		case (.regular, .regular):
			guard isInterfaceCompact != false else { return }
			changeInterfaceToRegularAppearance()
		default:
			guard isInterfaceCompact != true else { return }
			changeInterfaceToCompactAppearance()
		}
	}

	func changeInterfaceToRegularAppearance() {
		isInterfaceCompact = false

		sectionsTabBarController.changeInterfaceToRegularAppearance()
		remove(asChild: sectionsTabBarController)

		regularInterfaceSplitViewController.setupRegularInterfaceViewControllersIfNeeded()
		add(asChild: regularInterfaceSplitViewController)
	}

	func changeInterfaceToCompactAppearance() {
		isInterfaceCompact = true

		sectionsTabBarController.changeInterfaceToCompactAppearance(
			with: regularInterfaceSplitViewController.previousSplitDisplayMode)

		remove(asChild: regularInterfaceSplitViewController)
		add(asChild: sectionsTabBarController)
	}
}

// MARK: Changing Hierarchy

private extension MainContainerViewController {
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