//
//  NavBarAppearances.swift
//  PravdaSwiftUI
//
//  Created by Дмитрий Матвеенко on 31.01.2021.
//

import UIKit

public extension UINavigationBar {

	// MARK: Design Variations

	func setupBoldDesignAppearances() {
		setupDesignAppearances(weight: .bold)
	}

	func setupBlackDesignAppearances() {
		setupDesignAppearances(weight: .black)
	}
}

// MARK: Design Appearances

private extension UINavigationBar {
	func setupDesignAppearances(weight: UIFont.Weight) {
		self.prefersLargeTitles = true

		let appearance = UINavigationBarAppearance()
		appearance.backgroundColor = .systemBackground

		let backButtonAppearance = UIBarButtonItemAppearance()
		backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
		appearance.buttonAppearance = backButtonAppearance

		let titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0, weight: weight)]
		appearance.titleTextAttributes = titleTextAttributes

		let largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34.0, weight: weight)]
		appearance.largeTitleTextAttributes = largeTitleTextAttributes

		self.tintColor = .systemPink
		self.standardAppearance = appearance
		self.compactAppearance = appearance
		self.scrollEdgeAppearance = appearance
	}
}
