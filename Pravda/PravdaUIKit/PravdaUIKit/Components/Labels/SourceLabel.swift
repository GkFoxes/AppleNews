//
//  SourceLabel.swift
//  PravdaUIKit
//
//  Created by Матвеенко Дмитрий Владимирович on 24.09.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

final class SourceLabel: UILabel {

	// MARK: Life Cycle

	init(fontSize: CGFloat, backgroundColor: UIColor = .systemBackground) {
		super.init(frame: .zero)

		self.backgroundColor = backgroundColor
		self.font = .systemFont(ofSize: fontSize, weight: .semibold)
		self.textColor = .systemGray
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
