//
//  TodayView.swift
//  PravdaSwiftUI
//
//  Created by Дмитрий Матвеенко on 29.01.2021.
//

import SwiftUI

struct TodayView: View {
	var body: some View {
		NavigationView {
			NavigationLink(destination: SpotlightList()) {
				Text("Open SpotlightList")
			}
			.navigationBarTitle("News")
		}
	}
}

struct TodayView_Previews: PreviewProvider {
	static var previews: some View {
		TodayView()
	}
}
