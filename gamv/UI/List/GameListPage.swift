//
//  GameListPage.swift
//  gamv
//
//  Created by Ajie DR on 17/11/24.
//

import Foundation
import SwiftUI

struct GameListPage: View {
    @EnvironmentObject var router: Router

    @StateObject private var gameListViewModel: GameListViewModel

    @State private var showingAddFavoriteSuccessAlert = false
    @State private var showingRemoveFavoriteSuccessAlert = false

    init(gameListViewModel: GameListViewModel) {
        _gameListViewModel = StateObject(wrappedValue: gameListViewModel)
    }

    var body: some View {
        ZStack {
            switch gameListViewModel.listViewState {
            case .idle:
                EmptyView()
            case .loading:
                LoadingView()
            case .success:
                GameListView(
                    gameListViewModel: gameListViewModel,
                    onAddFavorite: { game in
                        gameListViewModel.toggleGameIsFavorite(game: game)
                        gameListViewModel.addFavorite(game: game)
                    },
                    onRemoveFavorite: { game in
                        gameListViewModel.toggleGameIsFavorite(game: game)
                        gameListViewModel.removeFavorite(game: game)
                    }
                )
            case .failure(let failure):
                ErrorView(
                    error: failure,
                    retryAction: gameListViewModel.getTopRatedGames
                )
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(
                    action: { router.navigate(to: .profile) },
                    label: {
                        Label("Profile", systemImage: "person.crop.circle")
                            .labelStyle(.iconOnly)
                    }
                )
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(
                    action: { router.navigate(to: .favorite) },
                    label: {
                        Label("Favorite", systemImage: "star.fill").labelStyle(
                            .iconOnly)
                    }
                )
            }
        }
        .navigationTitle("Games")
        .onAppear { gameListViewModel.getTopRatedGames() }
        .onDisappear { gameListViewModel.onViewDisappear() }
    }
}

struct GameListView: View {
    @EnvironmentObject var router: Router

    @StateObject var gameListViewModel: GameListViewModel

    @State private var selectedGame: GameListItemModel?

    let onAddFavorite: (GameListItemModel) -> Void
    let onRemoveFavorite: (GameListItemModel) -> Void

    var body: some View {
        List {
            ForEach(gameListViewModel.gameListData) { game in
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
                            game.isFavorite
                                ? onRemoveFavorite(game) : onAddFavorite(game)
                        },
                        label: {
                            Label(
                                game.isFavorite
                                    ? "Remove favorite" : "Add favorite",
                                systemImage: game.isFavorite
                                    ? "star.fill" : "star"
                            )
                            .labelStyle(.iconOnly)
                            .environment(\.symbolVariants, .none)
                        }
                    )
                    .tint(.blue)
                }
            }
        }
        .listRowSpacing(16)
        .scrollContentBackground(.hidden)
        .alert(item: $selectedGame) { game in
            Alert(
                title: Text(
                    game.isFavorite ? "Remove favorite" : "Add favorite"),
                message: Text(
                    game.isFavorite
                        ? ("Successfully removed " + game.name + " to favorites")
                        : ("Successfully added " + game.name + " to favorites")
                )
            )
        }
    }
}

#Preview {
    GameListPage(
        gameListViewModel: GameListViewModel(
            gameUseCase: GameUseCaseImpl(
                gameRepository: MockGameRepository()
            )
        )
    )
}
