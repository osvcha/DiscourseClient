//
//  CategoriesResponses.swift
//  DiscourseClient
//
//  Created by Osvaldo Chaparro on 21/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categoriesResponse = try? newJSONDecoder().decode(CategoriesResponse.self, from: jsonData)

import Foundation

// MARK: - CategoriesResponse
struct CategoriesResponse: Codable {
    let categoryList: CategoryList?

    enum CodingKeys: String, CodingKey {
        case categoryList = "category_list"
    }
}

// MARK: - CategoryList
struct CategoryList: Codable {
    let categories: [Category]?

    enum CodingKeys: String, CodingKey {
        case categories
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

