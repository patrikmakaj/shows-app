//
//  CastViewModedl.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 16.10.2023..
//

import Foundation

final class CastViewModel: ObservableObject {
    @Published var cast = [Int: (Person, Character?)]()
    init(cast: [Int: (Person, Character?)]) {
        self.cast = cast
    }
}
