//
//  UICollectionView+.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 24.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

extension UICollectionView {

	// MARK: Dequeue Reusable Cells

	func tryDequeueReusableTodayCell(
		withReuseIdentifier reuseIdentifer: String,
		for indexPath: IndexPath
	) -> TodayCollectionViewCellProtocol? {
		guard let cell = self.dequeueReusableCell(
			withReuseIdentifier: reuseIdentifer,
			for: indexPath) as? TodayCollectionViewCellProtocol
		else {
			assertionFailure()
			return nil
		}

		return cell
	}
}
