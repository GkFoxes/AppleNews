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
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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
		imageView.contentMode = .scaleAspectFit
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
		setupScrollViewLayout()
		setupImageViewLayout()
		setupTitleLabelLayout()
		setupTimePublicationLabelLayout()
		setupTextLabelLayout()
	}

	func setupScrollViewLayout() {
		addSubview(scrollView)
		scrollView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
			scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
		])
	}

	func setupImageViewLayout() {
		scrollView.addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
			imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			// Aspect ratio height 3, weight 4
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 3/4)
		])
	}

	func setupTitleLabelLayout() {
		scrollView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
			titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8)
		])
	}

	func setupTimePublicationLabelLayout() {
		scrollView.addSubview(timePublicationLabel)
		timePublicationLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			timePublicationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			timePublicationLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			timePublicationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			//timePublicationLabel.heightAnchor.constraint(equalToConstant: Constants.timePublicationLabelHeight.rawValue)
		])
	}

	func setupTextLabelLayout() {
		scrollView.addSubview(textLabel)
		textLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			textLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			textLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			textLabel.topAnchor.constraint(equalTo: timePublicationLabel.bottomAnchor, constant: 24),
			textLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
		])
	}
}
