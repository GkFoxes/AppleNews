//
//  TodayView.swift
//  PravdaSwiftUI
//
//  Created by Дмитрий Матвеенко on 29.01.2021.
//

import Constants
import SwiftUI

struct TodayView: View {
	init () {
		UINavigationBar.appearance().setupBlackDesignAppearances()
	}

	var body: some View {
		NavigationView {
			NavigationLink(destination: SpotlightList()) {
				Text("Open SpotlightList")
			}
			.navigationBarTitle(Strings.todayNavigationTitle.rawValue)
		}
	}
}

struct TodayView_Previews: PreviewProvider {
	static var previews: some View {
		TodayView()
	}
}
