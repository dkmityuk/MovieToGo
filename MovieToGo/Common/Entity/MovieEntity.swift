//
//  MovieDTO.swift
//  MovieToGo
//
//  Created by Dmytro Kmytiuk on 11.02.2025.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let release_date: String
    let poster_path: String
}

struct MovieDetails: Decodable {
    let id: Int
    let title: String
    let overview: String
    let release_date: String
    let backdrop_path: String?
    let poster_path: String?
    let vote_average: Double
}
