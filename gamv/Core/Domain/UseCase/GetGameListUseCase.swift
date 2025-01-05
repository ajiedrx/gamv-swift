//
//  GetGameListUseCase.swift
//  gamv
//
//  Created by Ajie DR on 05/01/25.
//

import Foundation
import Combine

class GetGameListUseCase {
    private let gameRepository: GameRepositoryProtocol
    
    required init(gameRepository: GameRepositoryProtocol) {
        self.gameRepository = gameRepository
    }
    
    func execute(page: Int, search: String) -> AnyPublisher<GameListModel, CommonError> {
        return gameRepository.getListOfGames(page: page, search: search)
    }
}
