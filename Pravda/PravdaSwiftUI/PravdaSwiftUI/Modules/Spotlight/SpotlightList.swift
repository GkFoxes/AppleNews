//
//  SpotlightList.swift
//  PravdaSwiftUI
//
//  Created by Дмитрий Матвеенко on 31.01.2021.
//

import SwiftUI

struct SpotlightList: View {
	var body: some View {
		List() {
			ForEach (0..<20) { _ in //landmark in
				ZStack {
					SpotlightRow()
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
