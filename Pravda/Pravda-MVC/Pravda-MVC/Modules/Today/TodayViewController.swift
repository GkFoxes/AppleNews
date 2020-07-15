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

//	private lazy var dataSource: UICollectionViewDiffableDataSource<TodaySections, TodayNewsItem> = {
//		setupCollectionViewDataSource()
//	}()
	private var dataSource: UICollectionViewDiffableDataSource<TodaySections, TodayNewsItem>!

	// MARK: Views

	private lazy var collectionView: UICollectionView = {
		return UICollectionView(frame: view.bounds, collectionViewLayout: setupCollectionViewCompositionalLayout())
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
		setupCollectionViewDataSource()
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
			forCellWithReuseIdentifier: TitleNewsTopicCollectionViewCell.reuseIdentifer
		)

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

	func setupCollectionViewCompositionalLayout() -> UICollectionViewLayout {
		let titleNewsTopicItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .fractionalHeight(1.0)
		))

		titleNewsTopicItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)

		let topStoriesGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .fractionalHeight(1/3)
		), subitems: [titleNewsTopicItem])

		let section = NSCollectionLayoutSection(group: topStoriesGroup)
		let layout = UICollectionViewCompositionalLayout(section: section)
		return layout
	}
}

// MARK: Setup Data Source

private extension TodayViewController {
	func setupCollectionViewDataSource() {
		dataSource = UICollectionViewDiffableDataSource<TodaySections, TodayNewsItem>(
			collectionView: collectionView
		) { (collectionView: UICollectionView, indexPath: IndexPath, detailItem: TodayNewsItem)
			-> UICollectionViewCell? in
			guard let titleNewsTopicCell = collectionView.dequeueReusableCell(
				withReuseIdentifier: TitleNewsTopicCollectionViewCell.reuseIdentifer,
				for: indexPath
				) as? TitleNewsTopicCollectionViewCellProtocol
			else {
				assertionFailure("Couldn't create TitleNewsTopic Cell")
				return UICollectionViewCell()
			}

			titleNewsTopicCell.setupContent(
				image: nil,
				source: detailItem.source,
				title: detailItem.title,
				timePublication: detailItem.timePublication
			)
			return titleNewsTopicCell
		}

		let snapshot = getCurrentStateSnapshot()
		dataSource.apply(snapshot, animatingDifferences: true)
	}

	func getCurrentStateSnapshot() -> NSDiffableDataSourceSnapshot<TodaySections, TodayNewsItem> {
		var snapshot = NSDiffableDataSourceSnapshot<TodaySections, TodayNewsItem>()
		snapshot.appendSections([TodaySections.topStories])

		let todayNewsItems = [
			TodayNewsItem(imageURL: nil, source: "foo", title: "foo", timePublication: "foo"),
			TodayNewsItem(imageURL: nil, source: "bar", title: "bar", timePublication: "bar"),
			TodayNewsItem(imageURL: nil, source: "baz", title: "baz", timePublication: "baz"),
			TodayNewsItem(imageURL: nil, source: "foo", title: "bar", timePublication: "baz")
		]

		snapshot.appendItems(todayNewsItems)
		return snapshot
	}
}

// MARK: Setup Canvas

import SwiftUI

struct TodayViewControllerProvider: PreviewProvider {

	static var previews: some View {
		ContainerView().edgesIgnoringSafeArea(.all)
	}

	struct ContainerView: UIViewControllerRepresentable {
		func makeUIViewController(
			context: UIViewControllerRepresentableContext<TodayViewControllerProvider.ContainerView>
		) -> TodayViewController {
			return TodayViewController()
		}

		func updateUIViewController(
			_ uiViewController: TodayViewControllerProvider.ContainerView.UIViewControllerType,
			context: UIViewControllerRepresentableContext<TodayViewControllerProvider.ContainerView>
		) { }
	}
}
