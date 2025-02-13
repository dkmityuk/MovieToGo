//
//  RootViewModel.swift
//  MovieToGo
//
//  Created by Dmytro Kmytiuk on 11.02.2025.
//

import Combine
import SwiftUI
import Dependencies

final class RootViewModel: ObservableObject {
    func constructListViewModel(listType: ListType) -> ListViewModel {
        ListViewModel(listType: listType)
    }
}
