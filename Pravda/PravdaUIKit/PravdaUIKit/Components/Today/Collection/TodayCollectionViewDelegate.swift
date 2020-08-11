//
//  TodayCollectionViewDelegate.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 28.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

protocol TodayCollectionViewDelegateProtocol: CollectionViewDelegateProtocol {
	var detailNewsViewController: ((IndexPath) -> UIViewController?)? { get set }
}

final class TodayCollectionViewDelegate: NSObject {

	// MARK: Properties

	var selectedItemHandler: ((IndexPath) -> Void)?
	var detailNewsViewController: ((IndexPath) -> UIViewController?)?
}

extension TodayCollectionViewDelegate: TodayCollectionViewDelegateProtocol {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.selectedItemHandler?(indexPath)
	}

	func collectionView(
		_ collectionView: UICollectionView,
		contextMenuConfigurationForItemAt indexPath: IndexPath,
		point: CGPoint
	) -> UIContextMenuConfiguration? {
		let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: { () -> UIViewController? in
			return self.detailNewsViewController?(indexPath)
		}) { _ -> UIMenu? in
			let action = UIAction(title: "Favorite", image: UIImage(systemName: "archivebox.fill")) { _ in
				//self.selectedItemHandler(<#IndexPath#>)
			}
			return UIMenu(title: "", children: [action])
		}
		return configuration
	}
}
