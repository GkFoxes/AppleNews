//
//  SceneDelegate.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий on 17.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import PravdaUIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	// MARK: Properties

	var window: UIWindow?

	// MARK: UIWindowSceneDelegate

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
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
		let favoritesNavigationViewController = UINavigationController(rootViewController: FavoritesViewController())

		window.rootViewController = MainContainerFactory.make(
			firstSection: todayNavigationViewController,
			secondSection: spotlightNavigationViewController,
			thirdSection: favoritesNavigationViewController)
		window.makeKeyAndVisible()
	}
}
