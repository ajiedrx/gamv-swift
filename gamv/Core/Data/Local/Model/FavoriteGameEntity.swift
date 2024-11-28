//
//  FavoriteGameEntity.swift
//  gamv
//
//  Created by Ajie DR on 28/11/24.
//

import SwiftData

@Model
class FavoriteGameEntity {
    var id: Int
    var title: String
    var releaseDate: String
    var rating: Double
    var imageUrl: String
    var esrbRating: String
    var platforms: [PlatformEntity]
    var genres: [GenreEntity]
    
    init(id: Int, title: String, releaseDate: String, rating: Double, imageUrl: String, esrbRating: String, platforms: [PlatformEntity], genres: [GenreEntity]) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.rating = rating
        self.imageUrl = imageUrl
        self.esrbRating = esrbRating
        self.platforms = platforms
        self.genres = genres
    }
}

@Model
class PlatformEntity {
    var id: Int
    var name: String
    var minimumRequirements: String
    var recommendedRequirements: String
    
    init(id: Int, name: String, minimumRequirements: String, recommendedRequirements: String) {
        self.id = id
        self.name = name
        self.minimumRequirements = minimumRequirements
        self.recommendedRequirements = recommendedRequirements
    }
}

@Model
class GenreEntity {
    var id: Int
    var name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
