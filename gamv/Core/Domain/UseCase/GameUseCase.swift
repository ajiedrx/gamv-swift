//
//  GameUseCase.swift
//  gamv
//
//  Created by Ajie DR on 17/11/24.
//

protocol GameUseCase {
    func getListOfGame(page: Int, search: String) async -> Result<GameListModel, CommonError>
    func addFavorite(game: GameListItemModel) async -> Void
    func removeFavorite(game: GameListItemModel) async -> Void
    func getFavoriteGames() async -> Result<[GameListItemModel], CommonError>
}

final class GameUseCaseImpl: GameUseCase {
    private let gameRepository: GameRepositoryProtocol
    
    required init(gameRepository: GameRepositoryProtocol) {
        self.gameRepository = gameRepository
    }
    
    func getListOfGame(page: Int, search: String) async -> Result<GameListModel, CommonError> {
        return await gameRepository.getListOfGames(page: page, search: search)
    }
    
    func addFavorite(game: GameListItemModel) async {
        await gameRepository.saveFavoriteGame(game: game)
    }
    
    func removeFavorite(game: GameListItemModel) async {
        await gameRepository.deleteFavoriteGame(game: game)
    }
    
    func getFavoriteGames() async -> Result<[GameListItemModel], CommonError> {
        return await gameRepository.fetchFavoriteGamesFromLocal()
    }
}
