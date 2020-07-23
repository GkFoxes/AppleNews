//
//  UIViewController+.swift
//  PravdaUIKit
//
//  Created by Матвеенко Дмитрий on 21.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public extension UIViewController {

	// MARK: Child Views

	func getSafariNewsTappedController() -> SafariNewsTappedProtocol? {
		return UIApplication.shared.windows.first?.rootViewController?.children.first as? SafariNewsTappedProtocol
	}
}
