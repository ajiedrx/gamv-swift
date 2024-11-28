//
//  GameListResponse.swift
//  gamv
//
//  Created by Ajie DR on 13/11/24.
//

import Foundation

// MARK: - GameListResponse
struct GameListResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [GameListItemResponse]?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

// MARK: - Result
struct GameListItemResponse: Codable {
    let id: Int?
    let slug, name, released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [RatingResponse]?
    let ratingsCount, reviewsTextCount, added: Int?
    let metacritic, playtime, suggestionsCount: Int?
    let updated: String?
    let reviewsCount: Int?
    let platforms: [PlatformElementResponse]?
    let parentPlatforms: [ParentPlatformResponse]?
    let genres: [GenreResponse]?
    let stores: [StoreResponse]?
    let esrbRating: EsrbRatingResponse?
    let shortScreenshots: [ShortScreenshotResponse]?

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case reviewsCount = "reviews_count"
        case platforms
        case parentPlatforms = "parent_platforms"
        case genres, stores
        case esrbRating = "esrb_rating"
        case shortScreenshots = "short_screenshots"
    }
}

// MARK: - EsrbRating
struct EsrbRatingResponse: Codable {
    let id: Int?
    let name, slug: String?
}

// MARK: - Genre
struct GenreResponse: Codable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    let domain: String?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
    }
}

// MARK: - ParentPlatform
struct ParentPlatformResponse: Codable {
    let platform: EsrbRatingResponse?
}

// MARK: - PlatformElement
struct PlatformElementResponse: Codable {
    let platform: PlatformPlatformResponse?
    let releasedAt: String?
    let requirementsEn, requirementsRu: RequirementsResponse?

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirementsEn = "requirements_en"
        case requirementsRu = "requirements_ru"
    }
}

// MARK: - PlatformPlatform
struct PlatformPlatformResponse: Codable {
    let id: Int?
    let name, slug: String?
    let yearStart: Int?
    let gamesCount: Int?
    let imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

// MARK: - Requirements
struct RequirementsResponse: Codable {
    let minimum, recommended: String?
}

// MARK: - Rating
struct RatingResponse: Codable {
    let id: Int?
    let title: String?
    let count: Int?
    let percent: Double?
}

// MARK: - ShortScreenshot
struct ShortScreenshotResponse: Codable {
    let id: Int?
    let image: String?
}

// MARK: - Store
struct StoreResponse: Codable {
    let id: Int?
    let store: GenreResponse?
}
