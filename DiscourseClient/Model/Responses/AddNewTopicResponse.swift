// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let addNewTopicResponse = try? newJSONDecoder().decode(AddNewTopicResponse.self, from: jsonData)

import Foundation

// MARK: - AddNewTopicResponse
struct AddNewTopicResponse: Codable {
    let id: Int?
    let name, username, avatarTemplate, createdAt: String?
    let cooked: String?
    let postNumber, postType: Int?
    let updatedAt: String?
    let replyCount: Int?
    let quoteCount, incomingLinkCount, reads, score: Int?
    let yours: Bool?
    let topicID: Int?
    let topicSlug, displayUsername: String?
    let version: Int?
    let canEdit, canDelete, canRecover, canWiki: Bool?
    let moderator, admin, staff: Bool?
    let userID, draftSequence: Int?
    let hidden: Bool?
    let trustLevel: Int?
    let userDeleted: Bool?
    let canViewEditHistory, wiki: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, username
        case avatarTemplate = "avatar_template"
        case createdAt = "created_at"
        case cooked
        case postNumber = "post_number"
        case postType = "post_type"
        case updatedAt = "updated_at"
        case replyCount = "reply_count"
        case quoteCount = "quote_count"
        case incomingLinkCount = "incoming_link_count"
        case reads, score, yours
        case topicID = "topic_id"
        case topicSlug = "topic_slug"
        case displayUsername = "display_username"
        case version
        case canEdit = "can_edit"
        case canDelete = "can_delete"
        case canRecover = "can_recover"
        case canWiki = "can_wiki"
        case moderator, admin, staff
        case userID = "user_id"
        case draftSequence = "draft_sequence"
        case hidden
        case trustLevel = "trust_level"
        case userDeleted = "user_deleted"
        case canViewEditHistory = "can_view_edit_history"
        case wiki
    }
}
