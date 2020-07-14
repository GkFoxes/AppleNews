//
//  TodayViewController.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий on 17.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import PravdaUIKit

final class TodayViewController: UIViewController {

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

		self.view.backgroundColor = .red
		self.navigationController?.setupBlackDesignAppearances()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

//		if let splitController = self.splitViewController {
//			self.navigationItem.leftBarButtonItem = splitController.displayModeButtonItem
//		}
	}
}

// MARK: Setup Canvas

import SwiftUI

struct MyProvider: PreviewProvider {

	static var previews: some View {
		ContainerView().edgesIgnoringSafeArea(.all)
	}

	struct ContainerView: UIViewControllerRepresentable {
		func makeUIViewController(
			context: UIViewControllerRepresentableContext<MyProvider.ContainerView>
		) -> TodayViewController {
			return TodayViewController()
		}

		func updateUIViewController(
			_ uiViewController: MyProvider.ContainerView.UIViewControllerType,
			context: UIViewControllerRepresentableContext<MyProvider.ContainerView>
		) { }
	}
}
