//
//  GameListViewModel.swift
//  gamv
//
//  Created by Ajie DR on 17/11/24.
//

import Foundation
import Combine

class GameListViewModel: ObservableObject {
    //Dependencies
    private var gameUseCase: GameUseCase
    
    //Combine Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    //Observables
    @Published var listViewState: ViewState<Any?, CommonError> = .loading
    @Published var gameListData: [GameListItemModel] = []
            
    init(gameUseCase: GameUseCase) {
        self.gameUseCase = gameUseCase
    }
    
    func getTopRatedGames() {
        listViewState = .loading
        
        gameUseCase.getListOfGame(page: 1, search: "")
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.listViewState = .failure(error)
                case .finished:
                    self.listViewState = .success(nil)
                }
            }, receiveValue: { value in
                self.gameListData = value.results ?? []
            })
            .store(in: &cancellables)
    }
    
    func toggleGameIsFavorite(game: GameListItemModel) {
        if let index = gameListData.firstIndex(where: { $0.id == game.id }) {
            gameListData[index].isFavorite.toggle()
        }
    }
    
    func addFavorite(game: GameListItemModel) {
        Task {
            do {
                try await gameUseCase.addFavorite(game: game)
            } catch {}
        }
    }
    
    func removeFavorite(game: GameListItemModel) {
        Task {
            do {
                try await gameUseCase.removeFavorite(game: game)
            } catch {}
        }
    }
    
    func onViewDisappear() {
        listViewState = .idle
    }
}
