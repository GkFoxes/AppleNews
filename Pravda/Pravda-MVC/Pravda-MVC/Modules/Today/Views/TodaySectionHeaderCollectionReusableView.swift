//
//  TodaySectionHeaderCollectionReusableView.swift
//  Pravda-MVC
//
//  Created by Дмитрий Матвеенко on 18.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import PravdaUIKit

protocol TodaySectionHeaderCollectionReusableViewProtocol: UICollectionReusableView {
	static var reuseIdentifer: String { get }

	static func getEstimatedHeight() -> CGFloat

	func setupContent(title: String, textColor: UIColor)
}

final class TodaySectionHeaderCollectionReusableView: UICollectionReusableView {

	// MARK: Views

	private let sectionHeaderLabel = UILabel()

	// MARK: Life Cycle

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupSectionHeaderLabelAppearances()
		setupSectionHeaderLabelLayout()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Setup TodaySectionHeaderCollectionReusableViewProtocol

extension TodaySectionHeaderCollectionReusableView: TodaySectionHeaderCollectionReusableViewProtocol {
	static var reuseIdentifer: String {
		return String(describing: TodaySectionHeaderCollectionReusableView.self)
	}

	static func getEstimatedHeight() -> CGFloat {
		return 44.0
	}

	func setupContent(title: String, textColor: UIColor) {
		sectionHeaderLabel.text = title
		sectionHeaderLabel.textColor = textColor
	}
}

// MARK: Setup Views Appearances

private extension TodaySectionHeaderCollectionReusableView {
	func setupSectionHeaderLabelAppearances() {
		sectionHeaderLabel.font = .systemFont(ofSize: 30.0, weight: .black)
	}
}

// MARK: Setup ReusableView Layout

private extension TodaySectionHeaderCollectionReusableView {
	func setupSectionHeaderLabelLayout() {
		addSubview(sectionHeaderLabel)
		sectionHeaderLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			sectionHeaderLabel.leadingAnchor.constraint(
				equalTo: leadingAnchor, constant: TodayLayout.horizontalInsets.rawValue),
			sectionHeaderLabel.trailingAnchor.constraint(
				equalTo: trailingAnchor, constant: TodayLayout.horizontalInsets.rawValue),
			sectionHeaderLabel.topAnchor.constraint(
				equalTo: topAnchor, constant: TodayLayout.labelsDistance.rawValue),
			sectionHeaderLabel.bottomAnchor.constraint(
				equalTo: bottomAnchor, constant: -2 * TodayLayout.labelsDistance.rawValue)
		])
	}
}
