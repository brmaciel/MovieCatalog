//
//  MoviePosterViewData.swift
//  MovieCatalog
//
//  Created by Bruno Maciel on 2/24/24.
//

import Foundation

struct MoviePosterViewData {
    let movie: Movie
    
    var isHightQuality: Bool { movie.voteAverage >= 6 }
    
    init(movie: Movie) {
        self.movie = movie
    }
}
