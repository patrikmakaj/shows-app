//
//  DetailViewModel.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 02.10.2023..
//

import Foundation

import Foundation
import SwiftUI

final class DetailViewModel: ObservableObject {
    let show: Show
    init(show: Show) {
        self.show = show
    }
}
