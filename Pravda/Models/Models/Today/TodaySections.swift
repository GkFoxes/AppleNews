//
//  TodaySections.swift
//  Models
//
//  Created by Дмитрий Матвеенко on 23.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import UIKit

public enum TodaySections: String, CaseIterable {
	case topStories = "Top Stories"
	case otherTopStories = "top stories"
	case science = "Science"
	case otherScience = "science"
}

// MARK: Setup UIColor

public extension TodaySections {
	var color: UIColor {
		switch self {
		case .topStories, .otherTopStories: return .systemPink
		case .science, .otherScience: return .systemIndigo
		}
	}
}
