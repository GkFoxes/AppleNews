//
//  NewsTableViewModelType.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 18/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import Foundation

protocol NewsTableViewModelType {
    var numberOfRows: Int { get }
    var news: [News] { get }
}
