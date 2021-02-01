//
//  SpotlightRow.swift
//  PravdaSwiftUI
//
//  Created by Дмитрий Матвеенко on 31.01.2021.
//

import SwiftUI

struct SpotlightRow: View {
	var body: some View {
		VStack(alignment: .leading) {
			Text("Title")
				.font(.system(size: 16))
				.fontWeight(.bold)
			HStack {
				Text("Source")
					.font(.system(size: 11))
					.fontWeight(.semibold)
					.foregroundColor(Color(UIColor.systemGray))
				Spacer()
				Text("30 October 10:30")
					.font(.system(size: 10))
					.fontWeight(.medium)
					.foregroundColor(Color(UIColor.systemGray2))
			}
		}
		.padding(.horizontal, 10)
		.padding(.vertical, 6)
	}
}

struct SpotlightRow_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			SpotlightRow()
				.previewLayout(.fixed(width: 375, height: 50))
			SpotlightRow()
				.previewLayout(.fixed(width: 375, height: 50))
				.colorScheme(.dark)

		}
	}
}
