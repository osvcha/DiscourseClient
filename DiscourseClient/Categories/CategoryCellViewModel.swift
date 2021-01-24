//
//  CategoryCellViewModel.swift
//  DiscourseClient
//
//  Created by Osvaldo Chaparro on 21/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

class CategoryCellViewModel {
    let category: Category
    var textLabelText: String?
    
    init(category: Category) {
        self.category = category
        self.textLabelText = self.category.name
    }
}
