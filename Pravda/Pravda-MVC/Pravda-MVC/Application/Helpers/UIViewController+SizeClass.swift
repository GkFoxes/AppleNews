//
//  UIViewController+SizeClass.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий on 20.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import UIKit

extension UIViewController {
	func getHorizontalAndVerticalSizeClasses() -> (UIUserInterfaceSizeClass, UIUserInterfaceSizeClass) {
		return (self.traitCollection.horizontalSizeClass, self.traitCollection.verticalSizeClass)
	}
}
