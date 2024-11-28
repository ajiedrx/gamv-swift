//
//  GameUseCase.swift
//  gamv
//
//  Created by Ajie DR on 17/11/24.
//

protocol GameUseCase {
    func getListOfGame(page: Int, search: String) async -> Result<GameListModel, URLError>
}

final class GameUseCaseImpl: GameUseCase {
    private let gameRepository: GameRepositoryProtocol
    
    required init(gameRepository: GameRepositoryProtocol) {
        self.gameRepository = gameRepository
    }
    
    func getListOfGame(page: Int, search: String) async -> Result<GameListModel, URLError> {
        return await gameRepository.getListOfGames(page: page, search: search)
    }
}
