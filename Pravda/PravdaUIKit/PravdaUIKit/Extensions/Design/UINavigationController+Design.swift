//
//  UINavigationController+Design.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 13.06.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public extension UINavigationController {

	// MARK: Design Variations

	func setupBoldDesignAppearances() {
		setupDesignAppearances(weight: .bold)
	}

	func setupBlackDesignAppearances() {
		setupDesignAppearances(weight: .black)
	}
}

private extension UINavigationController {

	// MARK: Setup Design

	func setupDesignAppearances(weight: UIFont.Weight) {
		self.navigationBar.prefersLargeTitles = true

		let appearance = UINavigationBarAppearance()
		appearance.backgroundColor = .systemBackground

		let titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0, weight: weight)]
		appearance.titleTextAttributes = titleTextAttributes

		let largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34.0, weight: weight)]
		appearance.largeTitleTextAttributes = largeTitleTextAttributes

		self.navigationBar.standardAppearance = appearance
		self.navigationBar.compactAppearance = appearance
		self.navigationBar.scrollEdgeAppearance = appearance
	}
}
