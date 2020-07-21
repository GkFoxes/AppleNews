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

// MARK: Mock Data

extension TodayNewsItem {
	static func makeTopStoriesMock() -> [Self] {
		return [
			TodayNewsItem(
				imageURL: nil,
				source: "USA TODAY",
				title: "Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died",
				timePublication: "57m ago")
			]
	}

	static func makeOtherTopStoriesMock() -> [Self] {
		return [
			TodayNewsItem(
				imageURL: nil,
				source: "USA TODAY",
				title: "Rep. John Lewis, a civil rights icon who began pushing",
				timePublication: "57m ago"),
			TodayNewsItem(
				imageURL: nil,
				source: "USA TODAY",
				title: "Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died",
				timePublication: "57m ago"),
			TodayNewsItem(
				imageURL: nil,
				source: "USA TODAY",
				title: "Rep. John Lewis, a civil rights",
				timePublication: "57m ago"),
			TodayNewsItem(
				imageURL: nil,
				source: "USA TODAY USA TODAY USA TODAY USA TODAY USA TODAY",
				title: "Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died",
				timePublication: "57m ago"),
			TodayNewsItem(
				imageURL: nil,
				source: "USA TODAY",
				title: "Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died",
				timePublication: "57m ago")
		]
}

	static func makeScienceMock() -> [Self] {
		return [
			TodayNewsItem(
				imageURL: nil,
				source: "Science alert",
				title: "Study of Over 1 Million People Finds Intriguing",
				timePublication: "2h ago")
			]
	}

	static func makeOtherScienceMock() -> [Self] {
		return [
			TodayNewsItem(
				imageURL: nil,
				source: "Science alert Science alert Science alert Science alert Science alert",
				title: "Study of Over 1 Million People Finds Intriguing",
				timePublication: "2h ago"),
			TodayNewsItem(
				imageURL: nil,
				source: "Science alert",
				title: "Study of Over 1 Million People Finds Intriguing Finds Intriguing Finds Intriguing",
				timePublication: "2h ago 2h ago 2h ago 2h ago 2h ago 2h ago 2h ago 2h ago 2h ago 2h ago 2h ago"),
			TodayNewsItem(
				imageURL: nil,
				source: "Science alert",
				title: "Study of Over 1 Million",
				timePublication: "2h ago"),
			TodayNewsItem(
				imageURL: nil,
				source: "Science alert",
				title: "Study of Over 1 Million People Finds Intriguing",
				timePublication: "2h ago")
		]
	}
}

// MARK: Hashable Protocol

extension TodayNewsItem: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(identifier)
	}

	static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.identifier == rhs.identifier
	}
}
