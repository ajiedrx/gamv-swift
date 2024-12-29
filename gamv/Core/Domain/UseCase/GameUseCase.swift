//
//  GameUseCase.swift
//  gamv
//
//  Created by Ajie DR on 17/11/24.
//

import Combine

protocol GameUseCase {
    func getListOfGame(page: Int, search: String) -> AnyPublisher<GameListModel, CommonError>
    func addFavorite(game: GameListItemModel) async throws
    func removeFavorite(game: GameListItemModel) async throws
    func getFavoriteGames() -> AnyPublisher<[GameListItemModel], CommonError>
}

final class GameUseCaseImpl: GameUseCase {
    private let gameRepository: GameRepositoryProtocol
    
    required init(gameRepository: GameRepositoryProtocol) {
        self.gameRepository = gameRepository
    }
    
    func getListOfGame(page: Int, search: String) -> AnyPublisher<GameListModel, CommonError> {
        return gameRepository.getListOfGames(page: page, search: search)
    }
    
    func addFavorite(game: GameListItemModel) async throws {
        try await gameRepository.saveFavoriteGame(game: game)
    }
    
    func removeFavorite(game: GameListItemModel) async throws {
        try await gameRepository.deleteFavoriteGame(game: game)
    }
    
    func getFavoriteGames() -> AnyPublisher<[GameListItemModel], CommonError> {
        return gameRepository.fetchFavoriteGamesFromLocal()
    }
}
