//
//  HomeViewModel.swift
//  MovieCatalog
//
//  Created by Bruno Maciel on 2/24/24.
//

import Combine
import Foundation

protocol HomeViewModelProtocol {
    var statePublisher: AnyPublisher<HomeViewModel.State, Never> { get }
    func loadMovies()
}

class HomeViewModel {
    var service: HomeServiceProtocol
    var movies: [Movie] = []
    private let stateSubject = PassthroughSubject<State, Never>()
    var statePublisher: AnyPublisher<State, Never> { stateSubject.eraseToAnyPublisher() }
    
    init(service: HomeServiceProtocol) {
        self.service = service
    }
    
}

extension HomeViewModel: HomeViewModelProtocol {
    func loadMovies() {
        stateSubject.send(.loading(true))
        service.fetchMovies { [weak self] movies in
            self?.stateSubject.send(.loading(false))
            self?.movies = movies
            self?.stateSubject.send(.movies)
        } failure: { [weak self] _ in
            print("error")
            self?.stateSubject.send(.loading(false))
        }
    }
}

extension HomeViewModel {
    enum State {
        case loading(Bool)
        case movies
    }
}
