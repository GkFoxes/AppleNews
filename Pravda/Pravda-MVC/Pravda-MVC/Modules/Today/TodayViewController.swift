//
//  TodayViewController.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий on 17.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import PravdaUIKit

final class TodayViewController: UIViewController {

	// MARK: Properties

	private lazy var dataSource: UICollectionViewDiffableDataSource<TodaySections, TodayNewsItem> = {
		makeCollectionViewDiffableDataSource()
	}()

	// MARK: Views

	private lazy var collectionView: UICollectionView = {
		return UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewCompositionalLayout())
	}()

	// MARK: Life Cycle

	init() {
		super.init(nibName: nil, bundle: nil)

		self.navigationItem.title = Strings.todayNavigationTitle.rawValue
		self.tabBarItem.title = Strings.todayTabTitle.rawValue
		self.tabBarItem.image = Assets.todayTab.image
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		super.loadView()

		self.navigationController?.setupBlackDesignAppearances()

		setupCollectionViewAppearances()
		setupCollectionViewLayout()
		setupDataSource()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		/*
		if let splitController = self.splitViewController {
			self.navigationItem.leftBarButtonItem = splitController.displayModeButtonItem
		}*/
	}
}

// MARK: Collection View Delegate

extension TodayViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//		guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
//		let photoDetailVC = PhotoDetailViewController(photoURL: item.photoURL)
//		navigationController?.pushViewController(photoDetailVC, animated: true)
	}
}

// MARK: Setup Collection Appearances

private extension TodayViewController {
	func setupCollectionViewAppearances() {
		collectionView.delegate = self

		collectionView.register(
			TitleNewsTopicCollectionViewCell.self,
			forCellWithReuseIdentifier: TitleNewsTopicCollectionViewCell.reuseIdentifer)
		collectionView.register(
			TodaySectionHeaderCollectionReusableView.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: TodaySectionHeaderCollectionReusableView.reuseIdentifer)

		collectionView.backgroundColor = .systemBackground
	}
}

// MARK: Setup Collection Layout

private extension TodayViewController {
	func setupCollectionViewLayout() {
		view.addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}

	func makeCollectionViewCompositionalLayout() -> UICollectionViewLayout {
		let topStoriesLayoutSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .estimated(TitleNewsTopicCollectionViewCell.getEstimatedHeight()))
		let titleNewsTopicItem = NSCollectionLayoutItem(layoutSize: topStoriesLayoutSize)

		let topStoriesGroup = NSCollectionLayoutGroup.horizontal(
			layoutSize: topStoriesLayoutSize, subitem: titleNewsTopicItem, count: 1)
		topStoriesGroup.contentInsets = NSDirectionalEdgeInsets(
			top: 0,
			leading: TodayLayout.horizontalInsets.rawValue,
			bottom: 0,
			trailing: TodayLayout.horizontalInsets.rawValue)

		let section = NSCollectionLayoutSection(group: topStoriesGroup)
		section.boundarySupplementaryItems = [makeSectionHeaderLayout()]

		let layout = UICollectionViewCompositionalLayout(section: section)
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
}

// MARK: Setup Data Source

private extension TodayViewController {
	func makeCollectionViewDiffableDataSource() -> UICollectionViewDiffableDataSource<TodaySections, TodayNewsItem> {
		return UICollectionViewDiffableDataSource<TodaySections, TodayNewsItem>(
			collectionView: collectionView
		) { (collectionView: UICollectionView, indexPath: IndexPath, detailItem: TodayNewsItem)
			-> UICollectionViewCell? in
			guard let titleNewsTopicCell = collectionView.dequeueReusableCell(
				withReuseIdentifier: TitleNewsTopicCollectionViewCell.reuseIdentifer,
				for: indexPath) as? TitleNewsTopicCollectionViewCellProtocol
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
		}
	}

	func setupDataSource() {
		setupSectionHeaderProvider()
		dataSource.apply(getCurrentStateSnapshot(), animatingDifferences: true)
	}

	func getCurrentStateSnapshot() -> NSDiffableDataSourceSnapshot<TodaySections, TodayNewsItem> {
		var snapshot = NSDiffableDataSourceSnapshot<TodaySections, TodayNewsItem>()
		snapshot.appendSections([.topStories, .science])

		let topStoriesItems = TodayNewsItem.makeTopStoriesMock()
		snapshot.appendItems(topStoriesItems, toSection: .topStories)

		let scienceItems = TodayNewsItem.makeScienceMock()
		snapshot.appendItems(scienceItems, toSection: .science)

		return snapshot
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
}
