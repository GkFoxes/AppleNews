//
//  SpotlightList.swift
//  PravdaSwiftUI
//
//  Created by Дмитрий Матвеенко on 31.01.2021.
//

import Models
import SwiftUI

struct SpotlightList: View {
	private var spotlightItems = SpotlightMocks.make()

	var body: some View {
		List() {
			ForEach (spotlightItems) { newsItem in
				ZStack {
					SpotlightRow(newsItem: newsItem)
					NavigationLink(destination: DetailNewsView(newsItem: newsItem)) {
						EmptyView()
					}
					.hidden()
				}
				.listRowInsets(EdgeInsets())
			}
		}
		.navigationTitle("Top Stories") // temp
	}
}

struct SpotlightList_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			SpotlightList()
		}
	}
}
