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
    
    func addFavoriteGameEntity(entity: FavoriteGameEntity) async throws {
        context.insert(entity)
        try context.save()
    }
    
    func removeFavoriteGameEntity(entity: FavoriteGameEntity) async throws {
        context.delete(entity)
        try context.save()
    }
}
