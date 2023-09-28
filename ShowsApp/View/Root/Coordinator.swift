//
//  Coordinator.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 27.09.2023..
//

import Foundation

import Foundation
import UIKit
import SwiftUI

protocol Coordinator {
    var tabBarItem: UITabBarItem { get }
    func start() -> UIViewController
}
