//
//  FavoritesTableViewCellViewModelType.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 21/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import Foundation

protocol FavoritesTableViewCellViewModelType: class {
    var title: String? { get }
    var author: String? { get }
    var date: String? { get }
    var url: String? { get }
    var urlImage: String? { get }
}
