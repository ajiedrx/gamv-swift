//
//  GetFavoriteGameListUseCase.swift
//  gamv
//
//  Created by Ajie DR on 05/01/25.
//

import Foundation
import Combine

class GetFavoriteGameListUseCase {
    private let gameRepository: GameRepositoryProtocol
    
    required init(gameRepository: GameRepositoryProtocol) {
        self.gameRepository = gameRepository
    }
    
    func execute() -> AnyPublisher<[GameListItemModel], CommonError> {
        return gameRepository.fetchFavoriteGamesFromLocal()
    }
}
