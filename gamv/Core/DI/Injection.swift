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

    func provideGameUseCase() -> GameUseCase {
        let repository = provideRepository()
        
        return GameUseCaseImpl(gameRepository: repository)
    }
}


