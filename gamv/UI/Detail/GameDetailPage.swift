//
//  GameDetailPage.swift
//  gamv
//
//  Created by Ajie DR on 18/11/24.
//

import Foundation
import SwiftUI
import CorePackage

struct GameDetailPage: View {
    let game: GameListItemModel

    private let aspectRatio: CGFloat = 16 / 9
    private let cornerRadius: CGFloat = 24

    var body: some View {
        ZStack {
            Color.black

            ScrollView {
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: game.backgroundImage)) {
                        phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(aspectRatio, contentMode: .fit)
                                .clipped()
                                .clipShape(
                                    RoundedRectangle(cornerRadius: cornerRadius)
                                )
                                .brightness(-0.2)
                        case .failure:
                            Image(systemName: "photo")
                        case .empty:
                            ProgressView()
                        @unknown default:
                            ProgressView()
                        }
                    }
                    .frame(height: 240)

                    GameHeaderView(
                        title: game.name,
                        genres: game.genres ?? [],
                        released: game.released,
                        rating: game.rating,
                        esrbRating: game.esrbRating?.name ?? ""
                    )

                    Divider()
                        .frame(height: 2)
                        .overlay(.white)
                        .padding(.horizontal, 48)
                        .padding(.vertical, 12)

                    Text("Platforms")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)

                    ForEach(game.platforms ?? []) { platform in

                        Text(platform.platform?.name ?? "")
                            .foregroundColor(.white)
                            .font(.caption2)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(
                                Capsule()
                                    .fill(Color(hex: 0x2f4f4f))
                            )
                        
                        let recommendedRequirements = platform.requirementsEn?.recommended ?? ""

                        if(!recommendedRequirements.isEmpty) {
                            Text("Recommended requirements")
                                .foregroundColor(.white)
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.top, 12)

                            Text(recommendedRequirements)
                                .foregroundColor(.white)
                        }
                    
                        let minimumRequirement = platform.requirementsEn?.minimum ?? ""
                        
                        if(!minimumRequirement.isEmpty) {
                            Text("Minimum requirements")
                                .foregroundColor(.white)
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.top, 12)

                            Text(minimumRequirement)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.top, 2)
                    .padding(.horizontal, 12)
                }
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .ignoresSafeArea()
    }
}

struct GameHeaderView: View {
    let title: String
    let genres: [Genre]
    let released: String
    let rating: Double
    let esrbRating: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.bottom, 12)
                .fixedSize(horizontal: false, vertical: true)

            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(genres) { genre in
                        Text(genre.name ?? "")
                            .foregroundColor(.white)
                            .font(.footnote)
                            .underline()
                    }
                }
            }
            .scrollIndicators(.hidden)

            HStack(alignment: .bottom) {
                Label(
                    title: {
                        Text(String(rating))
                    },
                    icon: {
                        Image(systemName: "star.fill")
                    }
                )
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .foregroundColor(.white)
                .background(
                    Capsule()
                        .fill(Color(hex: 0xFF5F1F))
                )

                Spacer()

                VStack {
                    Text(
                        esrbRating
                    )
                    .font(.caption2)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)

                    Spacer()

                    Text(
                        DateUtils.convertStringDate(
                            date: released, inputFormat: "yyyy-MM-dd",
                            outputFormat: "yyyy, dd MMM"
                        )
                    )
                    .font(.caption2)
                    .foregroundColor(.white)
                }
            }
            .padding(.top, 12)
        }
        .padding(.horizontal, 12)
    }
}

#Preview {
    GameDetailPage(
        game: GameListItemModel(
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
                        minimum:
                            "To experience the full potential of this game, your system should meet the following requirements. Your operating system should be Windows 10 (64-bit) or later. A powerful processor like an Intel Core i5-7600 or AMD Ryzen 5 1600 is recommended. At least 8 GB of RAM is essential, but 16 GB is ideal for optimal performance. A dedicated graphics card, such as an NVIDIA GeForce GTX 1060 or AMD Radeon RX 580, is crucial for stunning visuals. DirectX 11 or later is required for compatibility. Lastly, ensure you have at least 40 GB of available storage space to install the game. A stable internet connection is necessary for online multiplayer and updates.",
                        recommended:
                            "To experience the full potential of this game, your system should meet the following requirements. Your operating system should be Windows 10 (64-bit) or later. A powerful processor like an Intel Core i5-7600 or AMD Ryzen 5 1600 is recommended. At least 8 GB of RAM is essential, but 16 GB is ideal for optimal performance. A dedicated graphics card, such as an NVIDIA GeForce GTX 1060 or AMD Radeon RX 580, is crucial for stunning visuals. DirectX 11 or later is required for compatibility. Lastly, ensure you have at least 40 GB of available storage space to install the game. A stable internet connection is necessary for online multiplayer and updates."
                    ),
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
                        "",
                    domain: "MAIN_GENRE", language: "eng"),
                Genre(
                    id: 3, name: "Adventure", slug: "adventure",
                    gamesCount: 4000,
                    imageBackground:
                        "",
                    domain: "MAIN_GENRE", language: "eng"),
                Genre(
                    id: 4, name: "Adventure", slug: "adventure",
                    gamesCount: 4000,
                    imageBackground:
                        "",
                    domain: "MAIN_GENRE", language: "eng"),
                Genre(
                    id: 5, name: "Adventure", slug: "adventure",
                    gamesCount: 4000,
                    imageBackground:
                        "",
                    domain: "MAIN_GENRE", language: "eng"),
                Genre(
                    id: 6, name: "Adventure", slug: "adventure",
                    gamesCount: 4000,
                    imageBackground:
                        "",
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
            esrbRating: EsrbRating(id: 1, name: "Mature", slug: "mature"),
            shortScreenshots: [
                ShortScreenshot(
                    id: 5,
                    image:
                        "https://media.rawg.io/media/games/rdr2/screenshots/rdr2-1.jpg"
                )
            ]
        )
    )
}

extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}
