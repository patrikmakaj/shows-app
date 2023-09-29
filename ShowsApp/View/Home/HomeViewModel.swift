//
//  HomeViewModel.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 27.09.2023..
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    @ObservedObject var networkingService = NetworkingService()
    @Published var shows = [Show]()
}

extension HomeViewModel {
    func fetchSearchData(query: String) {
        networkingService.fetchSearchedShows(query: query) { [weak self] result in
            switch result {
            case .success(let searchShows):
                DispatchQueue.main.async {
                    let shows = searchShows.map { $0.show }
                    self?.shows = shows
                }
                print("SUCCESS: \(String(describing: self?.shows))")
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
}
