//
//  Show.swift
//  SimpleNetworkingApp_SwiftUI
//
//  Created by Saša Brezovac on 13.09.2023..
//

import Foundation

struct Show: Identifiable, Codable {
    let id: Int
    let url: String
    let name: String
    let image: Cover
    let language: String
    let genres: [String]
}

struct Cover: Codable {
    let original: String
}
