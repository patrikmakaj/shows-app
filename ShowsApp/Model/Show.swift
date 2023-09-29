//
//  Show.swift
//  SimpleNetworkingApp_SwiftUI
//
//  Created by Saša Brezovac on 13.09.2023..
//

import Foundation
import SwiftUI

struct Show: Identifiable, Codable {
    let id: Int
    let url: String
    let name: String
    let image: Cover
    let language: String
    let genres: [String]
    let premiered: String?
    let rating: Rating
    
    static let example = Show(id: 1, url: "Unknown", name: "Game of thrones", image: Cover(original: "https://seeklogo.com/images/G/game-of-thrones-logo-3A574D3ECB-seeklogo.com.png"), language: "EN", genres: ["Fantasy"], premiered: "2011-08-08", rating: Rating(average: 6.5))

    
    var premiereYear: String {
        if premiered == nil { return "" }
        let date = parseDate(premiered!)!
        return formatDateYear(date)
    }
    
    var ratingString: String {
        if let unwrappedRating = rating.average {
            return String(unwrappedRating)
        }
        else {
            return "Unknown rating"
        }
    }
    
    func parseDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)
    }
    
    func formatDateYear(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
}
