//
//  SpotlightList.swift
//  PravdaSwiftUI
//
//  Created by Дмитрий Матвеенко on 31.01.2021.
//

import Models
import Constants
import SwiftUI

struct SpotlightList: View {
	private var spotlightItems = SpotlightMocks.make()

	init() {
		UINavigationBar.appearance().setupBlackDesignAppearances()
	}

	var body: some View {
		NavigationView {
			List(spotlightItems) { newsItem in
				NavigationLink(destination: DetailNewsView(newsItem: newsItem)) {
					SpotlightRow(newsItem: newsItem)
				}
			}
			.listStyle(PlainListStyle())
			.navigationTitle(Strings.todayNavigationTitle.rawValue)
		}
	}
}

struct SpotlightList_Previews: PreviewProvider {
	static var previews: some View {
		SpotlightList()
	}
}
