//
//  ListViewModel.swift
//  MovieToGo
//
//  Created by Dmytro Kmytiuk on 11.02.2025.
//

import Combine
import SwiftUI
import Dependencies

final class ListViewModel: ObservableObject {
    
    @Dependency(\.networkProvider) var networkProvider
    @Published var movies: [Movie] = []
    @Published var currentPage: Int = 1
    let listType: ListType
    private var cancellables = Set<AnyCancellable>()
    
    init(listType: ListType) {
        self.listType = listType
    }
    
    func constructDetailViewModel(id: Int) -> DetailViewModel {
        DetailViewModel(id: id)
    }

    func loadMovies() {
        networkProvider.fetchMoviesList(listType.path, currentPage)
            .sink(receiveCompletion: { completion in
              if case .failure(let error) = completion {
                   print("Error loading movies: \(error)")
              }
         }, receiveValue: { [weak self] movies in
             guard let self else { return }
             
             self.movies.append(contentsOf: movies)
          })
           .store(in: &cancellables)
    }
}
