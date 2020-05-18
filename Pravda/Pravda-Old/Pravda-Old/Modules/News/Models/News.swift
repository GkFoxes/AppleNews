//
//  News.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 18/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import Foundation

struct News: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [NewsAPI]?
}
