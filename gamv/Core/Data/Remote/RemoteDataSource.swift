//
//  RemoteDataSource.swift
//  gamv
//
//  Created by Ajie DR on 14/11/24.
//

import Foundation

protocol RemoteDataSourceProtocol {
    func getListOfGames(page: Int, search: String) async throws -> GameListResponse
}

final class RemoteDataSource: NSObject {
    private override init () {}
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getListOfGames(page: Int, search: String) async throws -> GameListResponse {
        
        guard let url = URL(string: Endpoints.Gets.games.url) else {
            throw CommonError.addressUnreachable(Endpoints.Gets.games.url)
        }
        
        let urlComponents = getUrlComponents(url: url, page: page, search: search)
        
        let (data, response) = try await URLSession.shared.data(
            for: getRequest(urlComponents: urlComponents, method: HTTPMethod.GET)
        )
        
        return try getResponse(response: response, data: data)
    }
    
    func getUrlComponents(url: URL, page: Int, search: String) -> URLComponents {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "search", value: search),
            URLQueryItem(name: "key", value: API.API_KEY)
        ]
        
        urlComponents.queryItems = queryItems
        
        return urlComponents
    }
    
    func getRequest(urlComponents: URLComponents, method: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: urlComponents.url!)
        
        request.httpMethod = method.method
        request.timeoutInterval = 30
        
        return request
    }
    
    func getResponse<T : Decodable> (response: URLResponse, data: Data) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
        else { throw CommonError.invalidResponse }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw CommonError.invalidResponse
        }
    }
}
