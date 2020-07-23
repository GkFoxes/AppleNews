//
//  TodayCollectionViewCellProtocol.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 23.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public protocol TodayCollectionViewCellProtocol: UICollectionViewCell {
	static var reuseIdentifer: String { get }

	static func getEstimatedHeight() -> CGFloat

	func setupContent(image: UIImage?, source: String, title: String, timePublication: String)
}
