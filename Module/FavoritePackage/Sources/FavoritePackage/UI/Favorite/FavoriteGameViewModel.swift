//
//  FavoriteGameViewModel.swift
//  gamv
//
//  Created by Ajie DR on 01/12/24.
//

import Foundation
import Combine
import CorePackage
import CommonPackage

public class FavoriteGameViewModel: ObservableObject {
    //Dependencies
    private var getFavoriteGameListUseCase: GetFavoriteGameListUseCase
    private var removeFavoriteGameUseCase: RemoveFavoriteGameUseCase
    
    //Combine Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    //Observables
    @Published var listViewState: ViewState<Any?, CommonError> = .loading
    @Published var favoriteGames: [GameListItemModel] = []
    
    public init(
        getFavoriteGameListUseCase: GetFavoriteGameListUseCase,
        removeFavoriteGameUseCase: RemoveFavoriteGameUseCase
    ) {
        self.getFavoriteGameListUseCase = getFavoriteGameListUseCase
        self.removeFavoriteGameUseCase = removeFavoriteGameUseCase
    }
    
    func getFavoriteGames() {
        listViewState = .loading
        
        getFavoriteGameListUseCase
            .execute()
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
        
        removeFavoriteGameUseCase
            .execute(game: game)
            .sink(
                receiveCompletion: { completion in },
                receiveValue: { value in }
            )
            .store(in: &cancellables)
    }
}
