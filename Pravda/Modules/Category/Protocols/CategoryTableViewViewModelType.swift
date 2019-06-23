//
//  CategoryTableViewViewModelType.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 20/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import Foundation

protocol CategoryTableViewViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CategoryTableViewCellViewModel?
}
