//
//  FavoriteGamePage.swift
//  gamv
//
//  Created by Ajie DR on 01/12/24.
//

import Foundation
import SwiftUI

struct FavoriteGamePage: View {
    @EnvironmentObject var router: Router

    @StateObject private var favoriteGameViewModel: FavoriteGameViewModel

    @State private var showingAddFavoriteSuccessAlert = false
    @State private var showingRemoveFavoriteSuccessAlert = false

    init(favoriteGameViewModel: FavoriteGameViewModel) {
        _favoriteGameViewModel = StateObject(
            wrappedValue: favoriteGameViewModel)
    }

    var body: some View {
        ZStack {
            switch favoriteGameViewModel.listViewState {
            case .idle:
                EmptyView()
            case .loading:
                LoadingView()
            case .success:
                FavoriteGameListView(
                    favoriteGameViewModel: favoriteGameViewModel,
                    onRemoveFavorite: { game in
                        favoriteGameViewModel.removeFavoriteGame(game: game)
                    }
                )
            case .failure(let failure):
                ErrorView(
                    error: failure,
                    retryAction: {}
                )
            }
        }
        .navigationTitle("Favorite Games")
        .onAppear { favoriteGameViewModel.getFavoriteGames() }
    }
}

struct FavoriteGameListView: View {
    @EnvironmentObject var router: Router

    @StateObject var favoriteGameViewModel: FavoriteGameViewModel

    @State private var selectedGame: GameListItemModel?

    let onRemoveFavorite: (GameListItemModel) -> Void

    var body: some View {
        List {
            ForEach(favoriteGameViewModel.favoriteGames) { game in
                GameItemView(
                    title: game.name, imageURL: game.backgroundImage,
                    releaseDate: game.released, rating: game.rating
                )
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .scaleEffect(1.0)
                .onTapGesture {
                    router.navigate(to: .detail(game: game))
                }
                .swipeActions(allowsFullSwipe: false) {
                    Button(
                        action: {
                            selectedGame = game
                            onRemoveFavorite(game)
                        },
                        label: {
                            Label(
                                "Remove favorite",
                                systemImage: "trash.fill"
                            )
                            .labelStyle(.iconOnly)
                            .environment(\.symbolVariants, .none)
                        }
                    )
                    .tint(.red)
                }
            }
        }
        .navigationDestination(for: GameListItemModel.self) { game in
            GameDetailPage(game: game)
        }
        .listRowSpacing(16)
        .scrollContentBackground(.hidden)
        .alert(item: $selectedGame) { game in
            Alert(
                title: Text("Remove favorite"),
                message: Text(
                    "Successfully removed " + game.name + " to favorites"
                )
            )
        }
    }
}

#Preview {
    FavoriteGamePage(
        favoriteGameViewModel: FavoriteGameViewModel(
            gameUseCase: GameUseCaseImpl(
                gameRepository: MockGameRepository()
            )
        )
    )
}
