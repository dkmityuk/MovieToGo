//
//  NetworkProvider+Live.swift
//  MovieToGo
//
//  Created by Dmytro Kmytiuk on 13.02.2025.
//

import Dependencies
import Combine
import Foundation

extension NetworkProvider: DependencyKey {
    static var liveValue: NetworkProvider {
        let liveHelper = LiveHelper()
        
        return Self(
            fetchMoviesList: { category, page in
                liveHelper.fetchMoviesList(categoty: category, page: page)
            },
            fetchMovieDetails: { id in
                liveHelper.fetchMovieDetails(movieID: id)
            }
        )
    }
}

private extension NetworkProvider {
    struct LiveHelper {
        func fetchMoviesList(categoty: String, page: Int) -> AnyPublisher<[Movie], Error> {
            var components = URLComponents(string: APIConfig.baseUrl + "\(categoty)")
            components?.queryItems = [
                URLQueryItem(name: "page", value: "\(page)"),
            ]
            
            return performRequest(urlComponents: components, responseType: MovieResponse.self)
                .map { $0.results }
                .eraseToAnyPublisher()
        }
        
        func fetchMovieDetails(movieID: Int) -> AnyPublisher<MovieDetails, Error> {
            let components = URLComponents(string: APIConfig.baseUrl + "\(movieID)")
            
            return performRequest(urlComponents: components, responseType: MovieDetails.self)
        }
        
        private func performRequest<T: Decodable>(urlComponents: URLComponents?, responseType: T.Type) -> AnyPublisher<T, Error> {
            guard
                let url = urlComponents?.url
            else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue(APIConfig.apiKey, forHTTPHeaderField: "Authorization")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: responseType, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }
}

enum APIConfig {
    static let baseUrl = "https://api.themoviedb.org/3/movie/"
    
    static let apiKey = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZmFlZWEzYWU5NThmMTBmNzA0M2M0NDgyMDZhODMxZCIsIm5iZiI6MTczODg3NDE4Mi4wOCwic3ViIjoiNjdhNTFkNDY4ODU4Yzg3MDVhNjZmYzBjIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.MddDee4LNwnARrb39T6MhkDVfsxgOPToKz4oIH9Ws-4"
}
