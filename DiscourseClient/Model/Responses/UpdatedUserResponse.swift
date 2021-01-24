//
//  UpdatedUserResponse.swift
//  DiscourseClient
//
//  Created by Osvaldo Chaparro on 24/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let updateUserResponse = try? newJSONDecoder().decode(UpdateUserResponse.self, from: jsonData)

import Foundation

// MARK: - UpdateUserResponse
struct UpdateUserResponse: Codable {
    let success: String?
    let user: User?
}

