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

		let todayNavigationViewController = UINavigationController(rootViewController: TodayViewController())
		let spotlightNavigationViewController = UINavigationController(rootViewController: SpotlightViewController())
		let splitViewController = UISplitViewController()
		splitViewController.viewControllers = [todayNavigationViewController, spotlightNavigationViewController]

		window.rootViewController = splitViewController
		window.makeKeyAndVisible()
	}
}
