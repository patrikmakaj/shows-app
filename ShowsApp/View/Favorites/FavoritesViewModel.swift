//
//  FavoritesViewModel.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 28.09.2023..
//

import Foundation

final class FavoritesViewModel: ObservableObject {
    @Published var favorites = [Show]()
    @Published var isFavorite: Bool
    var onShowTapped: ((Show) -> Void)?
    let favoritesService: FavoriteServiceProtocol
    init(favoritesService: FavoriteServiceProtocol) {
        self.favoritesService = favoritesService
        favorites = favoritesService.favorites
        isFavorite = false
    }
    
    func refresh() {
        favorites = favoritesService.favorites
    }
    func toggleFavorites(show: Show) {
        isFavorite = favoritesService.toggleFavorite(show: show).isAdded
    }
}
