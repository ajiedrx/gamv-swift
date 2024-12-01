//
//  GameListModel.swift
//  gamv
//
//  Created by Ajie DR on 17/11/24.
//

import Foundation

struct GameListModel {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [GameListItemModel]?
}

// MARK: - Result
struct GameListItemModel : Identifiable, Hashable, Equatable {
    let id: Int?
    let slug, name, released: String
    let tba: Bool?
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int?
    let ratings: [Rating]?
    let ratingsCount, reviewsTextCount, added: Int?
    let metacritic, playtime, suggestionsCount: Int?
    let updated: String?
    let reviewsCount: Int?
    let platforms: [PlatformElement]?
    let parentPlatforms: [ParentPlatform]?
    let genres: [Genre]?
    let stores: [Store]?
    let esrbRating: EsrbRating?
    let shortScreenshots: [ShortScreenshot]?
    var isFavorite: Bool = false
}

// MARK: - EsrbRating
struct EsrbRating : Identifiable, Hashable, Equatable {
    let id: Int?
    let name, slug: String?
}

// MARK: - Genre
struct Genre : Identifiable, Hashable, Equatable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    let domain: String?
    let language: String?
}

// MARK: - ParentPlatform
struct ParentPlatform : Identifiable, Hashable, Equatable {
    let id: String = UUID().uuidString
    
    let platform: EsrbRating?
}

// MARK: - PlatformElement
struct PlatformElement : Identifiable, Hashable, Equatable {
    let id: String = UUID().uuidString
    
    let platform: PlatformPlatform?
    let releasedAt: String?
    let requirementsEn, requirementsRu: Requirements?
}

// MARK: - PlatformPlatform
struct PlatformPlatform : Identifiable, Hashable, Equatable {
    let id: Int?
    let name, slug: String?
    let yearStart: Int?
    let gamesCount: Int?
    let imageBackground: String?
}

// MARK: - Requirements
struct Requirements : Identifiable, Hashable, Equatable {
    let id: String = UUID().uuidString
    
    let minimum, recommended: String?
}

// MARK: - Rating
struct Rating : Identifiable, Hashable, Equatable {
    let id: Int?
    let title: String?
    let count: Int?
    let percent: Double?
}

// MARK: - ShortScreenshot
struct ShortScreenshot : Identifiable, Hashable, Equatable {
    let id: Int?
    let image: String?
}

// MARK: - Store
struct Store : Identifiable, Hashable, Equatable {
    let id: Int?
    let store: Genre?
}
