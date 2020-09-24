//
//  FavoritesCollectionViewCell.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 23.09.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

protocol FavoritesCollectionViewCellProtocol: ListViewCellProtocol, UICollectionViewCell {
	static func getHeight() -> CGFloat
	func setupContent(fillImage: UIImage?, source: String, title: String)
}

final class FavoritesCollectionViewCell: UICollectionViewCell {

	// MARK: Properties

	private enum Constants: CGFloat {
		case safeHorizontalDistance = 10
		case safeVerticalDistance = 6
		case labelsVerticalDistance = 4
		case sourceLabelHeight = 14
		case timePublicationLabelHeight = 12
	}

	// MARK: Views

	private let fillImageView = RoundShadowImageView()
	private let sourceLabel = SourceLabel(fontSize: 11.0, backgroundColor: .clear)
	private let titleLabel = TitleLabel(fontSize: 16.0, weight: .bold, numberOfLines: 3, backgroundColor: .clear)

	// MARK: Life Cycle

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupViewsLayout()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Cell Interface

extension FavoritesCollectionViewCell: FavoritesCollectionViewCellProtocol {
	static var reuseIdentifer: String {
		return String(describing: FavoritesCollectionViewCell.self)
	}

	static func getHeight() -> CGFloat {
		return 412
	}

	func setupContent(fillImage: UIImage?, source: String, title: String) {
		fillImageView.image = Assets.test.image // temp
		sourceLabel.text = source
		titleLabel.text = title
	}
}

// MARK: Views Layout

private extension FavoritesCollectionViewCell {
	func setupViewsLayout() {
		setupFillImageViewLayout()
		setupSourceLabelLayout()
		setupTitleLabelLayout()
	}

	func setupFillImageViewLayout() {
		contentView.addSubview(fillImageView)
		fillImageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			fillImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			fillImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			fillImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			fillImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}

	func setupSourceLabelLayout() {
		contentView.addSubview(sourceLabel)
		sourceLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			sourceLabel.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor, constant: Constants.safeHorizontalDistance.rawValue),
			sourceLabel.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor, constant: -Constants.safeHorizontalDistance.rawValue),
			sourceLabel.topAnchor.constraint(
				equalTo: contentView.topAnchor, constant: Constants.labelsVerticalDistance.rawValue),
			sourceLabel.heightAnchor.constraint(equalToConstant: Constants.sourceLabelHeight.rawValue)
		])
	}

	func setupTitleLabelLayout() {
		contentView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: sourceLabel.leadingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: sourceLabel.trailingAnchor),
			titleLabel.topAnchor.constraint(
				equalTo: sourceLabel.topAnchor, constant: Constants.safeVerticalDistance.rawValue)
		])
	}
}
