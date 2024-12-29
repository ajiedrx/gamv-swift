//
//  LocalDataSource.swift
//  gamv
//
//  Created by Ajie DR on 28/11/24.
//

import Combine
import Foundation
import SwiftData

@ModelActor
actor LocalDataSource: Sendable {
    private var context: ModelContext { modelExecutor.modelContext }

    func fetchFavoriteGameEntity() -> AnyPublisher<
        [FavoriteGameEntity], CommonError
    > {
        Future { promise in
            Task {
                do {
                    let result = try self.context.fetch(
                        FetchDescriptor<FavoriteGameEntity>())
                    promise(.success(result))
                } catch {
                    promise(.failure(.unknownError(error.localizedDescription)))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func fetchFavoriteGameEntityIds() -> AnyPublisher<[Int], CommonError> {
        Future { promise in
            Task {
                do {
                    var fetchDescriptor = FetchDescriptor<FavoriteGameEntity>()
                    fetchDescriptor.propertiesToFetch = [\.id]

                    let result = try self.context.fetch(fetchDescriptor).map {
                        result in
                        result.id
                    }
                    promise(.success(result))
                } catch {
                    promise(.failure(.unknownError(error.localizedDescription)))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func addFavoriteGameEntity(entity: FavoriteGameEntity) async throws {
        Task {
            self.context.insert(entity)
            try self.context.save()
        }
    }

    func removeFavoriteGameEntity(entity: FavoriteGameEntity) async throws {
        Task {
            let toBeDeletedGame = entity.id

            try self.context.delete(
                model: FavoriteGameEntity.self,
                where: #Predicate<FavoriteGameEntity> { game in
                    game.id == toBeDeletedGame
                })
            try self.context.save()
        }
    }

    func isGameFavorite(gameId: Int) -> AnyPublisher<Bool, Never> {
        Future { promise in
            Task {
                let fetchDescriptor = FetchDescriptor<FavoriteGameEntity>(
                    predicate: #Predicate { game in game.id == gameId })
                let data = try? self.context.fetch(fetchDescriptor)
                let result = data != nil

                promise(.success(result))
            }
        }
        .eraseToAnyPublisher()
    }
}

extension ModelContext {
    var sqliteCommand: String {
        if let url = container.configurations.first?.url.path(
            percentEncoded: false)
        {
            "sqlite3 \"\(url)\""
        } else {
            "No SQLite database found."
        }
    }
}
