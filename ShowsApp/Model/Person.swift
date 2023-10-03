//
//  Person.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 21.09.2023..
//

import Foundation

struct Person: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let image: Cover
}
