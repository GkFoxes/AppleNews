//
//  FavoritesViewController.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий on 19.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import PravdaUIKit
import SafariServices

final class FavoritesViewController: UIViewController {

	init() {
		super.init(nibName: nil, bundle: nil)

		self.navigationItem.title = Strings.favoritesTitle.rawValue
		self.tabBarItem.title = Strings.favoritesTitle.rawValue
		self.tabBarItem.image = Assets.favoritesTab.image
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationController?.setupBoldDesignAppearances()
		self.view.backgroundColor = .green
	}
}

extension FavoritesViewController: SFSafariViewControllerDelegate {
	private func openUrl() {
		if let url = URL(string: "https://stackoverflow.com/questions") {
			if  UIApplication.shared.canOpenURL(url) {
				let svc = SFSafariViewController(url: url)
				self.present(svc, animated: true, completion: {
					print("keka")
				})

				guard let safariNewsTappedController = getSafariNewsTappedController() else { return }
				safariNewsTappedController.safariNewsTapped()
			} else {
				let alert = UIAlertController(title: "Can not open this website",
											  message: "Please check the existence of the website",
											  preferredStyle: .alert)

				alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
											  style: .default,
											  handler: { _ in
												NSLog("The \"OK\" alert occured.")
				}))

				self.present(alert, animated: true, completion: nil)
			}
		}
	}
}
