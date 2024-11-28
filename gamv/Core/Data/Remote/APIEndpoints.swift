//
//  API.swift
//  movapp
//
//  Created by Ajie DR on 06/11/24.
//

import Foundation

struct API {
    static let baseUrl = "https://api.rawg.io/api"
    static let DEFAULT_PAGE_SIZE = 30
    static let API_KEY = "137295fdc6664677bda70e17fc52d890"
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case games
        
        public var url : String {
            switch self {
            case .games:
                return "\(API.baseUrl)/games"
            }
        }
    }
}

enum HTTPMethod {
    case GET
    case POST
    case PUT
    case DELETE
    
    var method: String {
        switch self {
        case .GET: return "GET"
        case .POST: return "POST"
        case .PUT: return "PUT"
        case .DELETE: return "DELETE"
        }
    }
}
