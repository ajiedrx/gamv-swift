//
//  Untitled.swift
//  gamv
//
//  Created by Ajie DR on 17/11/24.
//

import Foundation

extension GameListResponse {
    func toGameListModel() -> GameListModel {
        return GameListModel(
            count: self.count,
            next: self.next,
            previous: self.previous,
            results: self
                .results?
                .map {
                    result in result.toGameListItemModel()
                }
        )
    }
}

extension GameListItemResponse {
  func toGameListItemModel() -> GameListItemModel {
    return GameListItemModel(
      id: self.id,
      slug: self.slug ?? "",
      name: self.name ?? "",
      released: self.released ?? "",
      tba: self.tba,
      backgroundImage: self.backgroundImage ?? "",
      rating: self.rating ?? 0.0,
      ratingTop: self.ratingTop,
      ratings: self.ratings?.map { $0.toRatingModel() },
      ratingsCount: self.ratingsCount,
      reviewsTextCount: self.reviewsTextCount,
      added: self.added,
      metacritic: self.metacritic,
      playtime: self.playtime,
      suggestionsCount: self.suggestionsCount,
      updated: self.updated,
      reviewsCount: self.reviewsCount,
      platforms: self.platforms?.map { $0.toPlatformElementModel() },
      parentPlatforms: self.parentPlatforms?.map { $0.toParentPlatformModel() },
      genres: self.genres?.map { $0.toGenreModel() },
      stores: self.stores?.map { $0.toStoreModel() },
      esrbRating: self.esrbRating?.toEsrbRatingModel(),
      shortScreenshots: self.shortScreenshots?.map { $0.toShortScreenshotModel() }
    )
  }
}

// Helper functions for nested conversions
private extension EsrbRatingResponse {
  func toEsrbRatingModel() -> EsrbRating {
    return EsrbRating(id: self.id, name: self.name, slug: self.slug)
  }
}

private extension GenreResponse {
  func toGenreModel() -> Genre {
    return Genre(
      id: self.id,
      name: self.name,
      slug: self.slug,
      gamesCount: self.gamesCount,
      imageBackground: self.imageBackground,
      domain: self.domain,
      language: self.language
    )
  }
}

private extension ParentPlatformResponse {
    func toParentPlatformModel() -> ParentPlatform {
        return ParentPlatform(platform: self.platform?.toEsrbRatingModel())
    }
}

private extension PlatformElementResponse {
  func toPlatformElementModel() -> PlatformElement {
    return PlatformElement(
      platform: self.platform?.toPlatformPlatformModel(),
      releasedAt: self.releasedAt,
      requirementsEn: self.requirementsEn?.toRequirementsModel(),
      requirementsRu: self.requirementsRu?.toRequirementsModel()
    )
  }
}

private extension PlatformPlatformResponse {
  func toPlatformPlatformModel() -> PlatformPlatform {
    return PlatformPlatform(
      id: self.id,
      name: self.name,
      slug: self.slug,
      yearStart: self.yearStart,
      gamesCount: self.gamesCount,
      imageBackground: self.imageBackground
    )
  }
}

private extension RequirementsResponse {
  func toRequirementsModel() -> Requirements {
    return Requirements(minimum: self.minimum, recommended: self.recommended)
  }
}

private extension RatingResponse {
  func toRatingModel() -> Rating {
    return Rating(
        id: self.id,
        title: self.title,
        count: self.count,
        percent:self.percent
    )
  }
}

private extension ShortScreenshotResponse {
  func toShortScreenshotModel() -> ShortScreenshot {
    return ShortScreenshot(id: self.id, image: self.image)
  }
}

private extension StoreResponse {
  func toStoreModel() -> Store {
    return Store(id: self.id, store: self.store?.toGenreModel())
  }
}
