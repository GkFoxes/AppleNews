//
//  SpotlightTableViewDataSource.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 03.09.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import Models

protocol SpotlightTableViewDataSourceProtocol: UITableViewDataSource {
	func setItems(_ spotlightNewsItems: [SpotlightNewsItem])
	func getItem(for indexPath: IndexPath) -> SpotlightNewsItem
}

final class SpotlightTableViewDataSource: NSObject {

	// MARK: Properties

	private var spotlightNewsItems = [SpotlightNewsItem]()
}

// MARK: Data Source Interface

extension SpotlightTableViewDataSource: SpotlightTableViewDataSourceProtocol {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 100 // temp
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell() // temp
	}

	func setItems(_ spotlightNewsItems: [SpotlightNewsItem]) {
		self.spotlightNewsItems = spotlightNewsItems
	}

	func getItem(for indexPath: IndexPath) -> SpotlightNewsItem {
		return spotlightNewsItems[indexPath.row]
	}
}
