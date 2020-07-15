//
//  TodayNewsItem.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий Владимирович on 15.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import Foundation

struct TodayNewsItem: Hashable {
	let imageURL: URL?
	let source: String
	let title: String
	let timePublication: String

	private let identifier = UUID()

	func hash(into hasher: inout Hasher) {
		hasher.combine(identifier)
	}

	static func == (lhs: TodayNewsItem, rhs: TodayNewsItem) -> Bool {
		return lhs.identifier == rhs.identifier
	}
}
