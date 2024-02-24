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
    var numberOfSections: Int { get }
    var numberOfRows: Int { get }
    func loadMovies()
    func sectionTitle(for section: Int) -> String
    func selectPosterAt(section: Int, row: Int)
}

class HomeViewModel {
    var coordinator: HomeCoordinatorProtocol
    var service: HomeServiceProtocol
    var movies: [Movie] = []
    private let stateSubject = PassthroughSubject<State, Never>()
    var statePublisher: AnyPublisher<State, Never> { stateSubject.eraseToAnyPublisher() }
    
    init(coordinator: HomeCoordinatorProtocol,
         service: HomeServiceProtocol) {
        self.coordinator = coordinator
        self.service = service
    }
    
}

extension HomeViewModel: HomeViewModelProtocol {
    var numberOfSections: Int { 5 }
    var numberOfRows: Int { 1 }
    
    func loadMovies() {
        stateSubject.send(.loading(true))
        service.fetchMovies { [weak self] movies in
            self?.stateSubject.send(.loading(false))
            self?.movies = movies
            self?.stateSubject.send(.movies(MoviePosterSectionViewData(movies: movies)))
        } failure: { [weak self] _ in
            self?.stateSubject.send(.loading(false))
            self?.stateSubject.send(.error)
        }
    }

    func sectionTitle(for section: Int) -> String {
        "Section Header \(section)"
    }

    func selectPosterAt(section: Int, row: Int) {
        if movies[row].voteAverage >= 6 {
            coordinator.presentDetails(of: movies[row])
        } else {
            stateSubject.send(.lowQualityContent)
        }
    }
}

extension HomeViewModel {
    enum State {
        case loading(Bool)
        case movies(MoviePosterSectionViewData)
        case error
        case lowQualityContent
    }
}
