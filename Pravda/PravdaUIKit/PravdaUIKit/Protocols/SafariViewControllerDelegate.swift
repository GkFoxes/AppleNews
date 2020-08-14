//
//  SafariViewControllerDelegate.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 14.08.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import SafariServices

public protocol SafariViewControllerDelegate: SFSafariViewControllerDelegate, UIViewController {
	func presentUrl(link: String)
}

public extension SafariViewControllerDelegate {
	func presentUrl(link: String) {
		tryPresentUrl(link: link)
	}
}

private extension SafariViewControllerDelegate {
	func tryPresentUrl(link: String) {
		guard let link = URL(string: link), UIApplication.shared.canOpenURL(link) else {
			let alert = UIAlertController(
				title: "Can not open this website",
				message: nil,
				preferredStyle: .alert)

			alert.addAction(UIAlertAction(title: "OK", style: .default))
			return self.present(alert, animated: true, completion: nil)
		}

		let safariViewController = SFSafariViewController(url: link)
		self.present(safariViewController, animated: true)
	}
}
