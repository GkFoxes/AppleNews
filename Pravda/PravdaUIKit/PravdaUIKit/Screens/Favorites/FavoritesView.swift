//
//  FavoritesView.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 16.09.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import Models

public protocol FavoritesViewProtocol: ListViewProtocol {
	func setItems(_ favoritesNewsItems: [FavoritesNewsItem])
	func getItem(for indexPath: IndexPath) -> FavoritesNewsItem?
}

public final class FavoritesView: UIView {

	// MARK: Properties

	public var selectedItemHandler: ((IndexPath) -> Void)?

	private let dataSource: FavoritesCollectionViewDataSourceProtocol = FavoritesCollectionViewDataSource()
	private let output = FavoritesCollectionViewDelegate()

	// MARK: Views

	private let collectionView: UICollectionView

	// MARK: Life Cycle

	override init(frame: CGRect) {
		collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())

		super.init(frame: frame)

		setupCollectionViewAppearances()
		setupCollectionViewLayout()
		setupSelectedItemHandler()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: View Interface

extension FavoritesView: FavoritesViewProtocol {
	public func setItems(_ favoritesNewsItems: [FavoritesNewsItem]) {
		dataSource.setItems(favoritesNewsItems)
	}

	public func getItem(for indexPath: IndexPath) -> FavoritesNewsItem? {
		dataSource.getItem(for: indexPath)
	}
}

// MARK: Views Appearances

private extension FavoritesView {
	func setupCollectionViewAppearances() {
		collectionView.delegate = output
		collectionView.dataSource = dataSource

		collectionView.register(
			FavoritesCollectionViewCell.self,
			forCellWithReuseIdentifier: FavoritesCollectionViewCell.reuseIdentifer)

		collectionView.backgroundColor = .systemBackground
	}
}

// MARK: View Layout

private extension FavoritesView {
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
}

// MARK: Table Delegate

private extension FavoritesView {
	func setupSelectedItemHandler() {
		self.output.selectedItemHandler = { [weak self] indexPath in
			guard let self = self else { return assertionFailure() }
			self.selectedItemHandler?(indexPath)
		}
	}
}
