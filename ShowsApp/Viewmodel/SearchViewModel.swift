//
//  SearchViewModel.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 19.09.2023..
//

import Foundation
import SwiftUI

final class SearchViewModel: ObservableObject {
    @ObservedObject var networkingService = NetworkingService()
    @Published var shows = [Show]()
    @Published var cast: [Int: [Person]] = [:]
    @Published var searchWord = ""
}

extension SearchViewModel{
    func fetchSearchData(query: String) {
        networkingService.fetchSearchedShows(query: query) { [weak self] result in
            switch result {
            case .success(let searchShows):
                DispatchQueue.main.async {
                    let shows = searchShows.map { $0.show }
                    for show in shows {
                        self?.fetchCast(id: show.id)
                    }
                    self?.shows = shows
                }
                print("SUCCESS: \(String(describing: self?.shows))")
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
    func fetchCast(id: Int) {
        networkingService.fetchCast(id: id){ [weak self] result in
            switch result {
            case .success(let showCast):
                DispatchQueue.main.async {
                    self?.cast[id] = showCast.map { $0.person }
                }
                print("SUCCESS: \(String(describing: showCast))")
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
}
