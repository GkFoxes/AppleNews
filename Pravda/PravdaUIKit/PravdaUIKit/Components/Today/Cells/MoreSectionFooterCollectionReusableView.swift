//
//  MoreSectionFooterCollectionReusableView.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 01.09.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

protocol MoreSectionFooterCollectionReusableViewProtocol: UICollectionReusableView {
	static var reuseIdentifer: String { get }

	static func getEstimatedHeight() -> CGFloat

	func setupContent(sectionTitle: String, sectionColor: UIColor)
}

final class MoreSectionFooterCollectionReusableView: UICollectionReusableView {

	// MARK: Properties

	private enum Constants: CGFloat {
		case horizontalDistance = 8
	}

	// MARK: Views

	private let moreLabel = initMoreLabel()
	private let tapOnViewButton = UIButton()

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

// MARK: Interface

extension MoreSectionFooterCollectionReusableView: MoreSectionFooterCollectionReusableViewProtocol {
	static var reuseIdentifer: String {
		return String(describing: MoreSectionFooterCollectionReusableView.self)
	}

	static func getEstimatedHeight() -> CGFloat {
		return 22
	}

	func setupContent(sectionTitle: String, sectionColor: UIColor) {
		let moreLabelAttributedString = NSMutableAttributedString()
		moreLabel.text = Strings.moreNewsFrom.rawValue.uppercased() + Strings.whitespace.rawValue
		guard let moreLabelAttributedText = moreLabel.attributedText else { return assertionFailure() }

		let sectionString = sectionTitle.uppercased() + Strings.whitespace.rawValue + Strings.triangularBullet.rawValue
		let sectionAttributes = [NSAttributedString.Key.foregroundColor: sectionColor]
		let sectionAttributedString = NSAttributedString(string: sectionString, attributes: sectionAttributes)

		moreLabelAttributedString.append(moreLabelAttributedText)
		moreLabelAttributedString.append(sectionAttributedString)
		moreLabel.attributedText = moreLabelAttributedString
	}
}

// MARK: Views Appearances

private extension MoreSectionFooterCollectionReusableView {
	static func initMoreLabel() -> UILabel {
		let moreLabel = UILabel()
		moreLabel.backgroundColor = .systemBackground
		moreLabel.textColor = .systemGray2
		moreLabel.font = .systemFont(ofSize: 13.0, weight: .bold)
		return moreLabel
	}
}

// MARK: ReusableView Layout

private extension MoreSectionFooterCollectionReusableView {
	func setupViewsLayout() {
		setupMoreLabelLayout()
		setupTapOnViewButtonLayout()
	}

	func setupMoreLabelLayout() {
		addSubview(moreLabel)
		moreLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			moreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			moreLabel.topAnchor.constraint(
				equalTo: topAnchor, constant: Constants.horizontalDistance.rawValue),
			moreLabel.bottomAnchor.constraint(
				equalTo: bottomAnchor, constant: -Constants.horizontalDistance.rawValue)
		])
	}

	func setupTapOnViewButtonLayout() {
		self.addSubview(tapOnViewButton)
		tapOnViewButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			tapOnViewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			tapOnViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			tapOnViewButton.topAnchor.constraint(equalTo: self.topAnchor),
			tapOnViewButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
}
