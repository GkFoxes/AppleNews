//
//  FavoritesNewsItem.swift
//  Models
//
//  Created by Дмитрий Матвеенко on 23.09.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public struct FavoritesNewsItem {
	public let fillImage: Data?
	public let source: String
	public let title: String

	// MARK: Mock Data
	// temp

	public static func makeFavoritesMock() -> [Self] {
		return [
			FavoritesNewsItem(
				fillImage: nil,
				source: "1USA TODAY",
				title: "1Rep. John Lewis, a civil rights icon who began pushing"),
			FavoritesNewsItem(
				fillImage: nil,
				source: "2USA TODAY",
				title: "2Rep. John Lewis, a civil rights icon who began pushing for racial justice in south, has died"),
			FavoritesNewsItem(
				fillImage: nil,
				source: "3USA TODAY",
				title: "3Rep. John Lewis, a civil rights"),
			FavoritesNewsItem(
				fillImage: nil,
				source: "3USA TODAY",
				title: "3Rep. John Lewis, a civil rights"),
			FavoritesNewsItem(
				fillImage: nil,
				source: "3USA TODAY",
				title: "3Rep. John Lewis, a civil rights"),
			FavoritesNewsItem(
				fillImage: nil,
				source: "3USA TODAY",
				title: "3Rep. John Lewis, a civil rights")
		]
	}
}
