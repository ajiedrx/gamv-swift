//
//  gamvApp.swift
//  gamv
//
//  Created by Ajie DR on 13/11/24.
//

import SwiftUI

@main
struct gamvApp: App {
    var body: some Scene {
        WindowGroup {
            GameListPage(gameListViewModel: GameListViewModel(gameUseCase: Injection.init().provideGameUseCase()))
        }
    }
}
