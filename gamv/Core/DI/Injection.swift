//
//  Injeciton.swift
//  gamv
//
//  Created by Ajie DR on 17/11/24.
//

import Foundation

final class Injection: NSObject {
    private func provideRepository() -> GameRepositoryProtocol {
        
        let remoteDS = RemoteDataSource.sharedInstance
        
        return GameRepository.getInstance(remote: remoteDS)
    }

    func provideGameUseCase() -> GameUseCase {
        let repository = provideRepository()
        
        return GameUseCaseImpl(gameRepository: repository)
    }
}


