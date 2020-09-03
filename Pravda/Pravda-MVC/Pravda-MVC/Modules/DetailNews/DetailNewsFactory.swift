//
//  DetailNewsFactory.swift
//  Pravda-MVC
//
//  Created by Дмитрий Матвеенко on 05.08.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import Models
import PravdaUIKit

public final class DetailNewsFactory {
	public static func make(
		detailNews: TodayNewsItem
	) -> UIViewController {
		let detailNewsViewController: DetailNewsViewControllerFactoryProtocol = DetailNewsViewController()

		detailNewsViewController.setItem(DetailNewsItem(
			headerImage: Assets.test.image.pngData(), // temp
			title: detailNews.title,
			timePublication: detailNews.timePublication,
			text: detailNews.text,
			link: detailNews.link))
		detailNewsViewController.navigationItem.title = detailNews.source

		return detailNewsViewController
	}
}
