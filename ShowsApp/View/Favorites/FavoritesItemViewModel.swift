//
//  FavoritesItemViewModel.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 12.10.2023..
//

import Foundation
import SwiftUI

class FavoritesItemViewModel: ObservableObject {
    let show: Show
    let favoritesService: FavoriteServiceProtocol

    @Published var isFavorite: Bool
    var onRemoveFavorite: (() -> Void)?

    init(show: Show, favoritesService: FavoriteService) {
        self.show = show
        self.favoritesService = favoritesService
        self.isFavorite = favoritesService.isfavorite(show: show)
    }

    func toggleFavorite() {
        withAnimation {
            _ = favoritesService.toggleFavorite(show: show)
            isFavorite.toggle()
            onRemoveFavorite?()
        }
    }
}
