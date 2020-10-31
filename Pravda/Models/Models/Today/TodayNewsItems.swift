//
//  TodayNewsItems.swift
//  Models
//
//  Created by Дмитрий Матвеенко on 28.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public struct TodayNewsItems {

	// MARK: Properties

	public let topStoriesItems: [NewsItem]
	public let otherTopStoriesItems: [NewsItem]
	public let scienceItems: [NewsItem]
	public let otherScienceItems: [NewsItem]

	private let identifier = UUID()

	// MARK: Life Cycle

	public init(
		topStoriesItems: [NewsItem],
		otherTopStoriesItems: [NewsItem],
		scienceItems: [NewsItem],
		otherScienceItems: [NewsItem]
	) {
		self.topStoriesItems = topStoriesItems
		self.otherTopStoriesItems = otherTopStoriesItems
		self.scienceItems = scienceItems
		self.otherScienceItems = otherScienceItems
	}

	/// Empty initializer, where each array items is empty
	public init() {
		self.topStoriesItems = []
		self.otherTopStoriesItems = []
		self.scienceItems = []
		self.otherScienceItems = []
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
