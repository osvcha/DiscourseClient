// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let usersResponse = try? newJSONDecoder().decode(UsersResponse.self, from: jsonData)

import Foundation

// MARK: - UsersResponse
struct UsersResponse: Codable {
    let directoryItems: [DirectoryItem]?
    let totalRowsDirectoryItems: Int?
    let loadMoreDirectoryItems: String?

    enum CodingKeys: String, CodingKey {
        case directoryItems = "directory_items"
        case totalRowsDirectoryItems = "total_rows_directory_items"
        case loadMoreDirectoryItems = "load_more_directory_items"
    }
}

// MARK: - DirectoryItem
struct DirectoryItem: Codable {
    let id, timeRead, likesReceived, likesGiven: Int?
    let topicsEntered, topicCount, postCount, postsRead: Int?
    let daysVisited: Int?
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case timeRead = "time_read"
        case likesReceived = "likes_received"
        case likesGiven = "likes_given"
        case topicsEntered = "topics_entered"
        case topicCount = "topic_count"
        case postCount = "post_count"
        case postsRead = "posts_read"
        case daysVisited = "days_visited"
        case user
    }
}


