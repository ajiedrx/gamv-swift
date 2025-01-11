//
//  Untitled.swift
//  gamv
//
//  Created by Ajie DR on 05/01/25.
//

import Foundation
import Combine

class AddFavoriteGameUseCase {
    private let gameRepository: GameRepositoryProtocol
    
    required init(gameRepository: GameRepositoryProtocol) {
        self.gameRepository = gameRepository
    }
    
    func execute(game: GameListItemModel) -> AnyPublisher<Void, Never> {
        return gameRepository.saveFavoriteGame(game: game)
    }
}
