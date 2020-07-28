//
//  TodayNewsItems.swift
//  Models
//
//  Created by Дмитрий Матвеенко on 28.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public struct TodayNewsItems {

	// MARK: Properties

	public let topStoriesItems: [TodayNewsItem]
	public let otherTopStoriesItems: [TodayNewsItem]
	public let scienceItems: [TodayNewsItem]
	public let otherScienceItems: [TodayNewsItem]

	private let identifier = UUID()

	// MARK: Life Cycle

	public init(
		topStoriesItems: [TodayNewsItem],
		otherTopStoriesItems: [TodayNewsItem],
		scienceItems: [TodayNewsItem],
		otherScienceItems: [TodayNewsItem]
	) {
		self.topStoriesItems = topStoriesItems
		self.otherTopStoriesItems = otherTopStoriesItems
		self.scienceItems = scienceItems
		self.otherScienceItems = otherScienceItems
	}

	/// Empty initializer, where each item in the array has an one empty item
	public init() {
		self.topStoriesItems = [TodayNewsItem(imageURL: nil, source: "", title: "", timePublication: "")]
		self.otherTopStoriesItems = [TodayNewsItem(imageURL: nil, source: "", title: "", timePublication: "")]
		self.scienceItems = [TodayNewsItem(imageURL: nil, source: "", title: "", timePublication: "")]
		self.otherScienceItems = [TodayNewsItem(imageURL: nil, source: "", title: "", timePublication: "")]
	}
}

// MARK: Setup Hashable Protocol

extension TodayNewsItems: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(identifier)
	}

	public static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.identifier == rhs.identifier
	}
}
