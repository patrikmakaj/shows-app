//
//  Schedule.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 02.10.2023..
//

import Foundation

struct Schedule: Codable {
    let time: String
    let days: [String]
    
    static let example = Schedule(time: "06:00", days: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"])
}
