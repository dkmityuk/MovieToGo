//
//  DetailViewModel.swift
//  MovieToGo
//
//  Created by Dmytro Kmytiuk on 12.02.2025.
//

import Combine
import SwiftUI
import Dependencies

final class DetailViewModel: ObservableObject {
    @Dependency(\.networkProvider) var networkProvider
    @Published var movie: MovieDetails? = nil
    let id: Int
    private var cancellables = Set<AnyCancellable>()
    
    init(id: Int) {
        self.id = id
    }

    func loadMovie() {
        networkProvider.fetchMovieDetails(id)
                .sink(receiveCompletion: { completion in
                  if case .failure(let error) = completion {
                       print("Error loading movies: \(error)")
                  }
             }, receiveValue: { [weak self] movie in
                 guard let self else { return }
                 
                 self.movie = movie
              })
               .store(in: &cancellables)
        }
    
    func preciseRound(
        _ value: Double) -> String
    {
        return "\(round(value * 10) / 10.0)"
  
    }
}
