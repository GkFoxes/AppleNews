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

	public override class var requiresConstraintBasedLayout: Bool { return true }

	public var selectedItemHandler: ((IndexPath) -> Void)?
	private let output: CollectionViewDelegateProtocol = TodayCollectionViewDelegate()
	private var isCollectionCompact: Bool {
		switch getHorizontalAndVerticalSizeClasses() {
		case (.compact, .regular): return true
		default: return false
		}
	}

	private let dataSource: TodayCollectionViewDiffableDataSourceProtocol

	private let collectionViewLayout: TodayCollectionViewLayoutProtocol = TodayCollectionViewLayout()

	// MARK: Views

	private let collectionView: UICollectionView

	// MARK: Life Cycle

	public init(isCollectionCompact: Bool, frame: CGRect) {
		collectionView = UICollectionView(
			frame: frame,
			collectionViewLayout: collectionViewLayout
				.makeCollectionViewCompositionalLayout(isCollectionCompact: isCollectionCompact))

		dataSource = TodayCollectionViewDiffableDataSource(collectionView: collectionView)

		super.init(frame: frame)

		setupCollectionViewAppearances()
		setupCollectionViewLayout()
		dataSource.setupDataSourceForView(isCollectionCompact: isCollectionCompact)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: Changes Cycle

	public override func layoutSubviews() {
		super.layoutSubviews()

		setupCollectionViewLayout()
		refreshLayout()
	}

	public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		collectionViewLayout.setIsCollectionCompact(isCollectionCompact)
		dataSource.applyCurrentStateSnapshot(isCollectionCompact: isCollectionCompact)
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

// MARK: View Layout

private extension TodayView {
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

// MARK: Collection Delegate

private extension TodayView {
	func setupCollectionViewDelegate() {
		self.output.selectedItemHandler = { [weak self] indexPath in
			guard let self = self else { return assertionFailure() }
			self.selectedItemHandler?(indexPath)
		}
	}
}