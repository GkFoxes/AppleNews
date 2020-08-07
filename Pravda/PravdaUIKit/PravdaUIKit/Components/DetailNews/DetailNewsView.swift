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
	}

	func setupTitleLabelAppearances() {
		titleLabel.font = .systemFont(ofSize: 22.0, weight: .heavy)
		titleLabel.numberOfLines = 0
	}

	func setupTimePublicationLabelAppearances() {
		timePublicationLabel.font = .systemFont(ofSize: 10.0, weight: .medium)
		timePublicationLabel.textColor = .systemGray2
	}

	func setupTextLabelAppearances() {
		textLabel.font = .systemFont(ofSize: 17.0, weight: .semibold)
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

		sharedConstraints.append(contentsOf: [
			imageView.topAnchor.constraint(equalTo: scrollView.topAnchor)
		])
	}

	func setupTitleLabelSharedLayout() {
		scrollView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false

		sharedConstraints.append(contentsOf: [
			titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 16)
		])
	}

	func setupTimePublicationLabelSharedLayout() {
		scrollView.addSubview(timePublicationLabel)
		timePublicationLabel.translatesAutoresizingMaskIntoConstraints = false

		sharedConstraints.append(contentsOf: [
			timePublicationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			timePublicationLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			timePublicationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			//timePublicationLabel.heightAnchor.constraint(equalToConstant: Constants.timePublicationLabelHeight.rawValue)
			// Make Constants enum
		])
	}

	func setupTextLabelSharedLayout() {
		scrollView.addSubview(textLabel)
		textLabel.translatesAutoresizingMaskIntoConstraints = false

		sharedConstraints.append(contentsOf: [
			textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
			textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16),
			textLabel.topAnchor.constraint(equalTo: timePublicationLabel.bottomAnchor, constant: 24),
			textLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
		])
	}
}

// MARK: Setup Compact Layout

private extension DetailNewsView {
	func configureCompactViewsLayout() {
		setupImageViewCompactLayout()
		setupTitleLabelCompactLayout()
	}

	func setupImageViewCompactLayout() {
		compactConstraints.append(contentsOf: [
			imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
			// Aspect ratio height 3, weight 4
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 3/4)
		])
	}

	func setupTitleLabelCompactLayout() {
		compactConstraints.append(contentsOf: [
			titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
			titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8)
		])
	}
}
// MARK: Setup Regular Layout

private extension DetailNewsView {
	func configureRegularViewsLayout() {
		setupImageViewRegularLayout()
		setupTitleLabelRegularLayout()
	}

	func setupImageViewRegularLayout() {()
		regularConstraints.append(contentsOf: [
			imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
			imageView.heightAnchor.constraint(equalToConstant: 150),
			imageView.widthAnchor.constraint(equalToConstant: 200)
		])
	}

	func setupTitleLabelRegularLayout() {
		regularConstraints.append(contentsOf: [
			titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
			titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor)
		])
	}
}
