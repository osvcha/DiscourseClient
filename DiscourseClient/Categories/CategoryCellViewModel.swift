//
//  CategoryCellViewModel.swift
//  DiscourseClient
//
//  Created by Osvaldo Chaparro on 21/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

class CategoryCellViewModel {
    var textLabelText: String?
    
    init(category: Category) {
        self.textLabelText = category.name
    }
}
