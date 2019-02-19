//
//  NewsTableViewCellViewModelType.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 18/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import Foundation

protocol NewsTableViewCellViewModelType: class {
    var title: String { get }
    var author: String { get }
    var date: String { get }
}
