//
//  Double+Extension.swift
//  MovieToGo
//
//  Created by Dmytro Kmytiuk on 13.02.2025.
//

import Foundation

extension Double {
    func roundedString() -> String {
        let roundedValue = (self * 10).rounded() / 10
        if roundedValue.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", roundedValue)
        } else {
            return String(format: "%.1f", roundedValue)
        }
    }
}
