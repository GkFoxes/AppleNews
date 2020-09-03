//
//  SpotlightNewsItem.swift
//  Models
//
//  Created by Дмитрий Матвеенко on 03.09.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public struct SpotlightNewsItem {
	public let title: String
	public let timePublication: String
	public let text: String?
	public let link: String

	// MARK: Life Cycle

	public init(
		title: String,
		timePublication: String,
		text: String?,
		link: String
	) {
		self.title = title
		self.timePublication = timePublication
		self.text = text
		self.link = link
	}
}
