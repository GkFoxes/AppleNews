//
//  SceneDelegate.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий on 17.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	// MARK: Properties

	var window: UIWindow?

	// MARK: UIWindowSceneDelegate

	func scene(_ scene: UIScene,
			   willConnectTo session: UISceneSession,
			   options connectionOptions: UIScene.ConnectionOptions) {
		setupRootViewController(from: scene)
	}
}

private extension SceneDelegate {
	func setupRootViewController(from scene: UIScene) {
		guard let windowScene = (scene as? UIWindowScene) else { return assertionFailure() }
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)

		guard let window = window else { return assertionFailure() }
		window.windowScene = windowScene
		window.rootViewController = getRootViewController()
		window.makeKeyAndVisible()
	}

	func getRootViewController() -> UIViewController {
		let todayNavigationViewController = UINavigationController(rootViewController: TodayViewController())
		let spotlightNavigationViewController = UINavigationController(rootViewController: SpotlightViewController())
		let favoritesNavigationViewController = UINavigationController(rootViewController: FavoritesViewController())

		switch UIDevice.current.userInterfaceIdiom {
		case .phone:
			let mainTabBarController = UITabBarController()
			mainTabBarController.viewControllers = [
				todayNavigationViewController,
				spotlightNavigationViewController,
				favoritesNavigationViewController
			]

			return mainTabBarController
		case .pad:
			let sectionsTabBarController = UITabBarController()
			sectionsTabBarController.viewControllers = [spotlightNavigationViewController, favoritesNavigationViewController]

			let splitViewController = UISplitViewController()
			splitViewController.preferredDisplayMode = .allVisible
			splitViewController.viewControllers = [sectionsTabBarController, todayNavigationViewController]
			return splitViewController
		case .unspecified, .tv, .carPlay:
			fatalError()
		@unknown default:
			fatalError()
		}
	}
}
