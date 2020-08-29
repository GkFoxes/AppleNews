//
//  DetailNewsItem.swift
//  Models
//
//  Created by Дмитрий Матвеенко on 05.08.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public struct DetailNewsItem {
	public let headerImage: Data?
	public let title: String
	public let timePublication: String
	public let text: String?
	public let link: String

	// MARK: Life Cycle

	public init(
		image: Data?,
		title: String,
		timePublication: String,
		text: String?,
		link: String
	) {
		self.headerImage = image
		self.title = title
		self.timePublication = timePublication
		self.text = text
		self.link = link
	}
}
