//
//  UIViewController+.swift
//  PravdaUIKit
//
//  Created by Матвеенко Дмитрий on 21.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public extension UIViewController {

	// MARK: Child Views

	func getSectionsTabBarController() -> SectionsTabBarController? {
		return UIApplication.shared.windows.first?.rootViewController?.children.first as? SectionsTabBarController
	}
}

extension UIViewController {

	// MARK: Size Classes

	func getHorizontalAndVerticalSizeClasses() -> (UIUserInterfaceSizeClass, UIUserInterfaceSizeClass) {
		return (self.traitCollection.horizontalSizeClass, self.traitCollection.verticalSizeClass)
	}
}
