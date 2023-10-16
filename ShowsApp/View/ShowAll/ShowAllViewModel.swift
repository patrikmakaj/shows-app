//
//  ShowAllViewModel.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 12.10.2023..
//

import Foundation

final class ShowAllViewModel: ObservableObject {
    @Published var allShows = [Show]()
    @Published var isFavorite: Bool
    var onShowTapped: ((Show) -> Void)?
    let favoritesService: FavoriteServiceProtocol
    init(allShows: [Show], favoritesService: FavoriteServiceProtocol) {
        self.allShows = allShows
        self.favoritesService = favoritesService
        isFavorite = false
    }
}
