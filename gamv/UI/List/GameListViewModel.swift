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
    private var getGameListUseCase: GetGameListUseCase
    private var addFavoriteGameUseCase: AddFavoriteGameUseCase
    private var removeFavoriteGameUseCase: RemoveFavoriteGameUseCase
    
    //Combine Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    //Observables
    @Published var listViewState: ViewState<Any?, CommonError> = .loading
    @Published var gameListData: [GameListItemModel] = []
            
    init(getGameListUseCase: GetGameListUseCase, addFavoriteGameUseCase: AddFavoriteGameUseCase, removeFavoriteGameUseCase: RemoveFavoriteGameUseCase) {
        self.getGameListUseCase = getGameListUseCase
        self.addFavoriteGameUseCase = addFavoriteGameUseCase
        self.removeFavoriteGameUseCase = removeFavoriteGameUseCase
    }
    
    func getTopRatedGames() {
        listViewState = .loading
        
        getGameListUseCase
            .execute(page: 1, search: "")
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
        addFavoriteGameUseCase
            .execute(game: game)
            .sink(
                receiveCompletion: { completion in },
                receiveValue: { value in }
            )
            .store(in: &cancellables)
    }
    
    func removeFavorite(game: GameListItemModel) {
        removeFavoriteGameUseCase
            .execute(game: game)
            .sink(
                receiveCompletion: { completion in },
                receiveValue: { value in }
            )
            .store(in: &cancellables)
    }
    
    func onViewDisappear() {
        listViewState = .idle
    }
}
