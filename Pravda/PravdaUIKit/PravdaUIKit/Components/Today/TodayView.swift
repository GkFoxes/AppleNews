//
//  TodayView.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 23.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import Models

public protocol TodayViewProtocol: UIView {
	func refreshLayout()
}

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

	// MARK: Views

	private lazy var collectionView: UICollectionView = {
		return UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewCompositionalLayout())
	}()

	// MARK: Life Cycle

	public init() {
		super.init(frame: .zero)

		setupCollectionViewAppearances()
		setupCollectionViewLayout()
		setupDataSource()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		dataSource.apply(getCurrentStateSnapshot(), animatingDifferences: false)
	}
}

// MARK: Setup View Protocol

extension TodayView: TodayViewProtocol {
	public func refreshLayout() {
		collectionView.reloadData()
		collectionView.collectionViewLayout.invalidateLayout()
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

// MARK: Setup Collection Appearances

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
}

// MARK: Setup Collection Layout

private extension TodayView {
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

	func makeCollectionViewCompositionalLayout() -> UICollectionViewLayout {
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
