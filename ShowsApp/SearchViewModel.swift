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
}

extension SearchViewModel {
    func fetchData(searchWord: String) {
        let request = Request(
            path: "/search/shows?q="+searchWord,
            method: .get,   
            type: .json,
            parameters: nil,
            query: nil)
        
        networkingService.fetch(with: request) { [weak self] result in
            switch result {
            case .success(let show):
                print("SUCCESS for \(searchWord): \(show)")
                DispatchQueue.main.async {
                    self?.shows = show
                }
                
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
}

