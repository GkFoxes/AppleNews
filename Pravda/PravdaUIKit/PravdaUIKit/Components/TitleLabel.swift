//
//  TitleLabel.swift
//  PravdaUIKit
//
//  Created by Матвеенко Дмитрий Владимирович on 24.09.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

final class TitleLabel: UILabel {

	// MARK: Life Cycle

	init(
		fontSize: CGFloat,
		weight: UIFont.Weight,
		numberOfLines: Int,
		backgroundColor: UIColor = .systemBackground
	) {
		super.init(frame: .zero)

		self.backgroundColor = backgroundColor
		self.font = .systemFont(ofSize: fontSize, weight: weight)
		self.numberOfLines = numberOfLines
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
