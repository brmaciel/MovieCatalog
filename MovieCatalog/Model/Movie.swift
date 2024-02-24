//
//  Movie.swift
//  MovieCatalog
//
//  Created by Bruno Maciel on 2/24/24.
//

import Foundation

struct MovieResponse: Decodable {
    let page: Int
    let movies: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: CodingKey {
        case page
        case results
        case total_pages
        case total_results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.page = try container.decode(Int.self, forKey: .page)
        self.movies = try container.decode([Movie].self, forKey: .results)
        self.totalPages = try container.decode(Int.self, forKey: .total_pages)
        self.totalResults = try container.decode(Int.self, forKey: .total_results)
    }
}

struct Movie: Decodable {
    let adult: Bool
    let backdropPath: String
    let genreIds: [Int64]
    let id: Int64
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: CodingKey {
        case adult
        case backdrop_path
        case genre_ids
        case id
        case original_language
        case original_title
        case overview
        case popularity
        case poster_path
        case release_date
        case title
        case video
        case vote_average
        case vote_count
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.adult = try container.decode(Bool.self, forKey: .adult)
        self.backdropPath = try container.decode(String.self, forKey: .backdrop_path)
        self.genreIds = try container.decode([Int64].self, forKey: .genre_ids)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.originalLanguage = try container.decode(String.self, forKey: .original_language)
        self.originalTitle = try container.decode(String.self, forKey: .original_title)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.posterPath = try container.decode(String.self, forKey: .poster_path)
        self.releaseDate = try container.decode(String.self, forKey: .release_date)
        self.title = try container.decode(String.self, forKey: .title)
        self.video = try container.decode(Bool.self, forKey: .video)
        self.voteAverage = try container.decode(Double.self, forKey: .vote_average)
        self.voteCount = try container.decode(Int.self, forKey: .vote_count)
    }
}
