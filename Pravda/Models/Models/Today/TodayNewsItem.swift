//
//  TodayNewsItem.swift
//  Models
//
//  Created by Дмитрий Матвеенко on 23.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public struct TodayNewsItem {
	public let imageURL: URL?
	public let source: String
	public let title: String
	public let timePublication: String

	private let identifier = UUID()
}

// MARK: Mock Data

public extension TodayNewsItem {
	static func makeTopStoriesMock(isOnlyOneItem: Bool) -> [Self] {
		let todayNewsItem = [
			TodayNewsItem(
				imageURL: nil,
				source: "USA TODAY",
				title: "Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died",
				timePublication: "57m ago"),
			TodayNewsItem(
				imageURL: nil,
				source: "USA TODAYYYYY",
				title: "Rep. John Lewis, a civil rights icon who began pushing, has died",
				timePublication: "2d ago")
		]

		if isOnlyOneItem {
			return todayNewsItem.dropLast()
		} else {
			return todayNewsItem
		}
	}

	static func makeOtherTopStoriesMock() -> [Self] {
		return [
			TodayNewsItem(
				imageURL: nil,
				source: "1USA TODAY",
				title: "1Rep. John Lewis, a civil rights icon who began pushing",
				timePublication: "157m ago"),
			TodayNewsItem(
				imageURL: nil,
				source: "2USA TODAY",
				title: "2Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died",
				timePublication: "257m ago"),
			TodayNewsItem(
				imageURL: nil,
				source: "3USA TODAY",
				title: "3Rep. John Lewis, a civil rights",
				timePublication: "357m ago"),
			TodayNewsItem(
				imageURL: nil,
				source: "4USA TODAY USA TODAY USA TODAY USA TODAY USA TODAY",
				title: "4Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died",
				timePublication: "457m ago"),
			TodayNewsItem(
				imageURL: nil,
				source: "5USA TODAY",
				title: "5Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died",
				timePublication: "557m ago")
		]
}

	static func makeScienceMock(isOnlyOneItem: Bool) -> [Self] {
		let todayNewsItem = [
			TodayNewsItem(
				imageURL: nil,
				source: "Science alert",
				title: "Study of Over 1 Million People Finds Intriguing",
				timePublication: "2h ago"),
			TodayNewsItem(
				imageURL: nil,
				source: "Science aler talert alert",
				title: "Study of Over 1 Million People Finds Intriguing",
				timePublication: "245 ago")
		]

		if isOnlyOneItem {
			return todayNewsItem.dropLast()
		} else {
			return todayNewsItem
		}
	}

	static func makeOtherScienceMock() -> [Self] {
		return [
			TodayNewsItem(
				imageURL: nil,
				source: "1Science alert Science alert Science alert Science alert Science alert",
				title: "1Study of Over 1 Million People Finds Intriguing",
				timePublication: "12h ago"),
			TodayNewsItem(
				imageURL: nil,
				source: "2Science alert",
				title: "2Study of Over 1 Million People Finds Intriguing Finds Intriguing Finds Intriguing",
				timePublication: "22h ago 2h ago 2h ago 2h ago 2h ago 2h ago 2h ago 2h ago 2h ago 2h ago 2h ago"),
			TodayNewsItem(
				imageURL: nil,
				source: "3Science alert",
				title: "3Study of Over 1 Million",
				timePublication: "32h ago"),
			TodayNewsItem(
				imageURL: nil,
				source: "4Science alert",
				title: "4Study of Over 1 Million People Finds Intriguing",
				timePublication: "42h ago")
		]
	}
}

// MARK: Setup Hashable Protocol

extension TodayNewsItem: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(identifier)
	}

	public static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.identifier == rhs.identifier
	}
}
