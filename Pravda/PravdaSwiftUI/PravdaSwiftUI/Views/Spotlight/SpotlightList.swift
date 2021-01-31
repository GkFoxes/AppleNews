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
				NavigationLink(destination: DetailNewsView()) {
					SpotlightRow()
				}
				.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
			}
		}
		.listStyle(InsetListStyle())
		.navigationBarTitle(
			Text("Top Stories")
				.fontWeight(.black))
	}
}

struct SpotlightList_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			SpotlightList()
				.navigationBarTitle("Top Stories")
		}
	}
}
