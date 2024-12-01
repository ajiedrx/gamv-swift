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
                        gameUseCase: Injection.init().provideGameUseCase())
                )
                .navigationDestination(for: Router.Destination.self) {
                    destination in
                    switch destination {
                    case .profile:
                        ProfileView()
                    case .favorite:
                        FavoriteGamePage(
                            favoriteGameViewModel: FavoriteGameViewModel(
                                gameUseCase: Injection.init()
                                    .provideGameUseCase()))
                    case .detail(let game):
                        GameDetailPage(game: game)
                    }
                }
            }
            .environmentObject(router)
        }
    }
}
