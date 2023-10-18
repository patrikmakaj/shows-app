//
//  Country.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 17.10.2023..
//

import Foundation

struct Country: Hashable, Codable, Equatable {
    let name: String
    let code: String
    let timezone: String
}
