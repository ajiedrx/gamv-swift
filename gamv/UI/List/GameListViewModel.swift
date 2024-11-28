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
    @Published var listViewState: ViewState<[GameListItemModel], Error> = .loading
            
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
                case .success(let gameList):
                    listViewState = .success(gameList.results ?? [])
                case .failure(let error):
                    listViewState = .failure(error)
                }
            }
        }
    }
    
    func onViewDisappear() {
        getGamesTask?.cancel()
        getGamesTask = nil
        listViewState = .idle
    }
}
