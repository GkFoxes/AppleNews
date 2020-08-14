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

// MARK: Button Actions

private extension ReadOriginalStoryView {
	@objc func tapOnViewAction(_ sender: UIButton) {
		print("Button tapped")
	}
}

// MARK: Views Appearances

private extension ReadOriginalStoryView {
	func setupViewsAppearances() {
		setupSuggestionLabelAppearances()
		setupLinkLabelAppearances()
		setupTapOnViewButtonAppearances()
	}

	func setupSuggestionLabelAppearances() {
		suggestionLabel.text = "Read Full Story"
		suggestionLabel.font = .systemFont(ofSize: 16.0, weight: .medium)
	}

	func setupLinkLabelAppearances() {
		linkLabel.font = .systemFont(ofSize: 11.0, weight: .medium)
		linkLabel.textColor = UIColor.systemPink
	}

	func setupTapOnViewButtonAppearances() {
		tapOnViewButton.addTarget(self, action: #selector(tapOnViewAction), for: .touchUpInside)
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
			suggestionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			suggestionLabel.centerYAnchor.constraint(
				equalTo: self.centerYAnchor, constant: Constants.suggestionLabelCenterXConstant.rawValue)
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
