//
//  UITraitEnvironment+.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 23.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public extension UITraitEnvironment {

	// MARK: Size Classes

	func getHorizontalAndVerticalSizeClasses() -> (UIUserInterfaceSizeClass, UIUserInterfaceSizeClass) {
		return (self.traitCollection.horizontalSizeClass, self.traitCollection.verticalSizeClass)
	}
}
