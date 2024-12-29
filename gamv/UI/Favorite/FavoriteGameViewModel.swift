//
//  FavoriteGameViewModel.swift
//  gamv
//
//  Created by Ajie DR on 01/12/24.
//

import Foundation
import Combine

class FavoriteGameViewModel: ObservableObject {
    //Dependencies
    private var gameUseCase: GameUseCase
    
    //Combine Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    //Observables
    @Published var listViewState: ViewState<Any?, CommonError> = .loading
    @Published var favoriteGames: [GameListItemModel] = []
    
    init(gameUseCase: GameUseCase) {
        self.gameUseCase = gameUseCase
    }
    
    func getFavoriteGames() {
        listViewState = .loading
        
        gameUseCase.getFavoriteGames()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        self.listViewState = .failure(error)
                    case .finished:
                        self.listViewState = .success(nil)
                    }
                },
                receiveValue: { value in
                    self.favoriteGames = value
                }
            )
            .store(in: &cancellables)
    }
    
    func removeFavoriteGame(game: GameListItemModel) {
        guard let toBeRemovedIndex = favoriteGames.firstIndex(of: game) else { return }
        
        favoriteGames.remove(at: toBeRemovedIndex)
        
        Task {
            do {
                try await gameUseCase.removeFavorite(game: game)
            } catch {}
        }
    }
}
