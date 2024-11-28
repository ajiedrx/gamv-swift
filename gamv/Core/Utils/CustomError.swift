//
//  CustomError.swift
//  gamv
//
//  Created by Ajie DR on 14/11/24.
//

import Foundation

enum Error: LocalizedError {

    case unknownError(String)
    case invalidResponse
    case addressUnreachable(String)
  
    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "Invalid response"
        case .addressUnreachable(let url): return "\(url) is unreachable."
        case .unknownError(let message): return "Unknown error \(message)"
        }
    }
}
