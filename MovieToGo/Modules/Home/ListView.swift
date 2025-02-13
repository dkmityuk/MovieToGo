//
//  ListView.swift
//  MovieToGo
//
//  Created by Dmytro Kmytiuk on 08.02.2025.
//

import SwiftUI
import Kingfisher

struct ListView: View {

    @StateObject var viewModel: ListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                
                if !viewModel.movies.isEmpty {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.movies, id: \.id) { movie in
                                NavigationLink(destination: DetailView(viewModel: viewModel.constructDetailViewModel(id: movie.id))) {
                                    constructMovieCell(model: movie)
                                }
                                .id(movie.id)
                                .onAppear {
                                    if let lastItem = viewModel.movies.last, movie.id == lastItem.id {
                                        viewModel.currentPage += 1
                                        viewModel.loadMovies()
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                    .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
                } else {
                    Button {
                        viewModel.loadMovies()
                    } label: {
                        Text("Something went wrong. Please try again")
                            .font(.title)
                            .foregroundColor(.accentOrange)
                    }
                }
            }
            .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
            .onAppear {
                viewModel.loadMovies()
            }
            .navigationBarHidden(true)
        }
    }
}

private extension ListView {
    func constructMovieCell(model: Movie) -> some View {
        HStack(alignment: .top) {
            KFImage(.tmdbImage(path: model.poster_path))
                .resizable()
                .frame(width: 128, height: 188)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.mainTitleFont)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                
                Text(model.overview)
                    .font(.mainOverviewFont)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.mainGray)
                    .padding(.top)
                
                Text("Release: \(model.release_date)")
                    .font(.mainDateFont)
                    .foregroundColor(.accentOrange)
                    .padding(.top)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
