//
//  FavoriteGameViewModel.swift
//  gamv
//
//  Created by Ajie DR on 01/12/24.
//

import Foundation

class FavoriteGameViewModel: ObservableObject {
    //Dependencies
    private var gameUseCase: GameUseCase
    
    //Observables
    @Published var listViewState: ViewState<Any?, CommonError> = .loading
    @Published var favoriteGames: [GameListItemModel] = []
    
    init(gameUseCase: GameUseCase) {
        self.gameUseCase = gameUseCase
    }
    
    func getFavoriteGames() {
        listViewState = .loading
        
        Task {
            let result = await gameUseCase.getFavoriteGames()
            
            await MainActor.run {
                switch result {
                case .success(let result):
                    favoriteGames = result
                    listViewState = .success(nil)
                case .failure(let error):
                    listViewState = .failure(error)
                }
            }
        }
    }
    
    func removeFavoriteGame(game: GameListItemModel) {
        guard let toBeRemovedIndex = favoriteGames.firstIndex(of: game) else { return }
        
        favoriteGames.remove(at: toBeRemovedIndex)
        
        Task {
            await gameUseCase.removeFavorite(game: game)
        }
    }
}
