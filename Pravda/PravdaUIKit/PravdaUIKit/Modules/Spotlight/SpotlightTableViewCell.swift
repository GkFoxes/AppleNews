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

	private let titleLabel = initTitleLabel()
	private let sourceLabel = initSourceLabel()
	private let timePublicationLabel = initTimePublicationLabel()

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
		return String(describing: OtherNewsTopicCollectionViewCell.self)
	}

	func setupContent(title: String, source: String, timePublication: String) {
		titleLabel.text = title
		sourceLabel.text = source
		timePublicationLabel.text = timePublication
	}
}

// MARK: Views Appearances

private extension SpotlightTableViewCell {
	static func initTitleLabel() -> UILabel {
		let titleLabel = UILabel()
		titleLabel.backgroundColor = .systemBackground
		titleLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
		titleLabel.numberOfLines = 5
		return titleLabel
	}

	static func initSourceLabel() -> UILabel {
		let sourceLabel = UILabel()
		sourceLabel.backgroundColor = .systemBackground
		sourceLabel.font = .systemFont(ofSize: 11.0, weight: .semibold)
		sourceLabel.textColor = .systemGray
		return sourceLabel
	}

	static func initTimePublicationLabel() -> UILabel {
		let timePublicationLabel = UILabel()
		timePublicationLabel.backgroundColor = .systemBackground
		timePublicationLabel.font = .systemFont(ofSize: 10.0, weight: .medium)
		timePublicationLabel.textColor = .systemGray2
		return timePublicationLabel
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
