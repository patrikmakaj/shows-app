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
    let country: Country
    let birthday: String?
    let gender: String
    var countryUrl: URL {
        URL(string: "https://flagsapi.com/" + country.code + "/shiny/64.png")!
    }
}
