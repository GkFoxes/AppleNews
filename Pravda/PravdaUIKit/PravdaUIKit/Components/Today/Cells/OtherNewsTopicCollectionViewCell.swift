//
//  OtherNewsTopicCollectionViewCell.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 23.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

final class OtherNewsTopicCollectionViewCell: UICollectionViewCell {

	// MARK: Properties

	private enum Constants: CGFloat {
		case labelsDistance = 4
		case sourceLabelHeight = 14
		case titleLabelHeight = 86
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

// MARK: Setup Interface

extension OtherNewsTopicCollectionViewCell: TodayCollectionViewCellProtocol {
	static var reuseIdentifer: String {
		return String(describing: OtherNewsTopicCollectionViewCell.self)
	}

	static func getEstimatedHeight() -> CGFloat {
		return 132
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
		sourceLabel.font = .systemFont(ofSize: 11.0, weight: .semibold)
		sourceLabel.textColor = .systemGray
	}

	func setupTitleLabelAppearances() {
		titleLabel.font = .systemFont(ofSize: 18.0, weight: .bold)
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
		setupSourceLabelLayout()
		setupTitleLabelLayout()
		setupTimePublicationLabelLayout()
		setupImageViewLayout()
	}

	func setupSourceLabelLayout() {
		contentView.addSubview(sourceLabel)
		sourceLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			sourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			sourceLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
			sourceLabel.heightAnchor.constraint(equalToConstant: Constants.sourceLabelHeight.rawValue)
		])
	}

	func setupTitleLabelLayout() {
		contentView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			titleLabel.topAnchor.constraint(
				equalTo: sourceLabel.bottomAnchor, constant: Constants.labelsDistance.rawValue),
			titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: Constants.titleLabelHeight.rawValue)
		])
	}

	func setupTimePublicationLabelLayout() {
		contentView.addSubview(timePublicationLabel)
		timePublicationLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			timePublicationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			timePublicationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			timePublicationLabel.topAnchor.constraint(
				greaterThanOrEqualTo: titleLabel.bottomAnchor,
				constant: Constants.labelsDistance.rawValue),
			timePublicationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			timePublicationLabel.heightAnchor.constraint(equalToConstant: Constants.timePublicationLabelHeight.rawValue)
		])
	}

	func setupImageViewLayout() {
		contentView.addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			imageView.leadingAnchor.constraint(
				equalTo: titleLabel.trailingAnchor, constant: Constants.labelsDistance.rawValue),
			imageView.topAnchor.constraint(
				equalTo: sourceLabel.bottomAnchor, constant: Constants.labelsDistance.rawValue),
			imageView.bottomAnchor.constraint(
				equalTo: timePublicationLabel.topAnchor, constant: -Constants.labelsDistance.rawValue),
			// Aspect ratio 1 : 1 == Square
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
		])
	}
}
