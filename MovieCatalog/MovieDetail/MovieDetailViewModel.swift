//
//  MovieDetailViewModel.swift
//  MovieCatalog
//
//  Created by Bruno Maciel on 2/24/24.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    var posterUrl: URL? { get }
    var rating: String { get }
}

class MovieDetailViewModel {
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
}

extension MovieDetailViewModel: MovieDetailViewModelProtocol {
    var posterUrl: URL? {
        URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")
    }
    
    var rating: String {
        String(format: "%.1f", movie.voteAverage)
    }
}
