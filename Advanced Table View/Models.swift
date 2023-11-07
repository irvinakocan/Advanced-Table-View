//
//  Models.swift
//  Advanced Table View
//
//  Created by Macbook Air 2017 on 7. 11. 2023..
//

import Foundation

enum CellModel {
    case collectionView(models: [CollectionTableCellModel], rows: Int)
    case list(models: [ListCellModel])
}

struct ListCellModel {
    let title: String
}

struct CollectionTableCellModel {
    let title: String
    let imageName: String
}
