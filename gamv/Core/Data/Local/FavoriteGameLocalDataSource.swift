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
actor FavoriteGameLocalDataSource: Sendable {
    private var context: ModelContext { modelExecutor.modelContext }

    func fetchFavoriteGameEntity() -> AnyPublisher<
        [FavoriteGameEntity], CommonError
    > {
        return Future { promise in
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
        return Future { promise in
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

    func addFavoriteGameEntity(entity: FavoriteGameEntity) -> AnyPublisher<Void, Never> {
        return Future { promise in
            Task {
                do {
                    self.context.insert(entity)
                    try self.context.save()
                } catch {}
            }
        }
        .eraseToAnyPublisher()
    }

    func removeFavoriteGameEntity(entity: FavoriteGameEntity) -> AnyPublisher<Void, Never> {
        return Future { promise in
            Task {
                do {
                    let toBeDeletedGame = entity.id
                    
                    try self.context.delete(
                        model: FavoriteGameEntity.self,
                        where: #Predicate<FavoriteGameEntity> { game in
                            game.id == toBeDeletedGame
                        })
                    try self.context.save()
                } catch {}
            }
        }.eraseToAnyPublisher()
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
