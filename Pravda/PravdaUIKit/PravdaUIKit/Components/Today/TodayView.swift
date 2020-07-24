//
//  TodayView.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 23.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import Models

public final class TodayView: UIView {

	// MARK: Properties

	private var isInterfaceCompact: Bool {
		switch getHorizontalAndVerticalSizeClasses() {
		case (.compact, .regular): return true
		default: return false
		}
	}

	private lazy var dataSource: UICollectionViewDiffableDataSource<TodaySections, TodayNewsItem> = {
		setupSectionsDataSource()
	}()

	private let collectionViewLayout: TodayCollectionViewLayoutProtocol = TodayCollectionViewLayout()

	// MARK: Views

	private lazy var collectionView: UICollectionView = {
		return UICollectionView(
			frame: .zero,
			collectionViewLayout: collectionViewLayout.makeCollectionViewCompositionalLayout(
				isInterfaceCompact: isInterfaceCompact))
	}()

	// MARK: Life Cycle

	public override init(frame: CGRect) {
		super.init(frame: frame)

		setupCollectionViewAppearances()
		setupCollectionViewLayout()
		setupDataSource()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func layoutSubviews() {
		super.layoutSubviews()

		refreshLayout()
	}

	// MARK: Changes Cycle

	public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		collectionViewLayout.setIsInterfaceCompact(isInterfaceCompact)
		dataSource.apply(getCurrentStateSnapshot(), animatingDifferences: false)
	}
}

// MARK: Collection View Delegate

extension TodayView: UICollectionViewDelegate {
	public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//		guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
//		let photoDetailVC = PhotoDetailViewController(photoURL: item.photoURL)
//		navigationController?.pushViewController(photoDetailVC, animated: true)
	}
}

// MARK: Setup Collection View

private extension TodayView {
	func setupCollectionViewAppearances() {
		collectionView.delegate = self

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

		collectionView.backgroundColor = .systemBackground
	}

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

	func refreshLayout() {
		collectionView.reloadData()
		collectionView.collectionViewLayout.invalidateLayout()
	}
}

// MARK: Setup Data Source

private extension TodayView {
	func setupDataSource() {
		//setupSectionsDataSource()
		setupSectionHeaderProvider()
		dataSource.apply(getCurrentStateSnapshot(), animatingDifferences: true)
	}

	func setupSectionsDataSource() -> UICollectionViewDiffableDataSource<TodaySections, TodayNewsItem> {
		return UICollectionViewDiffableDataSource<TodaySections, TodayNewsItem>(
			collectionView: collectionView
		) { (collectionView: UICollectionView, indexPath: IndexPath, detailItem: TodayNewsItem)
			-> UICollectionViewCell? in
			switch TodaySections.allCases[indexPath.section] {
			case .topStories, .science:
				guard let titleNewsTopicCell = collectionView.dequeueReusableCell(
					withReuseIdentifier: TitleNewsTopicCollectionViewCell.reuseIdentifer,
					for: indexPath) as? TodayCollectionViewCellProtocol
				else {
					assertionFailure("Couldn't create TitleNewsTopic Cell")
					return UICollectionViewCell()
				}

				titleNewsTopicCell.setupContent(
					image: nil,
					source: detailItem.source,
					title: detailItem.title,
					timePublication: detailItem.timePublication)
				return titleNewsTopicCell
			case .otherTopStories, .otherScience:
				guard let newsTopicCell = collectionView.dequeueReusableCell(
					withReuseIdentifier: OtherNewsTopicCollectionViewCell.reuseIdentifer,
					for: indexPath) as? TodayCollectionViewCellProtocol
				else {
					assertionFailure("Couldn't create OtherNewsTopic Cell")
					return UICollectionViewCell()
				}

				newsTopicCell.setupContent(
					image: nil,
					source: detailItem.source,
					title: detailItem.title,
					timePublication: detailItem.timePublication)
				return newsTopicCell
			}
		}
	}

	func setupSectionHeaderProvider() {
		dataSource.supplementaryViewProvider = {
			(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
			guard
				let sectionItem = self.dataSource.itemIdentifier(for: indexPath),
				let section = self.dataSource.snapshot().sectionIdentifier(containingItem: sectionItem),
				let sectionHeader = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: TodaySectionHeaderCollectionReusableView.reuseIdentifer,
					for: indexPath) as? TodaySectionHeaderCollectionReusableViewProtocol
				else {
					assertionFailure("Couldn't create TodaySectionHeader")
					return nil
			}

			sectionHeader.setupContent(title: section.rawValue, textColor: section.color)
			return sectionHeader
		}
	}

	func getCurrentStateSnapshot() -> NSDiffableDataSourceSnapshot<TodaySections, TodayNewsItem> {
		var snapshot = NSDiffableDataSourceSnapshot<TodaySections, TodayNewsItem>()
		snapshot.appendSections([.topStories, .otherTopStories, .science, .otherScience])

		let topStoriesItems = TodayNewsItem.makeTopStoriesMock(isOnlyOneItem: isInterfaceCompact)
		snapshot.appendItems(topStoriesItems, toSection: .topStories)
		let otherTopStoriesItems = TodayNewsItem.makeOtherTopStoriesMock()
		snapshot.appendItems(otherTopStoriesItems, toSection: .otherTopStories)

		let scienceItems = TodayNewsItem.makeScienceMock(isOnlyOneItem: isInterfaceCompact)
		snapshot.appendItems(scienceItems, toSection: .science)
		let otherScienceItems = TodayNewsItem.makeOtherScienceMock()
		snapshot.appendItems(otherScienceItems, toSection: .otherScience)

		return snapshot
	}
}
