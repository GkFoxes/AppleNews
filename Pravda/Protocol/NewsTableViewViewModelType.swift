//
//  NewsTableViewModelType.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 18/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import Foundation

protocol NewsTableViewViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsTableViewCellViewModelType?
    
    func viewModelForSelectedRow() -> NewsDetailViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
}
