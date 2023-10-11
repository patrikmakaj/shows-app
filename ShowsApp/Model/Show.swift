//
//  Show.swift
//  SimpleNetworkingApp_SwiftUI
//
//  Created by Saša Brezovac on 13.09.2023..
//

import Foundation
import SwiftUI

struct Show: Identifiable, Codable, Equatable {
    let id: Int
    let url: String
    let name: String
    let image: Cover?
    let language: String?
    let genres: [String]
    let premiered: String?
    let rating: Rating
    let airtime: Date?
    let runtime: Int?
    let averageRuntime: Int?
    let schedule: Schedule
    let summary: String
    
    static func == (lhs: Show, rhs: Show) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    static let example = Show(id: 1, url: "Unknown", name: "Game of thrones", image: Cover(original: "https://seeklogo.com/images/G/game-of-thrones-logo-3A574D3ECB-seeklogo.com.png"), language: "EN", genres: ["Fantasy"], premiered: "2011-08-08", rating: Rating(average: 6.5), airtime: Date.now, runtime: 60, averageRuntime: 45, schedule: Schedule.example, summary: "Summary of the movie")

    
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
            return "Unknown"
        }
    }
    
    var formattedSummary: String {
        return summary.removingHTMLTags
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

extension String {
    var removingHTMLTags: String {
        guard let data = self.data(using: .utf8) else { return self }
        do {
            let attributedString = try NSAttributedString(data: data,
                                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                                          documentAttributes: nil)
            return attributedString.string
        } catch {
            return self
        }
    }
}
