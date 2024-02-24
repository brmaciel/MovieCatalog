//
//  ApiRequester.swift
//  MovieCatalog
//
//  Created by Bruno Maciel on 2/24/24.
//

import Foundation

class ApiRequester {
    private let apiKey = "1685515c99a307e8dcebdd979f0c6588"
    private let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNjg1NTE1Yzk5YTMwN2U4ZGNlYmRkOTc5ZjBjNjU4OCIsInN1YiI6IjY1ZGEwYjM2NGU0ZGZmMDE3Y2I4OGE0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0lj0kGq1BvcN0PB3-nnD1Eh-NS6NH8P_NaHXCVQdl5s"
    static let shared = ApiRequester()
    private init() {}
    
    var urlSession: URLSession = URLSession.shared
    
    func request(page: Int,
                 completion: @escaping (Result<Data, Error>) -> Void) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?page=\(page)&api_key=\(apiKey)")!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode),
                      let responseData = data else {
                    completion(.failure(ApiError.defaultError))
                    return }
                
                completion(.success(responseData))
            }
        }
        dataTask.resume()
    }
}

extension ApiRequester {
    enum ApiError: Error {
        case defaultError
    }
}
