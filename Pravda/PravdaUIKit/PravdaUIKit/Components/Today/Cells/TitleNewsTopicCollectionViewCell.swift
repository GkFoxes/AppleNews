//
//  TitleNewsTopicCollectionViewCell.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 23.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

final class TitleNewsTopicCollectionViewCell: UICollectionViewCell {

	// MARK: Properties

	private enum Constants: CGFloat {
		case labelsVerticalDistance = 8
		case sourceLabelHeight = 17
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

// MARK: Interface

extension TitleNewsTopicCollectionViewCell: TodayCollectionViewCellProtocol {
	static var reuseIdentifer: String {
		return String(describing: TitleNewsTopicCollectionViewCell.self)
	}

	static func getEstimatedHeight() -> CGFloat {
		return 650
	}

	func setupContent(image: UIImage?, source: String, title: String, timePublication: String) {
		imageView.image = Assets.test.image //temp
		sourceLabel.text = source
		titleLabel.text = title
		timePublicationLabel.text = timePublication
	}
}

// MARK: Views Appearances

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
		sourceLabel.font = .systemFont(ofSize: 14.0, weight: .semibold)
		sourceLabel.textColor = .systemGray
	}

	func setupTitleLabelAppearances() {
		titleLabel.font = .systemFont(ofSize: 26.0, weight: .heavy)
		titleLabel.numberOfLines = 4
	}

	func setupTimePublicationLabelAppearances() {
		timePublicationLabel.font = .systemFont(ofSize: 10.0, weight: .medium)
		timePublicationLabel.textColor = .systemGray2
	}
}

// MARK: Views Layout

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
			sourceLabel.topAnchor.constraint(
				equalTo: imageView.bottomAnchor, constant: Constants.labelsVerticalDistance.rawValue),
			sourceLabel.heightAnchor.constraint(equalToConstant: Constants.sourceLabelHeight.rawValue)
		])
	}

	func setupTitleLabelLayout() {
		contentView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			titleLabel.topAnchor.constraint(
				equalTo: sourceLabel.bottomAnchor, constant: Constants.labelsVerticalDistance.rawValue)
		])
	}

	func setupTimePublicationLabelLayout() {
		contentView.addSubview(timePublicationLabel)
		timePublicationLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			timePublicationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			timePublicationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			timePublicationLabel.topAnchor.constraint(
				equalTo: titleLabel.bottomAnchor, constant: Constants.labelsVerticalDistance.rawValue),
			timePublicationLabel.bottomAnchor.constraint(
				equalTo: contentView.bottomAnchor, constant: -2 * Constants.labelsVerticalDistance.rawValue),
			timePublicationLabel.heightAnchor.constraint(equalToConstant: Constants.timePublicationLabelHeight.rawValue)
		])
	}
}
