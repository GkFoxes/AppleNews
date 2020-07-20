//
//  TodaySections.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий Владимирович on 15.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import PravdaUIKit

enum TodaySections: String, CaseIterable {
	case topStories = "Top Stories"
	case otherTopStories
	case science = "Science"
	case otherScience
}

// MARK: Setup UIColor

extension TodaySections {
	var color: UIColor {
		switch self {
		case .topStories: return .systemRed
		case .science: return .systemIndigo
		default: return .systemBackground
		}
	}
}
