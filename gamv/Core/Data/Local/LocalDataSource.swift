//
//  LocalDataSource.swift
//  gamv
//
//  Created by Ajie DR on 28/11/24.
//

import Foundation
import SwiftData

@ModelActor
actor LocalDataSource : Sendable {
    private var context: ModelContext { modelExecutor.modelContext }
    
    func fetchFavoriteGameEntity() async throws -> [FavoriteGameEntity] {
        return try context.fetch(FetchDescriptor<FavoriteGameEntity>())
    }
    
    func fetchFavoriteGameEntityIds() async throws -> [Int] {
        print(context.sqliteCommand)
        
        var fetchDescriptor = FetchDescriptor<FavoriteGameEntity>()
        
        fetchDescriptor.propertiesToFetch = [\.id]
        
        return try context.fetch(fetchDescriptor).map { result in
            result.id
        }
    }
    
    func addFavoriteGameEntity(entity: FavoriteGameEntity) async throws {
        context.insert(entity)
        try context.save()
    }
    
    func removeFavoriteGameEntity(entity: FavoriteGameEntity) async throws {
        let toBeDeletedGame = entity.id
        
        try context.delete(model: FavoriteGameEntity.self, where: #Predicate<FavoriteGameEntity> { game in
            game.id == toBeDeletedGame
        })
        
        try context.save()
    }
    
    func isGameFavorite(gameId: Int) async -> Bool {
        let fetchDescriptor = FetchDescriptor<FavoriteGameEntity>(predicate: #Predicate { game in
            game.id == gameId
        })
        
        let result = try? context.fetch(fetchDescriptor)
        
        return result != nil
    }
}

extension ModelContext {
    var sqliteCommand: String {
        if let url = container.configurations.first?.url.path(percentEncoded: false) {
            "sqlite3 \"\(url)\""
        } else {
            "No SQLite database found."
        }
    }
}
