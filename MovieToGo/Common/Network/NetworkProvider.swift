//
//  NetworkProvider.swift
//  MovieToGo
//
//  Created by Dmytro Kmytiuk on 11.02.2025.
//

import Combine

struct NetworkProvider {
    var fetchMoviesList: (String, Int) -> AnyPublisher<[Movie], Error>
    var fetchMovieDetails: (Int) -> AnyPublisher<MovieDetails, Error>
}
