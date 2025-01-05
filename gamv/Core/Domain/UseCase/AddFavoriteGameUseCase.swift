//
//  Untitled.swift
//  gamv
//
//  Created by Ajie DR on 05/01/25.
//

class AddFavoriteGameUseCase {
    private let gameRepository: GameRepositoryProtocol
    
    required init(gameRepository: GameRepositoryProtocol) {
        self.gameRepository = gameRepository
    }
    
    func execute(game: GameListItemModel) async throws {
        try await gameRepository.saveFavoriteGame(game: game)
    }
}
