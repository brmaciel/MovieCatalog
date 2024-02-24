//
//  HomeService.swift
//  MovieCatalog
//
//  Created by Bruno Maciel on 2/24/24.
//

import Foundation

protocol HomeServiceProtocol {
    func fetchMovies(success: @escaping (Data) -> Void,
                     failure: @escaping (Error) -> Void)
}

class HomeService: HomeServiceProtocol {
    func fetchMovies(success: @escaping (Data) -> Void,
                     failure: @escaping (Error) -> Void) {
        ApiRequester.shared.request(page: 1) { result in
            switch result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
