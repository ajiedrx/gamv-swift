//
//  ToolbarRoutes.swift
//  gamv
//
//  Created by Ajie DR on 18/11/24.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    public enum Destination: Hashable {
        case detail(game: GameListItemModel)
        case profile
        case favorite
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
            navPath.append(destination)
        }
        
        func navigateBack() {
            navPath.removeLast()
        }
        
        func navigateToRoot() {
            navPath.removeLast(navPath.count)
        }
}

