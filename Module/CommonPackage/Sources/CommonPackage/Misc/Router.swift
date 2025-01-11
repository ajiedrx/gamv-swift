//
//  ToolbarRoutes.swift
//  gamv
//
//  Created by Ajie DR on 18/11/24.
//

import Foundation
import SwiftUI
import CorePackage

public final class Router: ObservableObject {
    public init(navPath: NavigationPath = NavigationPath()) {
        self.navPath = navPath
    }
    
    public enum Destination: Hashable {
        case detail(game: GameListItemModel)
        case profile
        case favorite
    }
    
    @Published public var navPath = NavigationPath()
    
    public func navigate(to destination: Destination) {
            navPath.append(destination)
        }
        
        func navigateBack() {
            navPath.removeLast()
        }
        
        func navigateToRoot() {
            navPath.removeLast(navPath.count)
        }
}

