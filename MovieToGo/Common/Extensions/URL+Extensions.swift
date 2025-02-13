//
//  URL+Extensions.swift
//  MovieToGo
//
//  Created by Dmytro Kmytiuk on 13.02.2025.
//

import Foundation

extension URL {
    static func tmdbImage(path: String?, size: String = "w500") -> URL? {
        guard let path = path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/\(size)\(path)")
    }
}
