//
//  CategoriesDataManager.swift
//  DiscourseClient
//
//  Created by Osvaldo Chaparro on 21/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

enum CategoriesDataManagerError: Error {
    case unknown
}

protocol CategoriesDataManager {
    func fetchAllCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ())
}
