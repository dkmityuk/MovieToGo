//
//  MovieToGoApp.swift
//  MovieToGo
//
//  Created by Dmytro Kmytiuk on 08.02.2025.
//

import SwiftUI

@main
struct MovieToGoApp: App {    
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: RootViewModel())
        }
    }
}
