//
//  NewsViews.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 08.09.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

final class NewsViews {

	// MARK: Views

	static func initHeaderImageView(cornerRadius: CGFloat = 4.0) -> UIImageView {
		let headerImageView = UIImageView()
		headerImageView.backgroundColor = .systemBackground
		headerImageView.layer.cornerRadius = cornerRadius
		headerImageView.contentMode = .scaleAspectFill
		headerImageView.clipsToBounds = true
		return headerImageView
	}

	static func initSourceLabel(fontSize: CGFloat) -> UILabel {
		let sourceLabel = UILabel()
		sourceLabel.backgroundColor = .systemBackground
		sourceLabel.font = .systemFont(ofSize: fontSize, weight: .semibold)
		sourceLabel.textColor = .systemGray
		return sourceLabel
	}

	static func initTitleLabel(fontSize: CGFloat, weight: UIFont.Weight, numberOfLines: Int) -> UILabel {
		let titleLabel = UILabel()
		titleLabel.backgroundColor = .systemBackground
		titleLabel.font = .systemFont(ofSize: fontSize, weight: weight)
		titleLabel.numberOfLines = numberOfLines
		return titleLabel
	}

	static func initTimePublicationLabel(fontSize: CGFloat, weight: UIFont.Weight) -> UILabel {
		let timePublicationLabel = UILabel()
		timePublicationLabel.backgroundColor = .systemBackground
		timePublicationLabel.font = .systemFont(ofSize: fontSize, weight: weight)
		timePublicationLabel.textColor = .systemGray2
		return timePublicationLabel
	}
}
