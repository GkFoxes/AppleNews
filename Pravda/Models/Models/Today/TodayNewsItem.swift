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
	public let text: String?

	private let identifier = UUID()
}

// MARK: Mock Data

public extension TodayNewsItem {
	static func makeTopStoriesMock(isOnlyOneItem: Bool) -> [Self] {
		let todayNewsItem = [
			TodayNewsItem(
				imageURL: nil,
				source: "USA TODAY",
				title: "Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died1",
				timePublication: "57m ago",
				text: "Rep. John Lewis, a civil rights icon who began pushing, has died1"),
			TodayNewsItem(
				imageURL: nil,
				source: "USA TODAYYYYY",
				title: "Rep. John Lewis, a civil rights icon who began pushing, has died2",
				timePublication: "2d ago",
				text: "Rep. John Lewis, a civil rights icon who began pushing, has died2")
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
				timePublication: "157m ago",
				text: "1Rep. John Lewis, a civil rights icon who began pushing 1Rep. John icon who began pushing"),
			TodayNewsItem(
				imageURL: nil,
				source: "2USA TODAY",
				title: "2Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died",
				timePublication: "257m ago",
				text: """
						2Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died
						2Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died
						2Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died
						2Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died
						2Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died
						2Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died
						2Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died
						2Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died
						2Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died
						"""),
			TodayNewsItem(
				imageURL: nil,
				source: "3USA TODAY",
				title: "3Rep. John Lewis, a civil rights",
				timePublication: "357m ago",
				text: "3Rep. John Lewis, a civil rights"),
			TodayNewsItem(
				imageURL: nil,
				source: "4USA TODAY USA TODAY USA TODAY USA TODAY USA TODAY",
				title: "4Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died",
				timePublication: "457m ago",
				text: "4Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died"),
			TodayNewsItem(
				imageURL: nil,
				source: "5USA TODAY",
				title: "5Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died",
				timePublication: "557m ago",
				text: "5Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died")
		]
}

	static func makeScienceMock(isOnlyOneItem: Bool) -> [Self] {
		let todayNewsItem = [
			TodayNewsItem(
				imageURL: nil,
				source: "Science alert",
				title: "Study of Over 1 Million People Finds Intriguing1",
				timePublication: "2h ago",
				text: "Study of Over 1 Million People Finds Intriguing1"),
			TodayNewsItem(
				imageURL: nil,
				source: "Science aler talert alert",
				title: "Study of Over 1 Million People Finds Intriguing2",
				timePublication: "245 ago",
				text: "Study of Over 1 Million People Finds Intriguing2")
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
				timePublication: "12h ago",
				text: "1Study of Over 1 Million People Finds Intriguing"),
			TodayNewsItem(
				imageURL: nil,
				source: "2Science alert",
				title: "2Study of Over 1 Million People Finds Intriguing Finds Intriguing Finds Intriguing",
				timePublication: "22h ago 2h ago 2h ago 2h ago 2h ago 2h ago 2h ago 2h ago 2h ago 2h ago 2h ago",
				text: "2Study of Over 1 Million People Finds Intriguing Finds Intriguing Finds Intriguing"),
			TodayNewsItem(
				imageURL: nil,
				source: "3Science alert",
				title: "3Study of Over 1 Million",
				timePublication: "32h ago",
				text: "3Study of Over 1 Million"),
			TodayNewsItem(
				imageURL: nil,
				source: "4Science alert",
				title: "4Study of Over 1 Million People Finds Intriguing",
				timePublication: "42h ago",
				text: "4Study of Over 1 Million People Finds Intriguing")
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
