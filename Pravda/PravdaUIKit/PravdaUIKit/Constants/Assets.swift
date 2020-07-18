//
//  Assets.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 13.06.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public enum Assets: String {

	// MARK: Tabs

	case todayTab
	case spotlightTab
	case favoritesTab
	case test

	var name: String {
		return self.rawValue
	}

	public var image: UIImage {
		guard
			let bundle = Bundle(identifier: "ru.GkFoxes.PravdaUIKit"),
			let image = UIImage(named: self.name, in: bundle, compatibleWith: nil) else {
				assertionFailure()
				return UIImage()
		}

		return image
	}
}
