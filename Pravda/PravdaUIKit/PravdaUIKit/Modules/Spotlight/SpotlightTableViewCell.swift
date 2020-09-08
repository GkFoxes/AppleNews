//
//  SpotlightTableViewCell.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 08.09.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

protocol SpotlightTableViewCellProtocol: ListViewCellProtocol, UITableViewCell {
	func setupContent(title: String, source: String, timePublication: String)
}

final class SpotlightTableViewCell: UITableViewCell {

	// MARK: Properties

	private enum Constants: CGFloat {
		case safeHorizontalDistance = 10
		case safeVerticalDistance = 4
		case labelsVerticalDistance = 6
		case sourceLabelHeight = 14
		case timePublicationLabelHeight = 12
	}

	// MARK: Views

	private let titleLabel = NewsViews.initTitleLabel(fontSize: 16.0, weight: .bold, numberOfLines: 4)
	private let sourceLabel = NewsViews.initSourceLabel(fontSize: 11.0)
	private let timePublicationLabel = NewsViews.initTimePublicationLabel(fontSize: 10.0, weight: .medium)

	// MARK: Life Cycle

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		setupViewsLayout()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Cell Interface

extension SpotlightTableViewCell: SpotlightTableViewCellProtocol {
	static var reuseIdentifer: String {
		return String(describing: SpotlightTableViewCell.self)
	}

	func setupContent(title: String, source: String, timePublication: String) {
		titleLabel.text = title
		sourceLabel.text = source
		timePublicationLabel.text = timePublication
	}
}

// MARK: Views Layout

private extension SpotlightTableViewCell {
	func setupViewsLayout() {
		setupTitleLabelLayout()
		setupSourceLabelLayout()
		setupTimePublicationLabelLayout()
	}

	func setupTitleLabelLayout() {
		contentView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor, constant: Constants.safeHorizontalDistance.rawValue),
			titleLabel.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor, constant: Constants.safeHorizontalDistance.rawValue),
			titleLabel.topAnchor.constraint(
				equalTo: contentView.topAnchor, constant: Constants.safeVerticalDistance.rawValue)
		])
	}

	func setupSourceLabelLayout() {
		contentView.addSubview(sourceLabel)
		sourceLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			sourceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			sourceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			sourceLabel.topAnchor.constraint(
				equalTo: titleLabel.bottomAnchor, constant: Constants.labelsVerticalDistance.rawValue),
			sourceLabel.heightAnchor.constraint(equalToConstant: Constants.sourceLabelHeight.rawValue)
		])
	}

	func setupTimePublicationLabelLayout() {
		contentView.addSubview(timePublicationLabel)
		timePublicationLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			timePublicationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			timePublicationLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			timePublicationLabel.topAnchor.constraint(
				equalTo: sourceLabel.bottomAnchor, constant: Constants.labelsVerticalDistance.rawValue),
			timePublicationLabel.bottomAnchor.constraint(
				equalTo: contentView.bottomAnchor, constant: Constants.safeVerticalDistance.rawValue),
			timePublicationLabel.heightAnchor.constraint(equalToConstant: Constants.timePublicationLabelHeight.rawValue)
		])
	}
}
