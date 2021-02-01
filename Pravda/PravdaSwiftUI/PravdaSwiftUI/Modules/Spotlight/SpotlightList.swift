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
			ForEach (spotlightItems) { spotlightItem in
				ZStack {
					SpotlightRow(newsItem: spotlightItem)
					NavigationLink(destination: DetailNewsView()) {
						EmptyView()
					}
					.hidden()
				}
				.listRowInsets(EdgeInsets())
			}
		}
		.navigationTitle("Top Stories")
	}
}

struct SpotlightList_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			SpotlightList()
		}
	}
}
