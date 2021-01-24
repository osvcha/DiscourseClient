//
//  SingleUserResponse.swift
//  DiscourseClient
//
//  Created by Osvaldo Chaparro on 24/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let singleUserResponse = try? newJSONDecoder().decode(SingleUserResponse.self, from: jsonData)

import Foundation

// MARK: - SingleUserResponse
struct SingleUserResponse: Codable {
    let user: PurpleUser?

    enum CodingKeys: String, CodingKey {
        case user
    }
}

// MARK: - PurpleUser
struct PurpleUser: Codable {
    let id: Int?
    let username, name, avatarTemplate, email: String?
    let canEditName: Bool?

    enum CodingKeys: String, CodingKey {
        case id, username, name
        case avatarTemplate = "avatar_template"
        case email
        case canEditName = "can_edit_name"
    }
}


