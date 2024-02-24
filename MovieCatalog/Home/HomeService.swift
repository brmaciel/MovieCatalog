//
//  HomeService.swift
//  MovieCatalog
//
//  Created by Bruno Maciel on 2/24/24.
//

import Foundation

protocol HomeServiceProtocol {
    func fetchMovies(success: @escaping ([Movie]) -> Void,
                     failure: @escaping (Error) -> Void)
}

class HomeService: HomeServiceProtocol {
    func fetchMovies(success: @escaping ([Movie]) -> Void,
                     failure: @escaping (Error) -> Void) {
        ApiRequester.shared.request(page: 1) { result in
            switch result {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(MovieResponse.self, from: data)
                    success(model.movies)
                } catch {
                    failure(error)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
}
