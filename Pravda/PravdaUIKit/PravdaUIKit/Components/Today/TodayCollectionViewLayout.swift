//
//  TodayCollectionViewLayout.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 23.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import Models

protocol TodayCollectionViewLayoutProtocol: UICollectionViewLayout {
	func setIsInterfaceCompact(_ isInterfaceCompact: Bool)
	func makeCollectionViewCompositionalLayout(isInterfaceCompact: Bool) -> UICollectionViewLayout
}

final class TodayCollectionViewLayout: UICollectionViewLayout {

	// MARK: Properties

	var isInterfaceCompact = true
}

// MARK: Setup Protocol

extension TodayCollectionViewLayout: TodayCollectionViewLayoutProtocol {
	func setIsInterfaceCompact(_ isInterfaceCompact: Bool) {
		self.isInterfaceCompact = isInterfaceCompact
	}

	func makeCollectionViewCompositionalLayout(isInterfaceCompact: Bool) -> UICollectionViewLayout {
		self.isInterfaceCompact = isInterfaceCompact

		let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _) -> NSCollectionLayoutSection? in
			guard let self = self else {
				assertionFailure()
				return nil
			}

			switch TodaySections.allCases[sectionIndex] {
			case .topStories, .science: return self.makeTitleNewsLayoutSection()
			case .otherTopStories, .otherScience: return self.makeOtherNewsLayoutSection()
			}
		}

		return layout
	}
}

private extension TodayCollectionViewLayout {
	func makeSectionHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
		let sectionHeaderLayoutSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .estimated(TodaySectionHeaderCollectionReusableView.getEstimatedHeight()))

		let sectionHeaderLayout = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: sectionHeaderLayoutSize,
			elementKind: UICollectionView.elementKindSectionHeader,
			alignment: .top)
		return sectionHeaderLayout
	}

	func makeTitleNewsLayoutSection() -> NSCollectionLayoutSection {
		let topStoriesLayoutSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .estimated(TitleNewsTopicCollectionViewCell.getEstimatedHeight()))
		let titleNewsTopicItem = NSCollectionLayoutItem(layoutSize: topStoriesLayoutSize)

		let topStoriesGroup = NSCollectionLayoutGroup.horizontal(
			layoutSize: topStoriesLayoutSize, subitem: titleNewsTopicItem, count: isInterfaceCompact ? 1 : 2)
		topStoriesGroup.interItemSpacing = .fixed(TodayLayout.safeHorizontalDistance.rawValue)
		topStoriesGroup.contentInsets = NSDirectionalEdgeInsets(
			top: 0,
			leading: TodayLayout.safeHorizontalDistance.rawValue,
			bottom: 0,
			trailing: TodayLayout.safeHorizontalDistance.rawValue)

		let section = NSCollectionLayoutSection(group: topStoriesGroup)
		section.boundarySupplementaryItems = [makeSectionHeaderLayout()]
		return section
	}

	func makeOtherNewsLayoutSection() -> NSCollectionLayoutSection {
		let newsTopicItemLayoutSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .estimated(OtherNewsTopicCollectionViewCell.getEstimatedHeight()))
		let newsTopicItem = NSCollectionLayoutItem(layoutSize: newsTopicItemLayoutSize)

		let newsItemsInGroupCount = 2
		let newsGroupLayoutSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(isInterfaceCompact ? 0.85 : 0.425),
			heightDimension: .estimated(
				CGFloat(newsItemsInGroupCount) * OtherNewsTopicCollectionViewCell.getEstimatedHeight()))
		let newsGroup = NSCollectionLayoutGroup.vertical(
			layoutSize: newsGroupLayoutSize, subitem: newsTopicItem, count: newsItemsInGroupCount)
		newsGroup.interItemSpacing = .fixed(TodayLayout.topicHorizontalDistance.rawValue)
		newsGroup.contentInsets = NSDirectionalEdgeInsets(
			top: 0, leading: 0, bottom: 0, trailing: TodayLayout.safeHorizontalDistance.rawValue)

		let section = NSCollectionLayoutSection(group: newsGroup)
		section.orthogonalScrollingBehavior = .groupPaging
		section.contentInsets = NSDirectionalEdgeInsets(
			top: 0,
			leading: TodayLayout.safeHorizontalDistance.rawValue,
			bottom: TodayLayout.topicHorizontalDistance.rawValue,
			trailing: TodayLayout.safeHorizontalDistance.rawValue)

		return section
	}
}
