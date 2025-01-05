//
//  Injeciton.swift
//  gamv
//
//  Created by Ajie DR on 17/11/24.
//

import Foundation
import SwiftData

final class Injection: NSObject {
    private func provideRepository() -> GameRepositoryProtocol {
        let remoteDS = RemoteDataSource.sharedInstance
        
        let favoriteGameModelContainer = try! ModelContainer(for: FavoriteGameEntity.self)
        
        return GameRepository.getInstance(remote: remoteDS, local: LocalDataSource(modelContainer: favoriteGameModelContainer))
    }
    
    func provideGetGameListUseCase() -> GetGameListUseCase {
        let repository = provideRepository()
        
        return GetGameListUseCase(gameRepository: repository)
    }
    
    func provideGetFavoriteGameListUseCase() -> GetFavoriteGameListUseCase {
        let repository = provideRepository()
        
        return GetFavoriteGameListUseCase(gameRepository: repository)
    }
    
    func provideAddFavoriteGameUseCase() -> AddFavoriteGameUseCase {
        let repository = provideRepository()
        
        return AddFavoriteGameUseCase(gameRepository: repository)
    }
    
    func provideRemoveFavoriteGameUseCase() -> RemoveFavoriteGameUseCase {
        let repository = provideRepository()
        
        return RemoveFavoriteGameUseCase(gameRepository: repository)
    }
}


