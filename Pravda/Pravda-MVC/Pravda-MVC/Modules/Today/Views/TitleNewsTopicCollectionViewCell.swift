//
//  TitleNewsTopicCollectionViewCell.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий Владимирович on 15.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import PravdaUIKit

protocol TitleNewsTopicCollectionViewCellProtocol: UICollectionViewCell {
	static var reuseIdentifer: String { get }

	static func getEstimatedHeight() -> CGFloat

	func setupContent(image: UIImage?, source: String, title: String, timePublication: String)
}

class TitleNewsTopicCollectionViewCell: UICollectionViewCell {

	// MARK: Views

	private let imageView = UIImageView()
	private let sourceLabel = UILabel()
	private let titleLabel = UILabel()
	private let timePublicationLabel = UILabel()

	// MARK: Life Cycle

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupViewsAppearances()
		setupViewsLayout()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Setup Views TitleNewsTopicCollectionViewCellProtocol

extension TitleNewsTopicCollectionViewCell: TitleNewsTopicCollectionViewCellProtocol {
	static var reuseIdentifer: String {
		return String(describing: TitleNewsTopicCollectionViewCell.self)
	}

	static func getEstimatedHeight() -> CGFloat {
		return 216.0
	}

	func setupContent(image: UIImage?, source: String, title: String, timePublication: String) {
		imageView.image = UIImage(systemName: "pencil.and.outline") //temp
		sourceLabel.text = source
		titleLabel.text = title
		timePublicationLabel.text = timePublication
	}
}

// MARK: Setup Views Appearances

private extension TitleNewsTopicCollectionViewCell {
	func setupViewsAppearances() {
		setupImageViewAppearances()
		setupSourceLabelAppearances()
		setupTitleLabelAppearances()
		setupTimePublicationLabelAppearances()
	}

	func setupImageViewAppearances() {
		imageView.layer.cornerRadius = 4
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
	}

	func setupSourceLabelAppearances() {
		sourceLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
	}

	func setupTitleLabelAppearances() {
		titleLabel.font = UIFont.systemFont(ofSize: 21.0, weight: .bold)
		titleLabel.numberOfLines = 0
	}

	func setupTimePublicationLabelAppearances() {
		timePublicationLabel.font = UIFont.systemFont(ofSize: 11.0, weight: .regular)
	}
}

// MARK: Setup Cell Layout

private extension TitleNewsTopicCollectionViewCell {
	func setupViewsLayout() {
		setupImageViewLayout()
		setupSourceLabelLayout()
		setupTitleLabelLayout()
		setupTimePublicationLabelLayout()
	}

	func setupImageViewLayout() {
		contentView.addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			// Aspect ratio height 3, weight 4
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 3/4)
		])
	}

	func setupSourceLabelLayout() {
		contentView.addSubview(sourceLabel)
		sourceLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			sourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			sourceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
			sourceLabel.heightAnchor.constraint(equalToConstant: 18)
		])
	}

	func setupTitleLabelLayout() {
		contentView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			titleLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 4),
			titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 26)
		])
	}

	func setupTimePublicationLabelLayout() {
		contentView.addSubview(timePublicationLabel)
		timePublicationLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			timePublicationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			timePublicationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			timePublicationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			timePublicationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			timePublicationLabel.heightAnchor.constraint(equalToConstant: 14)
		])
	}
}
