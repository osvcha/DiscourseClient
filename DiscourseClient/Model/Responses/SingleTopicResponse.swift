// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let singleTopicResponse = try? newJSONDecoder().decode(SingleTopicResponse.self, from: jsonData)

import Foundation

// MARK: - SingleTopicResponse
struct SingleTopicResponse: Codable {
    let id: Int?
    let title, fancyTitle: String?
    let postsCount: Int?
    let details: Details?

    enum CodingKeys: String, CodingKey {
        case id, title
        case fancyTitle = "fancy_title"
        case postsCount = "posts_count"
        case details
    }
}


// MARK: - Details
struct Details: Codable {
    let canEdit, canDelete, canCreatePost, canRecover: Bool?
    let participants: [Participant]?

    enum CodingKeys: String, CodingKey {
        case canEdit = "can_edit"
        case canDelete = "can_delete"
        case canCreatePost = "can_create_post"
        case canRecover = "can_recover"
        case participants
    }
}


// MARK: - Participant
struct Participant: Codable {
    let id: Int?
    let username, name, avatarTemplate: String?
    let postCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, username, name
        case avatarTemplate = "avatar_template"
        case postCount = "post_count"
    }
}

