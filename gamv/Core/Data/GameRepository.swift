//
//  GameRepository.swift
//  gamv
//
//  Created by Ajie DR on 17/11/24.
//

import Foundation

protocol GameRepositoryProtocol {
    func getListOfGames(page: Int, search: String) async -> Result<
        GameListModel, URLError
    >
}

final class GameRepository: NSObject {
    fileprivate var remoteDS: RemoteDataSource

    private init(remoteDS: RemoteDataSource) {
        self.remoteDS = remoteDS
    }

    static func getInstance(remote: RemoteDataSource) -> GameRepository {
        return GameRepository(remoteDS: remote)
    }
}

extension GameRepository: GameRepositoryProtocol {
    func getListOfGames(page: Int, search: String) async -> Result<
        GameListModel, URLError
    > {
        do {
            let gameList = try await remoteDS.getListOfGames(
                page: page, search: search)
            return .success(gameList.toGameListModel())
        } catch let error as URLError {
            return .failure(error)
        } catch {
            return .failure(.unknownError(error.localizedDescription))
        }
    }
}

final class MockGameRepository: GameRepositoryProtocol {
    var isSimulateError = false

    func getListOfGames(page: Int, search: String) async -> Result<GameListModel, URLError> {
        if isSimulateError { return .failure(.unknownError("Simulate error")) }

        let dummyGameListModel = GameListModel(
            count: 100,
            next: "https://api.rawg.io/api/games?page=2",
            previous: nil,
            results: [
                GameListItemModel(
                    id: 1,
                    slug: "elden-ring",
                    name: "Elden Ring",
                    released: "2022-02-25",
                    tba: false,
                    backgroundImage:
                        "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
                    rating: 9.5,
                    ratingTop: 5,
                    ratings: [
                        Rating(
                            id: 15_235_252,
                            title: "Rating title",
                            count: 432,
                            percent: 54.0
                        )
                    ],
                    ratingsCount: 10000,
                    reviewsTextCount: 500,
                    added: 100000,
                    metacritic: 97,
                    playtime: 60,
                    suggestionsCount: 100,
                    updated: "2023-11-16T16:14:51",
                    reviewsCount: 1000,
                    platforms: [
                        PlatformElement(
                            platform: PlatformPlatform(
                                id: 1,
                                name: "PlayStation 5",
                                slug: "playstation5",
                                yearStart: 2020,
                                gamesCount: 1000,
                                imageBackground:
                                    "https://media.rawg.io/media/platforms/d8fc16/playstation5.jpg"
                            ),
                            releasedAt: "2022-02-25",
                            requirementsEn: Requirements(
                                minimum: "minimum", recommended: "recommended"
                            ),
                            requirementsRu: Requirements(
                                minimum: "minimum", recommended: "recommended"
                            )
                        )
                    ],
                    parentPlatforms: [
                        ParentPlatform(
                            platform: EsrbRating(
                                id: 1,
                                name: "PC",
                                slug: "pc"
                            )
                        )
                    ],
                    genres: [
                        Genre(
                            id: 1,
                            name: "Action",
                            slug: "action",
                            gamesCount: 10000,
                            imageBackground:
                                "https://media.rawg.io/media/genres/4317.jpg",
                            domain: "MAIN_GENRE",
                            language: "eng"
                        ),
                        Genre(
                            id: 2,
                            name: "RPG",
                            slug: "role-playing-games-rpg",
                            gamesCount: 5000,
                            imageBackground:
                                "https://media.rawg.io/media/genres/150.jpg",
                            domain: "MAIN_GENRE",
                            language: "eng"
                        ),
                    ],
                    stores: [
                        Store(
                            id: 3_252_363_463_463,
                            store: Genre(
                                id: 1,
                                name: "Steam",
                                slug: "steam",
                                gamesCount: 10000,
                                imageBackground:
                                    "https://media.rawg.io/media/stores/49.jpg",
                                domain: "STORE",
                                language: "eng"
                            )
                        )
                    ],
                    esrbRating: EsrbRating(
                        id: 1,
                        name: "M",
                        slug: "mature"
                    ),
                    shortScreenshots: [
                        ShortScreenshot(
                            id: 1,
                            image:
                                "https://media.rawg.io/media/games/d73r4j/screenshots/193c-elden-ring-screenshot.jpg"
                        )
                    ]
                ),
                GameListItemModel(
                    id: 2,
                    slug: "elden-ring",
                    name: "Elden Ring",
                    released: "2022-02-25",
                    tba: false,
                    backgroundImage:
                        "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
                    rating: 9.5,
                    ratingTop: 5,
                    ratings: [
                        Rating(
                            id: 15_235_252, title: "Exceptional", count: 432,
                            percent: 54.0)
                    ],
                    ratingsCount: 10000,
                    reviewsTextCount: 500,
                    added: 100000,
                    metacritic: 97,
                    playtime: 60,
                    suggestionsCount: 100,
                    updated: "2023-11-16T16:14:51",
                    reviewsCount: 1000,
                    platforms: [
                        PlatformElement(
                            platform: PlatformPlatform(
                                id: 1,
                                name: "PlayStation 5",
                                slug: "playstation5",
                                yearStart: 2020,
                                gamesCount: 1000,
                                imageBackground:
                                    "https://media.rawg.io/media/platforms/ps5.jpg"
                            ),
                            releasedAt: "2022-02-25",
                            requirementsEn: Requirements(
                                minimum: "minimum", recommended: "recommended"),
                            requirementsRu: Requirements(
                                minimum: "minimum", recommended: "recommended")
                        )
                    ],
                    parentPlatforms: [
                        ParentPlatform(
                            platform: EsrbRating(id: 1, name: "PC", slug: "pc"))
                    ],
                    genres: [
                        Genre(
                            id: 1, name: "Action", slug: "action",
                            gamesCount: 10000,
                            imageBackground:
                                "https://media.rawg.io/media/genres/action.jpg",
                            domain: "MAIN_GENRE", language: "eng"),
                        Genre(
                            id: 2, name: "RPG", slug: "role-playing-games-rpg",
                            gamesCount: 5000,
                            imageBackground:
                                "https://media.rawg.io/media/genres/rpg.jpg",
                            domain: "MAIN_GENRE", language: "eng"),
                    ],
                    stores: [
                        Store(
                            id: 1,
                            store: Genre(
                                id: 1, name: "Steam", slug: "steam",
                                gamesCount: 10000,
                                imageBackground:
                                    "https://media.rawg.io/media/stores/steam.jpg",
                                domain: "STORE", language: "eng"))
                    ],
                    esrbRating: EsrbRating(id: 1, name: "M", slug: "mature"),
                    shortScreenshots: [
                        ShortScreenshot(
                            id: 1,
                            image:
                                "https://media.rawg.io/media/games/d73r4j/screenshots/elden-ring-1.jpg"
                        )
                    ]
                ),

                // Game 2: God of War Ragnarök
                GameListItemModel(
                    id: 3,
                    slug: "god-of-war-ragnarok",
                    name: "God of War Ragnarök",
                    released: "2022-11-09",
                    tba: false,
                    backgroundImage:
                        "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
                    rating: 9.4,
                    ratingTop: 5,
                    ratings: [
                        Rating(
                            id: 15_235_253, title: "Exceptional", count: 385,
                            percent: 52.0)
                    ],
                    ratingsCount: 9500,
                    reviewsTextCount: 450,
                    added: 95000,
                    metacritic: 94,
                    playtime: 40,
                    suggestionsCount: 90,
                    updated: "2023-12-16T16:14:51",
                    reviewsCount: 950,
                    platforms: [
                        PlatformElement(
                            platform: PlatformPlatform(
                                id: 2,
                                name: "PlayStation 5",
                                slug: "playstation5",
                                yearStart: 2020,
                                gamesCount: 1000,
                                imageBackground:
                                    "https://media.rawg.io/media/platforms/ps5.jpg"
                            ),
                            releasedAt: "2022-11-09",
                            requirementsEn: Requirements(
                                minimum: "minimum", recommended: "recommended"),
                            requirementsRu: Requirements(
                                minimum: "minimum", recommended: "recommended")
                        )
                    ],
                    parentPlatforms: [
                        ParentPlatform(
                            platform: EsrbRating(
                                id: 2, name: "PlayStation", slug: "playstation")
                        )
                    ],
                    genres: [
                        Genre(
                            id: 1, name: "Action", slug: "action",
                            gamesCount: 10000,
                            imageBackground:
                                "https://media.rawg.io/media/genres/action.jpg",
                            domain: "MAIN_GENRE", language: "eng"),
                        Genre(
                            id: 3, name: "Adventure", slug: "adventure",
                            gamesCount: 4000,
                            imageBackground:
                                "https://media.rawg.io/media/genres/adventure.jpg",
                            domain: "MAIN_GENRE", language: "eng"),
                    ],
                    stores: [
                        Store(
                            id: 2,
                            store: Genre(
                                id: 2, name: "PlayStation Store",
                                slug: "playstation-store", gamesCount: 8000,
                                imageBackground:
                                    "https://media.rawg.io/media/stores/ps-store.jpg",
                                domain: "STORE", language: "eng"))
                    ],
                    esrbRating: EsrbRating(id: 1, name: "M", slug: "mature"),
                    shortScreenshots: [
                        ShortScreenshot(
                            id: 2,
                            image:
                                "https://media.rawg.io/media/games/gow/screenshots/gow-1.jpg"
                        )
                    ]
                ),

                // Game 3: Cyberpunk 2077
                GameListItemModel(
                    id: 4,
                    slug: "cyberpunk-2077",
                    name: "Cyberpunk 2077",
                    released: "2020-12-10",
                    tba: false,
                    backgroundImage:
                        "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
                    rating: 8.9,
                    ratingTop: 5,
                    ratings: [
                        Rating(
                            id: 15_235_254, title: "Great", count: 356,
                            percent: 48.0)
                    ],
                    ratingsCount: 9000,
                    reviewsTextCount: 400,
                    added: 90000,
                    metacritic: 86,
                    playtime: 45,
                    suggestionsCount: 85,
                    updated: "2023-12-16T16:14:51",
                    reviewsCount: 900,
                    platforms: [
                        PlatformElement(
                            platform: PlatformPlatform(
                                id: 3,
                                name: "PC",
                                slug: "pc",
                                yearStart: nil,
                                gamesCount: 50000,
                                imageBackground:
                                    "https://media.rawg.io/media/platforms/pc.jpg"
                            ),
                            releasedAt: "2020-12-10",
                            requirementsEn: Requirements(
                                minimum: "minimum", recommended: "recommended"),
                            requirementsRu: Requirements(
                                minimum: "minimum", recommended: "recommended")
                        )
                    ],
                    parentPlatforms: [
                        ParentPlatform(
                            platform: EsrbRating(id: 1, name: "PC", slug: "pc"))
                    ],
                    genres: [
                        Genre(
                            id: 1, name: "Action", slug: "action",
                            gamesCount: 10000,
                            imageBackground:
                                "https://media.rawg.io/media/genres/action.jpg",
                            domain: "MAIN_GENRE", language: "eng"),
                        Genre(
                            id: 2, name: "RPG", slug: "role-playing-games-rpg",
                            gamesCount: 5000,
                            imageBackground:
                                "https://media.rawg.io/media/genres/rpg.jpg",
                            domain: "MAIN_GENRE", language: "eng"),
                    ],
                    stores: [
                        Store(
                            id: 1,
                            store: Genre(
                                id: 1, name: "Steam", slug: "steam",
                                gamesCount: 10000,
                                imageBackground:
                                    "https://media.rawg.io/media/stores/steam.jpg",
                                domain: "STORE", language: "eng"))
                    ],
                    esrbRating: EsrbRating(id: 1, name: "M", slug: "mature"),
                    shortScreenshots: [
                        ShortScreenshot(
                            id: 3,
                            image:
                                "https://media.rawg.io/media/games/cyberpunk/screenshots/cp-1.jpg"
                        )
                    ]
                ),

                // Game 4: The Legend of Zelda: Tears of the Kingdom
                GameListItemModel(
                    id: 5,
                    slug: "zelda-tears-of-the-kingdom",
                    name: "The Legend of Zelda: Tears of the Kingdom",
                    released: "2023-05-12",
                    tba: false,
                    backgroundImage:
                        "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
                    rating: 9.6,
                    ratingTop: 5,
                    ratings: [
                        Rating(
                            id: 15_235_255, title: "Exceptional", count: 478,
                            percent: 56.0)
                    ],
                    ratingsCount: 11000,
                    reviewsTextCount: 550,
                    added: 110000,
                    metacritic: 96,
                    playtime: 55,
                    suggestionsCount: 95,
                    updated: "2023-12-16T16:14:51",
                    reviewsCount: 1100,
                    platforms: [
                        PlatformElement(
                            platform: PlatformPlatform(
                                id: 4,
                                name: "Nintendo Switch",
                                slug: "nintendo-switch",
                                yearStart: 2017,
                                gamesCount: 3000,
                                imageBackground:
                                    "https://media.rawg.io/media/platforms/switch.jpg"
                            ),
                            releasedAt: "2023-05-12",
                            requirementsEn: Requirements(
                                minimum: "minimum", recommended: "recommended"),
                            requirementsRu: Requirements(
                                minimum: "minimum", recommended: "recommended")
                        )
                    ],
                    parentPlatforms: [
                        ParentPlatform(
                            platform: EsrbRating(
                                id: 3, name: "Nintendo", slug: "nintendo"))
                    ],
                    genres: [
                        Genre(
                            id: 1, name: "Action", slug: "action",
                            gamesCount: 10000,
                            imageBackground:
                                "https://media.rawg.io/media/genres/action.jpg",
                            domain: "MAIN_GENRE", language: "eng"),
                        Genre(
                            id: 3, name: "Adventure", slug: "adventure",
                            gamesCount: 4000,
                            imageBackground:
                                "https://media.rawg.io/media/genres/adventure.jpg",
                            domain: "MAIN_GENRE", language: "eng"),
                    ],
                    stores: [
                        Store(
                            id: 3,
                            store: Genre(
                                id: 3, name: "Nintendo Store",
                                slug: "nintendo-store", gamesCount: 3000,
                                imageBackground:
                                    "https://media.rawg.io/media/stores/nintendo.jpg",
                                domain: "STORE", language: "eng"))
                    ],
                    esrbRating: EsrbRating(
                        id: 2, name: "E10+", slug: "everyone-10-plus"),
                    shortScreenshots: [
                        ShortScreenshot(
                            id: 4,
                            image:
                                "https://media.rawg.io/media/games/zelda/screenshots/totk-1.jpg"
                        )
                    ]
                ),

                // Game 5: Red Dead Redemption 2
                GameListItemModel(
                    id: 6,
                    slug: "red-dead-redemption-2",
                    name: "Red Dead Redemption 2",
                    released: "2018-10-26",
                    tba: false,
                    backgroundImage:
                        "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
                    rating: 9.3,
                    ratingTop: 5,
                    ratings: [
                        Rating(
                            id: 15_235_256, title: "Exceptional", count: 412,
                            percent: 53.0)
                    ],
                    ratingsCount: 9800,
                    reviewsTextCount: 490,
                    added: 98000,
                    metacritic: 97,
                    playtime: 65,
                    suggestionsCount: 88,
                    updated: "2023-12-16T16:14:51",
                    reviewsCount: 980,
                    platforms: [
                        PlatformElement(
                            platform: PlatformPlatform(
                                id: 1,
                                name: "PlayStation 4",
                                slug: "playstation4",
                                yearStart: 2013,
                                gamesCount: 4000,
                                imageBackground:
                                    "https://media.rawg.io/media/platforms/ps4.jpg"
                            ),
                            releasedAt: "2018-10-26",
                            requirementsEn: Requirements(
                                minimum: "minimum", recommended: "recommended"),
                            requirementsRu: Requirements(
                                minimum: "minimum", recommended: "recommended")
                        )
                    ],
                    parentPlatforms: [
                        ParentPlatform(
                            platform: EsrbRating(
                                id: 2, name: "PlayStation", slug: "playstation")
                        )
                    ],
                    genres: [
                        Genre(
                            id: 1, name: "Action", slug: "action",
                            gamesCount: 10000,
                            imageBackground:
                                "https://media.rawg.io/media/genres/action.jpg",
                            domain: "MAIN_GENRE", language: "eng"),
                        Genre(
                            id: 3, name: "Adventure", slug: "adventure",
                            gamesCount: 4000,
                            imageBackground:
                                "https://media.rawg.io/media/genres/adventure.jpg",
                            domain: "MAIN_GENRE", language: "eng"),
                    ],
                    stores: [
                        Store(
                            id: 2,
                            store: Genre(
                                id: 2, name: "PlayStation Store",
                                slug: "playstation-store", gamesCount: 8000,
                                imageBackground:
                                    "https://media.rawg.io/media/stores/ps-store.jpg",
                                domain: "STORE", language: "eng"))
                    ],
                    esrbRating: EsrbRating(id: 1, name: "M", slug: "mature"),
                    shortScreenshots: [
                        ShortScreenshot(
                            id: 5,
                            image:
                                "https://media.rawg.io/media/games/rdr2/screenshots/rdr2-1.jpg"
                        )
                    ]
                ),
            ]
        )
        return .success(dummyGameListModel)
    }
}
