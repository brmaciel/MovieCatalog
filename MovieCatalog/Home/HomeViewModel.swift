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
    func tryAgainLoading(section: Int)
    func sectionTitle(for section: Int) -> String
    func selectPosterAt(section: Int, row: Int)
}

class HomeViewModel {
    var coordinator: HomeCoordinatorProtocol
    var service: HomeServiceProtocol
    var movieSections: [[Movie]] = []
    private let stateSubject = PassthroughSubject<State, Never>()
    var statePublisher: AnyPublisher<State, Never> { stateSubject.eraseToAnyPublisher() }
    
    init(coordinator: HomeCoordinatorProtocol,
         service: HomeServiceProtocol) {
        self.coordinator = coordinator
        self.service = service
    }
    
}

extension HomeViewModel: HomeViewModelProtocol {
    var numberOfSections: Int { movieSections.count }
    var numberOfRows: Int { 1 }
    
    func loadMovies() {
        stateSubject.send(.loading(true))
        service.fetchMovies { [weak self] movieSections in
            self?.stateSubject.send(.loading(false))
            self?.movieSections = movieSections
            self?.stateSubject.send(.movies(movieSections.map(MoviePosterSectionViewData.init)))
        }
    }
    
    func tryAgainLoading(section: Int) {
        stateSubject.send(.loading(true))
        service.fetchMovies(section: section + 1) { [weak self] moviesSection in
            guard let self else { return }
            self.stateSubject.send(.loading(false))
            self.movieSections[section] = moviesSection
            self.stateSubject.send(.updateSection(section, self.movieSections.map(MoviePosterSectionViewData.init)))
        }
    }

    func sectionTitle(for section: Int) -> String {
        "Movie List \(section)"
    }

    func selectPosterAt(section: Int, row: Int) {
        if movieSections[section][row].voteAverage >= 6 {
            coordinator.presentDetails(of: movieSections[section][row])
        } else {
            stateSubject.send(.lowQualityContent)
        }
    }
}

extension HomeViewModel {
    enum State {
        case loading(Bool)
        case movies([MoviePosterSectionViewData])
        case updateSection(Int, [MoviePosterSectionViewData])
        case lowQualityContent
    }
}
