//
//  DetailViewModel.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 02.10.2023..
//

import Foundation
import SwiftUI

final class DetailViewModel: ObservableObject {
    let show: Show
    @ObservedObject var networkingService = NetworkingService()
    @Published var cast: [Int: (Person, Character?)] = [:]
    @Published var isFavorite: Bool
    var onShowAllCast: (([Int: (Person, Character?)]) -> Void)?
    let favoriteService: FavoriteServiceProtocol
    init(show: Show, favoriteService: FavoriteServiceProtocol) {
        self.favoriteService = favoriteService
        self.show = show
        self.isFavorite = favoriteService.isfavorite(show: show)
        fetchCast()
    }
}

extension DetailViewModel {
    private func fetchCast() {
        networkingService.fetchCast(id: show.id) { [weak self] result in
            switch result {
            case .success(let showCast):
                DispatchQueue.main.async {
                    var castDictionary: [Int: (Person, Character?)] = self?.cast ?? [:]
                    for castItem in showCast {
                        castDictionary.updateValue((castItem.person, castItem.character), forKey: castItem.person.id)
                    }
                    self?.cast = castDictionary
                }
                print("SUCCESS: \(String(describing: showCast))")
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
    func toggleFavorites() {
        _ = favoriteService.toggleFavorite(show: show)
    }
    
    func refresh() {
        self.isFavorite = favoriteService.isfavorite(show: show)
    }

}
