//
//  MainContainerFactory.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 16.06.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public final class MainContainerFactory {
	public static func make(
		firstSection: UIViewController,
		secondSection: UIViewController,
		thirdSection: UIViewController
	) -> UIViewController {
		let sectionsTabBarController: SectionsTabBarControllerProtocol = SectionsTabBarController(
			firstSectionViewController: firstSection,
			secondSectionViewController: secondSection,
			thirdSectionViewController: thirdSection)

		let mainContainerViewController = MainContainerViewController(
			firstSectionViewController: firstSection,
			sectionsTabBarController: sectionsTabBarController)

		return mainContainerViewController
	}
}
