//
//  HomeService.swift
//  MovieCatalog
//
//  Created by Bruno Maciel on 2/24/24.
//

import Foundation

protocol HomeServiceProtocol {
    func fetchMovies(completion: @escaping ([[Movie]]) -> Void)
}

class HomeService: HomeServiceProtocol {
    func fetchMovies(completion: @escaping ([[Movie]]) -> Void) {
        let numberOfSections = 6
        var movieSections: [[Movie]] = Array(repeating: [], count: numberOfSections)
        var completedSection = 0
        
        (0..<numberOfSections).forEach { section in
            ApiRequester.shared.request(page: section + 1) { result in
                switch result {
                case .success(let data):
                    do {
                        let model = try JSONDecoder().decode(MovieResponse.self, from: data)
                        movieSections[section] = model.movies
                    } catch {
                        movieSections[section] = []
                    }
                case .failure:
                    movieSections[section] = []
                }
                completedSection += 1
                
                if completedSection == numberOfSections {
                    completion(movieSections)
                }
            }
        }
    }
}
