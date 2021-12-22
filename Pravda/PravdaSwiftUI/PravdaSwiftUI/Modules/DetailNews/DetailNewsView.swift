//
//  DetailNewsView.swift
//  PravdaSwiftUI
//
//  Created by Дмитрий Матвеенко on 31.01.2021.
//

import Models
import Constants
import SwiftUI

struct DetailNewsView: View {
	let newsItem: NewsItem
	@State private var isNewsFavorite = false
	@State private var showingLinkAlert = false
	@Environment(\.openURL) var openURL

	var body: some View {
		ScrollView {
			VStack {
				VStack(alignment: .leading) {
					ZStack {
						Rectangle()
							.fill(Color.white)
							.aspectRatio(4/3, contentMode: .fit)

						Image(uiImage: Assets.getImage(named: newsItem.image))
							.resizable()
							.aspectRatio(contentMode: .fill)
							.layoutPriority(-1)
					}
					.clipped()

					Group {
						Text(newsItem.title)
							.font(.system(size: 26))
							.fontWeight(.heavy)
							.padding(.top, 26)
						Text(newsItem.timePublication)
							.font(.system(size: 12))
							.fontWeight(.semibold)
							.foregroundColor(Color(UIColor.systemGray2))
							.padding(.top, 2)
						Text(newsItem.text ?? "")
							.padding(.top, 26)
					}
					.padding(.horizontal, 19)
				}

				VStack(alignment: .center) {
					Text(Strings.readFullStory.rawValue)
						.font(.system(size: 16))
						.fontWeight(.medium)
					Button("Open source") {
						if let newsLink = newsItem.link, let linkURL = URL(string: newsLink) {
							openURL(linkURL)
						} else {
							self.showingLinkAlert = true
						}
					}
					.font(.system(size: 16))
					.accentColor(.pink)
					.alert(isPresented: $showingLinkAlert) {
						Alert(
							title: Text(Strings.canNotOpenWebsite.rawValue),
							message: nil,
							dismissButton: .default(Text(Strings.okCapital.rawValue)))
					}
				}
				.padding(.vertical, 8)
			}
		}
		.navigationBarTitle(newsItem.source, displayMode: .inline)
		.navigationBarItems(trailing:
			Button(action: {
				isNewsFavorite.toggle()
			}) {
				Image(systemName: isNewsFavorite ? Assets.bookmarkFill.rawValue : Assets.bookmark.rawValue)
			}
		)
	}
}

struct DetailNewsView_Previews: PreviewProvider {
	static var previews: some View {
		let newsItem = NewsItem.makeTopStoriesMock(isOnlyOneItem: true)[0]
		NavigationView {
			DetailNewsView(newsItem: newsItem)
		}
	}
}
