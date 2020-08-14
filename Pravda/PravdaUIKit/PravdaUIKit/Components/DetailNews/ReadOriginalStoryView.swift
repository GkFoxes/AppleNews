//
//  ReadOriginalStoryView.swift
//  PravdaUIKit
//
//  Created by Матвеенко Дмитрий Владимирович on 14.08.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

protocol ReadOriginalStoryViewProtocol: UIView {
	func setLink(_ link: String)
}

public final class ReadOriginalStoryView: UIView {

	// MARK: Properties

	private enum Constants: CGFloat {
		case suggestionLabelCenterXConstant = -10
		case linkLabelTopAnchorConstant = 2
	}

	// MARK: Views

	private let suggestionLabel = UILabel()
	private let linkLabel = UILabel()
	private let tapOnViewButton = UIButton()

	// MARK: Life Cycle

	public override init(frame: CGRect) {
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

extension ReadOriginalStoryView: ReadOriginalStoryViewProtocol {
	public func setLink(_ link: String) {
		linkLabel.text = link
	}
}
// MARK: Views Appearances

private extension ReadOriginalStoryView {
	func setupViewsAppearances() {
		setupSuggestionLabelAppearances()
		setupLinkLabelAppearances()
	}

	func setupSuggestionLabelAppearances() {
		suggestionLabel.text = "Read Original Story"
		suggestionLabel.font = .systemFont(ofSize: 18.0, weight: .heavy)
	}

	func setupLinkLabelAppearances() {
		linkLabel.text = "www.test.com"
		linkLabel.font = .systemFont(ofSize: 14.0, weight: .heavy)
		linkLabel.textColor = UIColor.systemPink
	}
}

// MARK: Views Layout

private extension ReadOriginalStoryView {
	func setupViewsLayout() {
		setupSuggestionLabelLayout()
		setupLinkLabelLayout()
		setupTapOnViewButtonLayout()
	}

	func setupSuggestionLabelLayout() {
		self.addSubview(suggestionLabel)
		suggestionLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			suggestionLabel.centerXAnchor.constraint(
				equalTo: self.centerXAnchor, constant: Constants.suggestionLabelCenterXConstant.rawValue),
			suggestionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		])
	}

	func setupLinkLabelLayout() {
		self.addSubview(linkLabel)
		linkLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			linkLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			linkLabel.topAnchor.constraint(
				equalTo: suggestionLabel.bottomAnchor, constant: Constants.linkLabelTopAnchorConstant.rawValue)
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
