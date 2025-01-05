//
//  gamvApp.swift
//  gamv
//
//  Created by Ajie DR on 13/11/24.
//

import SwiftUI

@main
struct gamvApp: App {
    @ObservedObject var router = Router()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                GameListPage(
                    gameListViewModel: GameListViewModel(
                        getGameListUseCase: Injection.init().provideGetGameListUseCase(),
                        addFavoriteGameUseCase: Injection.init().provideAddFavoriteGameUseCase(),
                        removeFavoriteGameUseCase: Injection.init().provideRemoveFavoriteGameUseCase())
                )
                .navigationDestination(for: Router.Destination.self) {
                    destination in
                    switch destination {
                    case .profile:
                        ProfileView()
                    case .favorite:
                        FavoriteGamePage(
                            favoriteGameViewModel: FavoriteGameViewModel(
                                getFavoriteGameListUseCase: Injection.init().provideGetFavoriteGameListUseCase(),
                                removeFavoriteGameUseCase: Injection.init().provideRemoveFavoriteGameUseCase()
                            )
                        )
                    case .detail(let game):
                        GameDetailPage(game: game)
                    }
                }
            }
            .environmentObject(router)
        }
    }
}
