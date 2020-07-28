//
//  TodayCollectionViewDelegate.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 28.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

final class TodayCollectionViewDelegate: NSObject {
	var selectedItemHandler: ((IndexPath) -> Void)?
}

extension TodayCollectionViewDelegate: CollectionViewDelegateProtocol {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.selectedItemHandler?(indexPath)
	}
}
