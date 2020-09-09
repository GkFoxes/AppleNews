//
//  SpotlightNewsItem.swift
//  Models
//
//  Created by Дмитрий Матвеенко on 03.09.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

// temp
// swiftlint:disable all

public struct SpotlightNewsItem {
	public let title: String
	public let source: String
	public let timePublication: String

	// MARK: Life Cycle

	public init(
		title: String,
		source: String,
		timePublication: String
	) {
		self.title = title
		self.source = source
		self.timePublication = timePublication
	}

	// MARK: Mock Data
	// temp

	public static func makeSpotlightMock() -> [Self] {
		return [
			SpotlightNewsItem(
				title: "1Stud of Over 1 Million People Finds Intriguing 1Stud of Over 1 Million People Finds Intriguing",
				source: "1Science 1Science 1Science 1Science 1Science 1Science 1Science 1Science 1Science 1Science",
				timePublication: "12h ago"),
			SpotlightNewsItem(
				title: "2Stud of Over 1 Million People Finds Intriguing 1Stud of Over 1 Million People Finds Intriguing",
				source: "2Science",
				timePublication: "2h ago"),
			SpotlightNewsItem(
				title: "3Stud of Over 1 Million People Finds Intriguing",
				source: "3Science",
				timePublication: "32h ago"),
			SpotlightNewsItem(
				title: "4Stud of Over 1 Million People Finds Intriguing",
				source: "4Science",
				timePublication: "42h ago"),
			SpotlightNewsItem(
				title: "1Stud of Over 1 Million People Finds Intriguing 1Stud of Over 1 Million People Finds Intriguing",
				source: "1Science",
				timePublication: "12h ago"),
			SpotlightNewsItem(
				title: "2Stud of Over 1 Million People Finds Intriguing",
				source: "2Science",
				timePublication: "2h ago"),
			SpotlightNewsItem(
				title: "3Stud of Over 1 Million People Finds Intriguing",
				source: "3Science",
				timePublication: "32h ago"),
			SpotlightNewsItem(
				title: "4Stud of Over 1 Million People Finds Intriguing",
				source: "4Science",
				timePublication: "42h ago"),
			SpotlightNewsItem(
				title: "1Stud of Over 1 Million People Finds Intriguing 1Stud of Over 1 Million People Finds Intriguing 1Stud of Over 1 Million People Finds Intriguing 1Stud of Over 1 Million People Finds Intriguing",
				source: "1Science",
				timePublication: "12h ago"),
			SpotlightNewsItem(
				title: "2Stud of Over 1 Million People Finds Intriguing",
				source: "2Science",
				timePublication: "2h ago"),
			SpotlightNewsItem(
				title: "3Stud of Over 1 Million People Finds Intriguing",
				source: "3Science",
				timePublication: "32h ago"),
			SpotlightNewsItem(
				title: "4Stud of Over 1 Million People Finds Intriguing",
				source: "4Science",
				timePublication: "42h ago"),
			SpotlightNewsItem(
				title: "1Stud of Over 1 Million People Finds Intriguing",
				source: "1Science",
				timePublication: "12h ago"),
			SpotlightNewsItem(
				title: "2Stud of Over 1 Million People Finds Intriguing 1Stud of Over 1 Million People Finds Intriguing 1Stud of Over 1 Million People Finds Intriguing",
				source: "2Science",
				timePublication: "2h ago"),
			SpotlightNewsItem(
				title: "3Stud of Over 1 Million People Finds Intriguing",
				source: "3Science",
				timePublication: "32h ago"),
			SpotlightNewsItem(
				title: "4Stud of Over 1 Million People Finds Intriguing 1Stud of Over 1 Million People Finds Intriguing 1Stud of Over 1 Million People Finds Intriguing 1Stud of Over 1 Million People Finds Intriguing ",
				source: "4Science",
				timePublication: "42h ago"),
			SpotlightNewsItem(
				title: "1Stud of Over 1 Million People Finds Intriguing",
				source: "1Science",
				timePublication: "12h ago"),
			SpotlightNewsItem(
				title: "2Stud of Over 1 Million People Finds Intriguing",
				source: "2Science",
				timePublication: "2h ago"),
			SpotlightNewsItem(
				title: "3Stud of Over 1 Million People Finds Intriguing 1Stud of Over 1 Million People Finds Intriguing 1Stud of Over 1 Million People Finds Intriguing 1Stud of Over 1 Million People Finds Intriguing",
				source: "3Science",
				timePublication: "32h ago"),
			SpotlightNewsItem(
				title: "4Stud of Over 1 Million People Finds Intriguing",
				source: "4Science",
				timePublication: "42h ago"),
			SpotlightNewsItem(
				title: "1Stud of Over 1 Million People Finds Intriguing",
				source: "1Science",
				timePublication: "12h ago"),
			SpotlightNewsItem(
				title: "2Stud of Over 1 Million People Finds Intriguing",
				source: "2Science",
				timePublication: "2h ago"),
			SpotlightNewsItem(
				title: "3Stud of Over 1 Million People Finds Intriguing",
				source: "3Science",
				timePublication: "32h ago"),
			SpotlightNewsItem(
				title: "4Stud of Over 1 Million People Finds Intriguing",
				source: "4Science",
				timePublication: "42h ago"),
			SpotlightNewsItem(
				title: "1Stud of Over 1 Million People Finds Intriguing",
				source: "1Science",
				timePublication: "12h ago"),
			SpotlightNewsItem(
				title: "2Stud of Over 1 Million People Finds Intriguing",
				source: "2Science",
				timePublication: "2h ago"),
			SpotlightNewsItem(
				title: "3Stud of Over 1 Million People Finds Intriguing",
				source: "3Science",
				timePublication: "32h ago"),
			SpotlightNewsItem(
				title: "4Stud of Over 1 Million People Finds Intriguing",
				source: "4Science",
				timePublication: "42h ago"),
			SpotlightNewsItem(
				title: "1Stud of Over 1 Million People Finds Intriguing",
				source: "1Science",
				timePublication: "12h ago"),
			SpotlightNewsItem(
				title: "2Stud of Over 1 Million People Finds Intriguing 1Stud of Over 1 Million People Finds Intriguing 1Stud of Over 1 Million People Finds Intriguing",
				source: "2Science",
				timePublication: "2h ago"),
			SpotlightNewsItem(
				title: "3Stud of Over 1 Million People Finds Intriguing",
				source: "3Science",
				timePublication: "32h ago"),
			SpotlightNewsItem(
				title: "4Stud of Over 1 Million People Finds Intriguing",
				source: "4Science",
				timePublication: "42h ago"),
			SpotlightNewsItem(
				title: "1Stud of Over 1 Million People Finds Intriguing",
				source: "1Science",
				timePublication: "12h ago"),
			SpotlightNewsItem(
				title: "2Stud of Over 1 Million People Finds Intriguing",
				source: "2Science",
				timePublication: "2h ago"),
			SpotlightNewsItem(
				title: "3Stud of Over 1 Million People Finds Intriguing",
				source: "3Science",
				timePublication: "32h ago"),
			SpotlightNewsItem(
				title: "4Stud of Over 1 Million People Finds Intriguing",
				source: "4Science",
				timePublication: "42h ago"),
			SpotlightNewsItem(
				title: "1Stud of Over 1 Million People Finds Intriguing",
				source: "1Science",
				timePublication: "12h ago"),
			SpotlightNewsItem(
				title: "2Stud of Over 1 Million People Finds Intriguing",
				source: "2Science",
				timePublication: "2h ago"),
			SpotlightNewsItem(
				title: "3Stud of Over 1 Million People Finds Intriguing",
				source: "3Science",
				timePublication: "32h ago"),
			SpotlightNewsItem(
				title: "4Stud of Over 1 Million People Finds Intriguing",
				source: "4Science",
				timePublication: "42h ago"),
			SpotlightNewsItem(
				title: "1Stud of Over 1 Million People Finds Intriguing",
				source: "1Science",
				timePublication: "12h ago"),
			SpotlightNewsItem(
				title: "2Stud of Over 1 Million People Finds Intriguing",
				source: "2Science",
				timePublication: "2h ago"),
			SpotlightNewsItem(
				title: "3Stud of Over 1 Million People Finds Intriguing",
				source: "3Science",
				timePublication: "32h ago"),
			SpotlightNewsItem(
				title: "4Stud of Over 1 Million People Finds Intriguing",
				source: "4Science",
				timePublication: "42h ago"),
			SpotlightNewsItem(
				title: "1Stud of Over 1 Million People Finds Intriguing",
				source: "1Science",
				timePublication: "12h ago"),
			SpotlightNewsItem(
				title: "2Stud of Over 1 Million People Finds Intriguing",
				source: "2Science",
				timePublication: "2h ago"),
			SpotlightNewsItem(
				title: "3Stud of Over 1 Million People Finds Intriguing",
				source: "3Science",
				timePublication: "32h ago"),
			SpotlightNewsItem(
				title: "4Stud of Over 1 Million People Finds Intriguing",
				source: "4Science",
				timePublication: "42h ago"),
			SpotlightNewsItem(
				title: "1Stud of Over 1 Million People Finds Intriguing",
				source: "1Science",
				timePublication: "12h ago"),
			SpotlightNewsItem(
				title: "2Stud of Over 1 Million People Finds Intriguing",
				source: "2Science",
				timePublication: "2h ago"),
			SpotlightNewsItem(
				title: "3Stud of Over 1 Million People Finds Intriguing",
				source: "3Science",
				timePublication: "32h ago"),
			SpotlightNewsItem(
				title: "4Stud of Over 1 Million People Finds Intriguing",
				source: "4Science",
				timePublication: "42h ago")
		]
	}
}
