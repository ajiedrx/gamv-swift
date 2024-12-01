//
//  GameListViewModel.swift
//  gamv
//
//  Created by Ajie DR on 17/11/24.
//

import Foundation

class GameListViewModel: ObservableObject {
    //Dependencies
    private var gameUseCase: GameUseCase
    
    //Tasks
    private var getGamesTask: Task<Void, Never>?
    
    //Observables
    @Published var listViewState: ViewState<Any?, CommonError> = .loading
    @Published var gameListData: [GameListItemModel] = []
            
    init(gameUseCase: GameUseCase) {
        self.gameUseCase = gameUseCase
    }
    
    func getTopRatedGames() {
        getGamesTask?.cancel()
        
        listViewState = .loading
        
        getGamesTask = Task {
            guard !Task.isCancelled
            else {
                await MainActor.run { listViewState = .idle }
                return
            }
            
            let result = await gameUseCase.getListOfGame(page: 1, search: "") //TODO paging
            
            await MainActor.run {
                switch result {
                case .success(let result):
                    gameListData = result.results ?? []
                    listViewState = .success(nil)
                case .failure(let error):
                    listViewState = .failure(error)
                }
            }
        }
    }
    
    func toggleGameIsFavorite(game: GameListItemModel) {
        if let index = gameListData.firstIndex(where: { $0.id == game.id }) {
            gameListData[index].isFavorite.toggle()
        }
    }
    
    func addFavorite(game: GameListItemModel) {
        Task {
            await gameUseCase.addFavorite(game: game)
        }
    }
    
    func removeFavorite(game: GameListItemModel) {
        Task {
            await gameUseCase.removeFavorite(game: game)
        }
    }
    
    func onViewDisappear() {
        getGamesTask?.cancel()
        getGamesTask = nil
        listViewState = .idle
    }
}
