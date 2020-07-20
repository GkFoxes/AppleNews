//
//  NewsTopicCollectionViewCell.swift
//  Pravda-MVC
//
//  Created by Дмитрий Матвеенко on 20.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import PravdaUIKit

protocol OtherNewsTopicCollectionViewCellProtocol: UICollectionViewCell {
	static var reuseIdentifer: String { get }

	static func getEstimatedHeight() -> CGFloat

	func setupContent(image: UIImage?, source: String, title: String, timePublication: String)
}

final class OtherNewsTopicCollectionViewCell: UICollectionViewCell {

	// MARK: Properties

	private enum Constants: CGFloat {
		case imageViewSizeSquare = 120
		case sourceLabelHeight = 10
		case titleLabelHeight = 22
		case timePublicationLabelHeight = 12
	}

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

// MARK: Setup OtherNewsTopicCollectionViewCell

extension OtherNewsTopicCollectionViewCell: OtherNewsTopicCollectionViewCellProtocol {
	static var reuseIdentifer: String {
		return String(describing: OtherNewsTopicCollectionViewCell.self)
	}

	static func getEstimatedHeight() -> CGFloat {
		return 350.0
	}

	func setupContent(image: UIImage?, source: String, title: String, timePublication: String) {
		imageView.image = Assets.test.image //temp
		sourceLabel.text = source
		titleLabel.text = title
		timePublicationLabel.text = timePublication
	}
}

// MARK: Setup Views Appearances

private extension OtherNewsTopicCollectionViewCell {
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
		sourceLabel.font = .systemFont(ofSize: 8.0, weight: .semibold)
		sourceLabel.textColor = .systemGray
	}

	func setupTitleLabelAppearances() {
		titleLabel.font = .systemFont(ofSize: 18.0, weight: .heavy)
		titleLabel.numberOfLines = 4
	}

	func setupTimePublicationLabelAppearances() {
		timePublicationLabel.font = .systemFont(ofSize: 10.0, weight: .medium)
		timePublicationLabel.textColor = .systemGray2
	}
}

// MARK: Setup Cell Layout

private extension OtherNewsTopicCollectionViewCell {
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
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewSizeSquare.rawValue),
			imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSizeSquare.rawValue)
		])
	}

	func setupSourceLabelLayout() {
		contentView.addSubview(sourceLabel)
		sourceLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			sourceLabel.trailingAnchor.constraint(
				equalTo: imageView.leadingAnchor, constant: TodayLayout.labelsDistance.rawValue),
			sourceLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
			sourceLabel.heightAnchor.constraint(equalToConstant: Constants.sourceLabelHeight.rawValue)
		])
	}

	func setupTitleLabelLayout() {
		contentView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			titleLabel.trailingAnchor.constraint(
				equalTo: imageView.leadingAnchor, constant: TodayLayout.labelsDistance.rawValue),
			titleLabel.topAnchor.constraint(
				equalTo: sourceLabel.bottomAnchor, constant: TodayLayout.labelsDistance.rawValue),
			titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.titleLabelHeight.rawValue)
		])
	}

	func setupTimePublicationLabelLayout() {
		contentView.addSubview(timePublicationLabel)
		timePublicationLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			timePublicationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			timePublicationLabel.trailingAnchor.constraint(
				equalTo: imageView.leadingAnchor, constant: TodayLayout.labelsDistance.rawValue),
			timePublicationLabel.topAnchor.constraint(
				equalTo: titleLabel.bottomAnchor, constant: TodayLayout.labelsDistance.rawValue),
			timePublicationLabel.bottomAnchor.constraint(
				equalTo: contentView.bottomAnchor, constant: TodayLayout.labelsDistance.rawValue),
			timePublicationLabel.heightAnchor.constraint(equalToConstant: Constants.timePublicationLabelHeight.rawValue)
		])
	}
}
