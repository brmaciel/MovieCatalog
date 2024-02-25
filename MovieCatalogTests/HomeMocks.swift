//
//  HomeMocks.swift
//  MovieCatalogTests
//
//  Created by Bruno Maciel on 2/25/24.
//

import Foundation
@testable import MovieCatalog

class HomeCoordinatorMock: HomeCoordinatorProtocol {
    var presentDetailsCalled = false
    func presentDetails(of movie: MovieCatalog.Movie) {
        presentDetailsCalled = true
    }
}

class HomeServiceMock: HomeServiceProtocol {
    var fetchMoviesCalled = false
    var fetchMoviesSectionCalled = false
    
    func fetchMovies(completion: @escaping ([[Movie]]) -> Void) {
        fetchMoviesCalled = true
        completion([])
    }
    
    func fetchMovies(section: Int, completion: @escaping ([Movie]) -> Void) {
        fetchMoviesSectionCalled = true
        completion([])
    }
}

struct MoviewMock {
    static func mock(adult: Bool = false,
                     backdropPath: String = "",
                     genreIds: [Int64] = [0],
                     id: Int64 = 0,
                     originalLanguage: String = "",
                     originalTitle: String = "",
                     overview: String = "",
                     popularity: Double = 0,
                     posterPath: String = "",
                     releaseDate: String = "",
                     title: String = "",
                     video: Bool = true,
                     voteAverage: Double = 0,
                     voteCount: Int = 0) -> Movie {
        return .init(adult: adult,
                     backdropPath: backdropPath,
                     genreIds: genreIds,
                     id: id,
                     originalLanguage: originalLanguage,
                     originalTitle: originalTitle,
                     overview: overview,
                     popularity: popularity,
                     posterPath: posterPath,
                     releaseDate: releaseDate,
                     title: title,
                     video: video,
                     voteAverage: voteAverage,
                     voteCount: voteCount)
    }
}
