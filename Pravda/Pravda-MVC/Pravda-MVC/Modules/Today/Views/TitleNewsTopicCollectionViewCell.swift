//
//  TitleNewsTopicCollectionViewCell.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий Владимирович on 15.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import PravdaUIKit

protocol TitleNewsTopicCollectionViewCellProtocol: UICollectionViewCell {
	static var reuseIdentifer: String { get }

	func setupContent(image: UIImage?, source: String, title: String, timePublication: String)
}

class TitleNewsTopicCollectionViewCell: UICollectionViewCell {

	// MARK: Views

	private let imageView = UIImageView()
	private let sourceLabel = UILabel()
	private let titleLabel = UILabel()
	private let timePublicationLabel = UILabel()

	// MARK: Life Cycle

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupViewsAppearances()
		setupViewsLayout()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension TitleNewsTopicCollectionViewCell: TitleNewsTopicCollectionViewCellProtocol {
	static var reuseIdentifer: String {
		return String(describing: TitleNewsTopicCollectionViewCell.self)
	}

	func setupContent(image: UIImage?, source: String, title: String, timePublication: String) {
		imageView.image = Assets.todayTab.image
		sourceLabel.text = source
		titleLabel.text = title
		timePublicationLabel.text = timePublication
	}
}

// MARK: Setup Views Appearances

private extension TitleNewsTopicCollectionViewCell {
	func setupViewsAppearances() {
		setupImageViewAppearances()
		setupSourceLabelAppearances()
		setupTitleLabelAppearances()
		setupTimePublicationLabelAppearances()
	}

	func setupImageViewAppearances() {
		imageView.layer.cornerRadius = 4
	}

	func setupSourceLabelAppearances() {
		sourceLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
	}

	func setupTitleLabelAppearances() {
		titleLabel.font = UIFont.systemFont(ofSize: 21.0, weight: .bold)
	}

	func setupTimePublicationLabelAppearances() {
		titleLabel.font = UIFont.systemFont(ofSize: 11.0, weight: .regular)
	}
}

// MARK: Setup Cell Layout

private extension TitleNewsTopicCollectionViewCell {
	func setupViewsLayout() {
		setupImageViewLayout()
		setupSourceLabelLayout()
		setupTitleLabelLayout()
	}

	func setupImageViewLayout() {
		contentView.addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			// Aspect ratio 4:3
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 4/3),

			imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

			imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
		])
	}

	func setupSourceLabelLayout() {
		contentView.addSubview(sourceLabel)
		sourceLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			sourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

			imageView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4)
		])
	}

	func setupTitleLabelLayout() {
		contentView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

			titleLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 4)
		])
	}

	func setupTimePublicationLabelLayout() {
		contentView.addSubview(timePublicationLabel)
		timePublicationLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			timePublicationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			timePublicationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

			timePublicationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
		])
	}
}

// MARK: Setup Canvas

import SwiftUI

struct TitleNewsTopicCollectionViewCellProvider: PreviewProvider {

	static var previews: some View {
		ContainerView().edgesIgnoringSafeArea(.all)
	}

	struct ContainerView: UIViewControllerRepresentable {
		func makeUIViewController(
			context: UIViewControllerRepresentableContext<TitleNewsTopicCollectionViewCellProvider.ContainerView>
		) -> TodayViewController {
			return TodayViewController()
		}

		func updateUIViewController(
			_ uiViewController: TitleNewsTopicCollectionViewCellProvider.ContainerView.UIViewControllerType,
			context: UIViewControllerRepresentableContext<TitleNewsTopicCollectionViewCellProvider.ContainerView>
		) { }
	}
}
