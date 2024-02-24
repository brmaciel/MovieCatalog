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
    func selectPosterAt(section: Int, row: Int)
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
    var numberOfSections: Int { 5 }
    var numberOfRows: Int { 1 }
    
    func loadMovies() {
        stateSubject.send(.loading(true))
        service.fetchMovies { [weak self] movies in
            self?.stateSubject.send(.loading(false))
            self?.movies = movies
            self?.stateSubject.send(.movies(MoviePosterSectionViewData(movies: movies)))
        } failure: { [weak self] _ in
            print("error")
            self?.stateSubject.send(.loading(false))
        }
    }

    func selectPosterAt(section: Int, row: Int) {
        if movies[row].voteAverage >= 6 {
            stateSubject.send(.contentDetails)
        } else {
            stateSubject.send(.lowQualityContent)
        }
    }
}

extension HomeViewModel {
    enum State {
        case loading(Bool)
        case movies(MoviePosterSectionViewData)
        case lowQualityContent
        case contentDetails
    }
}
