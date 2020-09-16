//
//  FavoritesView.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 16.09.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import Models

public protocol FavoritesViewProtocol: ListViewProtocol {
	func setItems(_ spotlightNewsItems: [SpotlightNewsItem])
	func getItem(for indexPath: IndexPath) -> SpotlightNewsItem?
}

public final class FavoritesView: UIView {

	// MARK: Properties

	public var selectedItemHandler: ((IndexPath) -> Void)?

	private let dataSource: SpotlightTableViewDataSourceProtocol = SpotlightTableViewDataSource()
	private let output = SpotlightTableViewDelegate()

	// MARK: Views

	private let collectionView: UICollectionView

	// MARK: Life Cycle

	override init(frame: CGRect) {
		tableView = UITableView(frame: frame)

		super.init(frame: frame)

		setupTableViewAppearances()
		setupTableViewLayout()
		setupSelectedItemHandler()
	}

	public func viewWillAppear(_ animated: Bool) {
		if let selectedIndexPath = tableView.indexPathForSelectedRow {
			tableView.deselectRow(at: selectedIndexPath, animated: animated)
		}
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
