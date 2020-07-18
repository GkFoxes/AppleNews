//
//  TodayNewsItem.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий Владимирович on 15.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import Foundation

struct TodayNewsItem {
	let imageURL: URL?
	let source: String
	let title: String
	let timePublication: String

	private let identifier = UUID()
}

extension TodayNewsItem {
	static func makeMock() -> [Self] {
		return [
			TodayNewsItem(
				imageURL: nil,
				source: "USA TODAY",
				title: "Rep. John Lewis, a civil rights icon who began pushing for racial justice in the Jim Crow south, has died",
				timePublication: "57m ago"
			),
			TodayNewsItem(imageURL: nil, source: "bar1", title: "bar2", timePublication: "bar3"),
			TodayNewsItem(imageURL: nil, source: "baz1", title: "baz2", timePublication: "baz3"),
			TodayNewsItem(imageURL: nil, source: "foo1", title: "bar2", timePublication: "baz3")
		]
	}
}

extension TodayNewsItem: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(identifier)
	}

	static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.identifier == rhs.identifier
	}
}
