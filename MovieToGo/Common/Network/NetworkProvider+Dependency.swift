//
//  NetworkProvider+Dependency.swift
//  MovieToGo
//
//  Created by Dmytro Kmytiuk on 13.02.2025.
//

import Dependencies

extension DependencyValues {
    var networkProvider: NetworkProvider {
        get { self[NetworkProvider.self] }
        set { self[NetworkProvider.self] = newValue }
    }
}
