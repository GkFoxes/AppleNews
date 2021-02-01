//
//  SpotlightRow.swift
//  PravdaSwiftUI
//
//  Created by Дмитрий Матвеенко on 31.01.2021.
//

import Models
import SwiftUI

struct SpotlightRow: View {
	let newsItem: NewsItem

	var body: some View {
		VStack(alignment: .leading, spacing: 4) {
			Text(newsItem.title)
				.font(.system(size: 16))
				.fontWeight(.bold)
			HStack {
				Text(newsItem.source)
					.font(.system(size: 11))
					.fontWeight(.semibold)
					.foregroundColor(Color(UIColor.systemGray))
				Spacer()
				Text(newsItem.timePublication)
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
		let newsItemMock = SpotlightMocks.make()[0]

		Group {
			SpotlightRow(newsItem: newsItemMock)
				.previewLayout(.fixed(width: 375, height: 80))
			SpotlightRow(newsItem: newsItemMock)
				.previewLayout(.fixed(width: 375, height: 80))
				.colorScheme(.dark)
		}
	}
}
