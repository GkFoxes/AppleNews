//
//  FavoritesCollectionViewDataSource.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 23.09.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import Models

protocol FavoritesCollectionViewDataSourceProtocol: UICollectionViewDataSource {
	func setItems(_ favoritesNewsItems: [FavoritesNewsItem])
	func getItem(for indexPath: IndexPath) -> FavoritesNewsItem
}

final class FavoritesCollectionViewDataSource: NSObject {

	// MARK: Properties

	private var favoritesNewsItems = [FavoritesNewsItem]()
}

// MARK: Data Source Interface

extension FavoritesCollectionViewDataSource: FavoritesCollectionViewDataSourceProtocol {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return favoritesNewsItems.count
	}

	func collectionView(
		_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: FavoritesCollectionViewCell.reuseIdentifer,
				for: indexPath) as? FavoritesCollectionViewCellProtocol
			else { assertionFailure(); return UICollectionViewCell() }

		let favoritesNewsItem = favoritesNewsItems[indexPath.row]
		cell.setupContent(
			fillImage: UIImage(data: favoritesNewsItem.fillImage ?? Data()), // temp
			source: favoritesNewsItem.source,
			title: favoritesNewsItem.title)
		return cell
	}

	func setItems(_ favoritesNewsItem: [FavoritesNewsItem]) {
		self.favoritesNewsItems = favoritesNewsItem
	}

	func getItem(for indexPath: IndexPath) -> FavoritesNewsItem {
		return favoritesNewsItems[indexPath.row]
	}
}
