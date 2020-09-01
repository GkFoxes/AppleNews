//
//  TodayCollectionViewDiffableDataSource.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 23.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import Models

typealias TodayDiffableDataSource = UICollectionViewDiffableDataSource<TodaySections, TodayNewsItem>

protocol TodayCollectionViewDiffableDataSourceProtocol: TodayDiffableDataSource {
	func setItems(_ todayNewsItems: TodayNewsItems)
	func getItem(for indexPath: IndexPath) -> TodayNewsItem?
}

final class TodayCollectionViewDiffableDataSource: TodayDiffableDataSource {

	// MARK: Properties

	private var todayNewsItems = TodayNewsItems()

	// MARK: Life Cycle

	init(collectionView: UICollectionView) {
		super.init(
		collectionView: collectionView
		) { (collectionView: UICollectionView, indexPath: IndexPath, detailItem: TodayNewsItem)
			-> UICollectionViewCell? in
			return TodayCollectionViewDiffableDataSource.setupCellsDataSource(
				collectionView: collectionView, indexPath: indexPath, detailItem: detailItem)
		}
	}
}

// MARK: Interface

extension TodayCollectionViewDiffableDataSource: TodayCollectionViewDiffableDataSourceProtocol {
	func setItems(_ todayNewsItems: TodayNewsItems) {
		self.todayNewsItems = todayNewsItems
		setupSupplementaryViewProvider()
		applyCurrentStateSnapshot()
	}

	func getItem(for indexPath: IndexPath) -> TodayNewsItem? {
		return self.itemIdentifier(for: indexPath)
	}
}

// MARK: Data Snapshot

private extension TodayCollectionViewDiffableDataSource {
	static func setupCellsDataSource(
		collectionView: UICollectionView,
		indexPath: IndexPath,
		detailItem: TodayNewsItem
	) -> UICollectionViewCell? {
		var newsCell: TodayCollectionViewCellProtocol?

		switch TodaySections.allCases[indexPath.section] {
		case .topStories, .science:
			let titleNewsTopicCell = collectionView.tryDequeueReusableTodayCell(
				withReuseIdentifier: TitleNewsTopicCollectionViewCell.reuseIdentifer,
				for: indexPath)
			newsCell = titleNewsTopicCell
		case .otherTopStories, .otherScience:
			let newsTopicCell = collectionView.tryDequeueReusableTodayCell(
				withReuseIdentifier: OtherNewsTopicCollectionViewCell.reuseIdentifer,
				for: indexPath)
			newsCell = newsTopicCell
		}

		if let newsCell = newsCell {
			newsCell.setupContent(
				headerImage: nil,
				source: detailItem.source,
				title: detailItem.title,
				timePublication: detailItem.timePublication)
			return newsCell
		} else {
			assertionFailure()
			return UICollectionViewCell()
		}
	}

	func setupSupplementaryViewProvider() {
		self.supplementaryViewProvider = {
			(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
			guard let sectionItem = self.itemIdentifier(for: indexPath),
				let section = self.snapshot().sectionIdentifier(containingItem: sectionItem)
				else { assertionFailure(); return nil }

			if kind == "UICollectionElementKindSectionHeader" {
					let sectionHeader = collectionView.dequeueReusableSupplementaryView(
						ofKind: kind,
						withReuseIdentifier: TodaySectionHeaderCollectionReusableView.reuseIdentifer,
						for: indexPath) as? TodaySectionHeaderCollectionReusableViewProtocol
				sectionHeader?.setupContent(title: section.rawValue, textColor: section.color)
				return sectionHeader
			} else {
					let sectionFooter = collectionView.dequeueReusableSupplementaryView(
						ofKind: kind,
						withReuseIdentifier: MoreSectionFooterCollectionReusableView.reuseIdentifer,
						for: indexPath) as? MoreSectionFooterCollectionReusableViewProtocol
				sectionFooter?.setupContent(sectionTitle: section.rawValue, sectionColor: section.color)
				return sectionFooter
			}
		}
	}

	func applyCurrentStateSnapshot() {
		self.apply(self.getCurrentStateSnapshot(), animatingDifferences: true)
	}

	func getCurrentStateSnapshot() -> NSDiffableDataSourceSnapshot<TodaySections, TodayNewsItem> {
		var snapshot = NSDiffableDataSourceSnapshot<TodaySections, TodayNewsItem>()
		snapshot.appendSections([.topStories, .otherTopStories, .science, .otherScience])

		snapshot.appendItems(todayNewsItems.topStoriesItems, toSection: .topStories)
		snapshot.appendItems(todayNewsItems.otherTopStoriesItems, toSection: .otherTopStories)
		snapshot.appendItems(todayNewsItems.scienceItems, toSection: .science)
		snapshot.appendItems(todayNewsItems.otherScienceItems, toSection: .otherScience)

		return snapshot
	}
}
