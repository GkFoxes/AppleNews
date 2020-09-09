//
//  DetailNewsItem.swift
//  Models
//
//  Created by Дмитрий Матвеенко on 05.08.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public struct DetailNewsItem {
	public let source: String
	public let headerImage: Data?
	public let title: String
	public let timePublication: String
	public let text: String?
	public let link: String?

	// MARK: Life Cycle

	init(
		source: String,
		headerImage: Data?,
		title: String,
		timePublication: String,
		text: String?,
		link: String?
	) {
		self.source = source
		self.headerImage = headerImage
		self.title = title
		self.timePublication = timePublication
		self.text = text
		self.link = link
	}

	public init(todayNewsItem: TodayNewsItem) {
		self.init(
			source: todayNewsItem.source,
			headerImage: todayNewsItem.headerImage,
			title: todayNewsItem.title,
			timePublication: todayNewsItem.timePublication,
			text: nil,
			link: nil)
	}

	public init(spotlightNewsItem: SpotlightNewsItem) {
		self.init(
			source: spotlightNewsItem.source,
			headerImage: nil,
			title: spotlightNewsItem.title,
			timePublication: spotlightNewsItem.timePublication,
			text: nil,
			link: nil)
	}
}
