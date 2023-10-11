//
//  FavoriteService.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 09.10.2023..
//


import Foundation
import Combine


protocol FavoriteServiceProtocol {
    var favorites: [Show] { get }
    
    func isfavorite(show: Show) -> Bool
    func addToFavorites(show: Show) -> AddToFavoritesResult
    func removeFromFavorites(show: Show) -> RemoveFromFavoritesResult
    func toggleFavorite(show: Show) -> ToggleFavoritesResult
}

enum AddToFavoritesResult {
    case added
    case alreadyAdded
}

enum RemoveFromFavoritesResult {
    case removed
    case notInFavorites
}

enum ToggleFavoritesResult {
    case added
    case removed
    var isAdded: Bool {
        switch self {
        case .added:
            return true
        case .removed:
            return false
        }
    }
}

class FavoriteService: FavoriteServiceProtocol, ObservableObject {
    @Published private(set) var favorites: [Show] = []

    private var persistenceService: FavoritesPersistenceServiceProtocol

    init(persistenceService: FavoritesPersistenceServiceProtocol) {
        self.persistenceService = persistenceService
        favorites = persistenceService.favoriteShows
    }

    
    func isfavorite(show: Show) -> Bool {
        return favorites.contains(show)
    }
    
    func addToFavorites(show: Show) -> AddToFavoritesResult {
        guard !isfavorite(show: show) else {
            return .alreadyAdded
        }
        favorites.append(show)
        updateFavorites()
        return .added
    }

    func removeFromFavorites(show: Show) -> RemoveFromFavoritesResult {
        guard let index = favorites.firstIndex(of: show) else {
            return .notInFavorites
        }
        favorites.remove(at: index)
        updateFavorites()
        return .removed
    }

    private func updateFavorites() {
        persistenceService.favoriteShows = favorites
    }
    
    func toggleFavorite(show: Show) -> ToggleFavoritesResult {
        if isfavorite(show: show) {
            _ = removeFromFavorites(show: show)
            return ToggleFavoritesResult.removed
        }
        _ = addToFavorites(show: show)
        return ToggleFavoritesResult.added
    }
}


class FavoriteServiceMock: FavoriteServiceProtocol {
    var favorites: [Show] {
        [Show.example]
    }
    func isfavorite(show: Show) -> Bool {
        return true
    }
    func addToFavorites(show: Show) -> AddToFavoritesResult {
        .added
    }
    
    func removeFromFavorites(show: Show) -> RemoveFromFavoritesResult {
        .removed
    }
    
    func toggleFavorite(show: Show) -> ToggleFavoritesResult {
        .removed
    }
}
