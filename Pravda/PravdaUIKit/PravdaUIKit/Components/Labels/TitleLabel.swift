//
//  TitleLabel.swift
//  PravdaUIKit
//
//  Created by Матвеенко Дмитрий Владимирович on 24.09.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

final class TitleLabel: UILabel {

	// MARK: Properties

	enum FontSize: CGFloat {
		case standart = 26
		case small = 16
		case medium = 18
		case large = 22
	}

	// MARK: Life Cycle

	init(
		fontSize: FontSize = .standart,
		weight: UIFont.Weight = .heavy,
		numberOfLines: Int = 4,
		backgroundColor: UIColor = .systemBackground
	) {
		super.init(frame: .zero)

		self.backgroundColor = backgroundColor
		self.font = .systemFont(ofSize: fontSize.rawValue, weight: weight)
		self.numberOfLines = numberOfLines
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
