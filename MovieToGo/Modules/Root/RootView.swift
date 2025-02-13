//
//  RootView.swift
//  MovieVerse
//
//  Created by Dmytro Kmytiuk on 07.02.2025.
//

import SwiftUI

enum ListType {
    case popular
    case topRated
    
    var path: String {
        switch self {
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        }
    }
}

struct RootView: View {
    @StateObject var viewModel: RootViewModel
    @State private var selectedTab: Int = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                ListView(viewModel: viewModel.constructListViewModel(listType: .popular))
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)
                
                ListView(viewModel: viewModel.constructListViewModel(listType: .topRated))
                    .tabItem {
                        Label("Favourite", systemImage: "star")
                    }
                    .tag(1)
            }
            .tint(.accentOrange)
            .truncationMode(.middle)
        }
    }
}
