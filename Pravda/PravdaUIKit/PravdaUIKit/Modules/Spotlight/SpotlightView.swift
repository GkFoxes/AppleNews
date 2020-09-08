//
//  SpotlightView.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 03.09.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import Models

public protocol SpotlightViewProtocol: ListViewProtocol {
	func setItems(_ spotlightNewsItems: [SpotlightNewsItem])
	func getItem(for indexPath: IndexPath) -> SpotlightNewsItem?
}

public final class SpotlightView: UIView {

	// MARK: Properties

	public var selectedItemHandler: ((IndexPath) -> Void)?

	private let dataSource: SpotlightTableViewDataSourceProtocol = SpotlightTableViewDataSource()
	private let output = SpotlightTableViewDelegate()

	// MARK: Views

	private let tableView: UITableView

	// MARK: Life Cycle

	override init(frame: CGRect) {
		tableView = UITableView(frame: frame)

		super.init(frame: frame)

		setupTableViewAppearances()
		setupTableViewLayout()
		setupSelectedItemHandler()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: View Interface

extension SpotlightView: SpotlightViewProtocol {
	public func setItems(_ spotlightNewsItems: [SpotlightNewsItem]) {
		dataSource.setItems(spotlightNewsItems)
	}

	public func getItem(for indexPath: IndexPath) -> SpotlightNewsItem? {
		dataSource.getItem(for: indexPath)
	}
}

// MARK: Views Appearances

private extension SpotlightView {
	func setupTableViewAppearances() {
		tableView.delegate = output

		tableView.register(
			SpotlightTableViewCell.self,
			forCellReuseIdentifier: SpotlightTableViewCell.reuseIdentifer)

		tableView.backgroundColor = .systemBackground
	}
}

// MARK: View Layout

private extension SpotlightView {
	func setupTableViewLayout() {
		self.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

			tableView.topAnchor.constraint(equalTo: self.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
}

// MARK: Table Delegate

private extension SpotlightView {
	func setupSelectedItemHandler() {
		self.output.selectedItemHandler = { [weak self] indexPath in
			guard let self = self else { return assertionFailure() }
			self.selectedItemHandler?(indexPath)
		}
	}
}
