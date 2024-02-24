//
//  MoviePosterSectionViewData.swift
//  MovieCatalog
//
//  Created by Bruno Maciel on 2/24/24.
//

import Foundation

struct MoviePosterSectionViewData {
    let movies: [Movie]
    
    var numPosters: Int { movies.count }
    
    init(movies: [Movie]) {
        self.movies = movies
    }
}
