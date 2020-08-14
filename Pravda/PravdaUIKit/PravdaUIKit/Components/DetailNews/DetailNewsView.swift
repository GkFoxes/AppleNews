//
//  DetailNewsView.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 05.08.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import Models

public protocol DetailNewsViewProtocol: UIView {
	func setItem(_ detailNews: DetailNewsItem)
}

public final class DetailNewsView: UIView {

	// MARK: Properties

	/// The interface is always regular, except when the width and height are equal to (.compact, .regular)
	/// default = true
	private var isLayoutCompact = true

	private var sharedConstraints: [NSLayoutConstraint] = []
	private var compactConstraints: [NSLayoutConstraint] = []
	private var regularConstraints: [NSLayoutConstraint] = []

	private enum Constants: CGFloat {
		case contentVerticalDistance = 19
		case timePublicationVerticalDistance = 10
		case upperBlockCompactVerticalDistance = 26
		case upperBlockRegularVerticalDistance = 12
		case timePublicationLabelHeight = 15
		case regularImageViewHeight = 150
		case regularImageViewWidth = 200
	}

	// MARK: Views

	private let scrollView = UIScrollView()
	private let imageView = UIImageView()
	private let titleLabel = UILabel()
	private let timePublicationLabel = UILabel()
	private let textLabel = UILabel()

	// MARK: Life Cycle

	public override init(frame: CGRect) {
		super.init(frame: frame)

		setupViewsAppearances()
		setupViewsLayout()
		changeViewsLayoutIfNeeded(traitCollection: traitCollection)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: Changes Cycle

	public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)

		changeViewsLayoutIfNeeded(traitCollection: traitCollection)
	}
}

// MARK: Setup Interface

extension DetailNewsView: DetailNewsViewProtocol {
	public func setItem(_ detailNews: DetailNewsItem) {
		imageView.image = UIImage(data: detailNews.image ?? Data())
		titleLabel.text = detailNews.title
		timePublicationLabel.text = detailNews.timePublication
		textLabel.text = detailNews.text
	}
}

// MARK: Setup Views Appearances

private extension DetailNewsView {
	func setupViewsAppearances() {
		setupViewAppearances()
		setupImageViewAppearances()
		setupTitleLabelAppearances()
		setupTimePublicationLabelAppearances()
		setupTextLabelAppearances()
	}

	func setupViewAppearances() {
		self.backgroundColor = .systemBackground
	}

	func setupImageViewAppearances() {
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
	}

	func setupTitleLabelAppearances() {
		titleLabel.font = .systemFont(ofSize: 26.0, weight: .heavy)
		titleLabel.numberOfLines = 0
	}

	func setupTimePublicationLabelAppearances() {
		timePublicationLabel.font = .systemFont(ofSize: 12.0, weight: .medium)
		timePublicationLabel.textColor = .systemGray2
	}

	func setupTextLabelAppearances() {
		textLabel.font = .systemFont(ofSize: 17.0, weight: .regular)
		textLabel.numberOfLines = 0
	}
}

// MARK: Setup Layout
private extension DetailNewsView {
	func setupViewsLayout() {
		setupSharedViewsLayout()
		configureCompactViewsLayout()
		configureRegularViewsLayout()
	}

	func changeViewsLayoutIfNeeded(traitCollection: UITraitCollection) {
		switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
		case (.compact, .regular):
			isLayoutCompact = true
			NSLayoutConstraint.deactivate(regularConstraints)
			NSLayoutConstraint.activate(compactConstraints)
		default:
			guard isLayoutCompact != false else { return }
			isLayoutCompact = false
			NSLayoutConstraint.deactivate(compactConstraints)
			NSLayoutConstraint.activate(regularConstraints)
		}
	}
}

// MARK: Setup Shared Layout

private extension DetailNewsView {
	func setupSharedViewsLayout() {
		setupScrollViewSharedLayout()
		setupImageViewSharedLayout()
		setupTitleLabelSharedLayout()
		setupTimePublicationLabelSharedLayout()
		setupTextLabelSharedLayout()

		NSLayoutConstraint.activate(sharedConstraints)
	}

	func setupScrollViewSharedLayout() {
		addSubview(scrollView)
		scrollView.translatesAutoresizingMaskIntoConstraints = false

		sharedConstraints.append(contentsOf: [
			scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
			scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
		])
	}

	func setupImageViewSharedLayout() {
		scrollView.addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false
	}

	func setupTitleLabelSharedLayout() {
		scrollView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false

		sharedConstraints.append(contentsOf: [
			titleLabel.trailingAnchor.constraint(
				equalTo: self.trailingAnchor, constant: -Constants.contentVerticalDistance.rawValue)
		])
	}

	func setupTimePublicationLabelSharedLayout() {
		scrollView.addSubview(timePublicationLabel)
		timePublicationLabel.translatesAutoresizingMaskIntoConstraints = false

		sharedConstraints.append(contentsOf: [
			timePublicationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			timePublicationLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			timePublicationLabel.heightAnchor.constraint(equalToConstant: Constants.timePublicationLabelHeight.rawValue)
		])
	}

	func setupTextLabelSharedLayout() {
		scrollView.addSubview(textLabel)
		textLabel.translatesAutoresizingMaskIntoConstraints = false

		sharedConstraints.append(contentsOf: [
			textLabel.leadingAnchor.constraint(
				equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.contentVerticalDistance.rawValue),
			textLabel.trailingAnchor.constraint(
				equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.contentVerticalDistance.rawValue),
			textLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
		])
	}
}

// MARK: Setup Compact Layout

private extension DetailNewsView {
	func configureCompactViewsLayout() {
		setupImageViewCompactLayout()
		setupTitleLabelCompactLayout()
		setupTextLabelCompactLayout()
		setupTimePublicationLabelCompactLayout()
	}

	func setupImageViewCompactLayout() {
		compactConstraints.append(contentsOf: [
			imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
			imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			// Aspect ratio height 3, weight 4
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 3/4)
		])
	}

	func setupTitleLabelCompactLayout() {
		compactConstraints.append(contentsOf: [
			titleLabel.leadingAnchor.constraint(
				equalTo: self.leadingAnchor, constant: Constants.contentVerticalDistance.rawValue),
			titleLabel.topAnchor.constraint(
				equalTo: imageView.bottomAnchor,
				constant: Constants.upperBlockCompactVerticalDistance.rawValue)
		])
	}

	func setupTimePublicationLabelCompactLayout() {
		compactConstraints.append(contentsOf: [
			timePublicationLabel.topAnchor.constraint(
				equalTo: titleLabel.bottomAnchor, constant: Constants.timePublicationVerticalDistance.rawValue)
		])
	}

	func setupTextLabelCompactLayout() {
		compactConstraints.append(contentsOf: [
			textLabel.topAnchor.constraint(
				equalTo: timePublicationLabel.bottomAnchor,
				constant: Constants.upperBlockCompactVerticalDistance.rawValue)
		])
	}
}
// MARK: Setup Regular Layout

private extension DetailNewsView {
	func configureRegularViewsLayout() {
		setupImageViewRegularLayout()
		setupTitleLabelRegularLayout()
		setupTextLabelRegularLayout()
		setupTimePublicationLabelRegularLayout()
	}

	func setupImageViewRegularLayout() {
		regularConstraints.append(contentsOf: [
			imageView.leadingAnchor.constraint(
				equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.contentVerticalDistance.rawValue),
			imageView.topAnchor.constraint(
				equalTo: scrollView.topAnchor, constant: Constants.upperBlockRegularVerticalDistance.rawValue),
			imageView.heightAnchor.constraint(equalToConstant: Constants.regularImageViewHeight.rawValue),
			imageView.widthAnchor.constraint(equalToConstant: Constants.regularImageViewWidth.rawValue)
		])
	}

	func setupTitleLabelRegularLayout() {
		regularConstraints.append(contentsOf: [
			titleLabel.leadingAnchor.constraint(
				equalTo: imageView.trailingAnchor, constant: Constants.contentVerticalDistance.rawValue),
			titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor)
		])
	}

	func setupTimePublicationLabelRegularLayout() {
		regularConstraints.append(contentsOf: [
			timePublicationLabel.topAnchor.constraint(
				greaterThanOrEqualTo: titleLabel.bottomAnchor,
				constant: Constants.timePublicationVerticalDistance.rawValue),
			timePublicationLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
		])
	}

	func setupTextLabelRegularLayout() {
		regularConstraints.append(contentsOf: [
			textLabel.topAnchor.constraint(
				equalTo: imageView.bottomAnchor,
				constant: Constants.upperBlockRegularVerticalDistance.rawValue)
		])
	}
}
