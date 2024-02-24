//
//  HomeViewModel.swift
//  MovieCatalog
//
//  Created by Bruno Maciel on 2/24/24.
//

import Foundation

protocol HomeViewModelProtocol {
    func loadMovies()
}

class HomeViewModel {
    var service: HomeServiceProtocol
    
    init(service: HomeServiceProtocol) {
        self.service = service
    }
    
}

extension HomeViewModel: HomeViewModelProtocol {
    func loadMovies() {
        service.fetchMovies { _ in
            print("movies")
        } failure: { _ in
            print("error")
        }
    }
}
