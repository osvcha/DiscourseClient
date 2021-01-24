// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getLatestTopicsResponse = try? newJSONDecoder().decode(GetLatestTopicsResponse.self, from: jsonData)

import Foundation

// MARK: - GetLatestTopicsResponse
struct LatestTopicsResponse: Codable {
    let users: [User]?
    let topicList: TopicList?

    enum CodingKeys: String, CodingKey {
        case users
        case topicList = "topic_list"
    }
}

// MARK: - TopicList
struct TopicList: Codable {

    let topics: [Topic]?

    enum CodingKeys: String, CodingKey {
        case topics
    }
}

// MARK: - Topic
struct Topic: Codable {
    let id: Int?
    let title, fancyTitle, slug: String?
    let postsCount, replyCount, highestPostNumber: Int?
    let imageURL: String?
    let createdAt, lastPostedAt: String?
    let bumped: Bool?
    let bumpedAt: String?
    let unseen, pinned: Bool?
    let excerpt: String?
    let visible, closed, archived: Bool?
    let bookmarked, liked: Bool?
    let views, likeCount: Int?
    let hasSummary: Bool?
    let archetype: Archetype?
    let lastPosterUsername: String?
    let categoryID: Int?
    let pinnedGlobally: Bool?
    let posters: [Poster]?
    let lastReadPostNumber: Int?
    let unread, newPosts, notificationLevel: Int?
    let bookmarkedPostNumbers: [Int]?

    enum CodingKeys: String, CodingKey {
        case id, title
        case fancyTitle = "fancy_title"
        case slug
        case postsCount = "posts_count"
        case replyCount = "reply_count"
        case highestPostNumber = "highest_post_number"
        case imageURL = "image_url"
        case createdAt = "created_at"
        case lastPostedAt = "last_posted_at"
        case bumped
        case bumpedAt = "bumped_at"
        case unseen, pinned, excerpt, visible, closed, archived, bookmarked, liked, views
        case likeCount = "like_count"
        case hasSummary = "has_summary"
        case archetype
        case lastPosterUsername = "last_poster_username"
        case categoryID = "category_id"
        case pinnedGlobally = "pinned_globally"
        case posters
        case lastReadPostNumber = "last_read_post_number"
        case unread
        case newPosts = "new_posts"
        case notificationLevel = "notification_level"
        case bookmarkedPostNumbers = "bookmarked_post_numbers"
    }
}

enum Archetype: String, Codable {
    case regular = "regular"
}

// MARK: - Poster
struct Poster: Codable {
    let extras: Extras?
    let posterDescription: Description?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case extras
        case posterDescription = "description"
        case userID = "user_id"
    }
}

enum Extras: String, Codable {
    case latest = "latest"
    case latestSingle = "latest single"
}

enum Description: String, Codable {
    case frequentPoster = "Frequent Poster"
    case mostRecentPoster = "Most Recent Poster"
    case originalPoster = "Original Poster"
    case originalPosterMostRecentPoster = "Original Poster, Most Recent Poster"
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let username, name, avatarTemplate: String?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case id, username, name
        case avatarTemplate = "avatar_template"
        case title
    }
}






