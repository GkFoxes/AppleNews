//
//  FavoritesCollectionViewDelegateFlowLayout.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 23.09.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

extension FavoritesCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath)
	-> CGSize {
		return CGSize(width: collectionView.bounds.width, height: FavoritesCollectionViewCell.getHeight())
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumLineSpacingForSectionAt section: Int
	) -> CGFloat {
		return FavoritesLayout.safeInterDistance.rawValue
	}
}
