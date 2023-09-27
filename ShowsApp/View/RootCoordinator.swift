//
//  RootCoordinator.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 27.09.2023..
//

import Foundation
import UIKit
import SwiftUI

final class BaseNavigationController: UINavigationController {}

final class RootCoordinator: Coordinator, ObservableObject {
    let homeTabCoordinator = HomeCoordinator()
    let searchTabCoordinator = SearchCoordinator()
    
    func start() -> UIViewController {
        return createTabBarController()
    }
    
    func createTabBarController() -> UIViewController {
        let tabBarController = UITabBarController()

        let homeVC = homeTabCoordinator.start()
        let searchVC = searchTabCoordinator.start()
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), selectedImage: UIImage(systemName: "house.fill"))
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
    
        tabBarController.viewControllers = [homeVC, searchVC]
        tabBarController.selectedIndex = 0
        
        return tabBarController
    }
}
