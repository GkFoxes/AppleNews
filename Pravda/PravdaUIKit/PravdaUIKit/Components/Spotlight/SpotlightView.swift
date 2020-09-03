//
//  SpotlightView.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 03.09.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import Models

public protocol SpotlightViewProtocol: CollectionViewProtocol {
	func setItems(_ todayNewsItems: TodayNewsItems)
}

public final class SpotlightView: UIView {

	// MARK: Properties

	public var selectedItemHandler: ((IndexPath) -> Void)?

	private let collectionViewLayout: TodayCollectionViewLayoutProtocol = TodayCollectionViewLayout()
	private let dataSource: TodayCollectionViewDiffableDataSourceProtocol
	private let output: TodayCollectionViewDelegateProtocol = TodayCollectionViewDelegate()

	// MARK: Views

	private let collectionView: UICollectionView

	// MARK: Life Cycle

	public init(todayViewController: TodayViewControllerProtocol, isCollectionCompact: Bool, frame: CGRect) {
		collectionView = UICollectionView(
			frame: frame,
			collectionViewLayout: collectionViewLayout
				.makeCollectionViewCompositionalLayout(isCollectionCompact: isCollectionCompact))

		dataSource = TodayCollectionViewDiffableDataSource(
			collectionView: collectionView, todayViewController: todayViewController)

		super.init(frame: frame)

		setupCollectionViewAppearances()
		setupCollectionViewLayout()
		setupCollectionViewDelegate()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Interface

extension SpotlightView: SpotlightViewProtocol {
	public func setItems(_ todayNewsItems: TodayNewsItems) {
		dataSource.setItems(todayNewsItems)
	}

	public func getItem(for indexPath: IndexPath) -> TodayNewsItem? {
		dataSource.getItem(for: indexPath)
	}

	public func updateCollectionView(isCollectionCompact: Bool, items: TodayNewsItems) {
		collectionViewLayout.setIsCollectionCompact(isCollectionCompact)
		dataSource.setItems(items)
	}
}

// MARK: Views Appearances

private extension SpotlightView {
	func setupCollectionViewAppearances() {
		collectionView.delegate = output

		collectionView.register(
			TitleNewsTopicCollectionViewCell.self,
			forCellWithReuseIdentifier: TitleNewsTopicCollectionViewCell.reuseIdentifer)
		collectionView.register(
			OtherNewsTopicCollectionViewCell.self,
			forCellWithReuseIdentifier: OtherNewsTopicCollectionViewCell.reuseIdentifer)
		collectionView.register(
			TodaySectionHeaderCollectionReusableView.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: TodaySectionHeaderCollectionReusableView.reuseIdentifer)
		collectionView.register(
			MoreSectionFooterCollectionReusableView.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
			withReuseIdentifier: MoreSectionFooterCollectionReusableView.reuseIdentifer)

		collectionView.backgroundColor = .systemBackground
	}
}

// MARK: View Layout

private extension SpotlightView {
	func setupCollectionViewLayout() {
		self.addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

			collectionView.topAnchor.constraint(equalTo: self.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}

	func refreshCollectionViewLayout() {
		collectionView.reloadData()
		collectionView.collectionViewLayout.invalidateLayout()
	}
}

// MARK: Collection Delegate

private extension SpotlightView {
	func setupCollectionViewDelegate() {
		setupSelectedItemHandler()
		setupDetailNewsViewController()
	}

	func setupSelectedItemHandler() {
		self.output.selectedItemHandler = { [weak self] indexPath in
			guard let self = self else { return assertionFailure() }
			self.selectedItemHandler?(indexPath)
		}
	}

	func setupDetailNewsViewController() {
		self.output.detailNewsViewControllerHandler  = { [weak self] indexPath in
			guard let self = self,
				let detailNewsViewController = self.detailNewsViewController
				else { fatalError() }
			return detailNewsViewController(indexPath)
		}
	}
}
