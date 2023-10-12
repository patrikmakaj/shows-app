//
//  RootCoordinator.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 27.09.2023..
//

import Foundation
import UIKit
import SwiftUI

final class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .all
    }
}

final class RootCoordinator: Coordinator, ObservableObject {
    
    let serviceFactory: ServiceFactory
    var childCoordinators: [Coordinator] = []
    
    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
        childCoordinators = [HomeCoordinator(serviceFactory: serviceFactory), SearchCoordinator(serviceFactory: serviceFactory), FavoritesCoordinator(serviceFactory: serviceFactory)]
    }
    
    func start() -> UIViewController {
        return createTabBarController()
    }
    
    var tabBarItem: UITabBarItem {
        UITabBarItem(title: "Root", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
    }
    
    func createTabBarController() -> UIViewController {
        let tabBarController = UITabBarController()
         var viewControllers: [UIViewController] = []
         for coordinator in childCoordinators {
             let coordinatorVC = coordinator.start()
             coordinatorVC.tabBarItem = coordinator.tabBarItem
             viewControllers.append(coordinatorVC)
         }
        tabBarController.viewControllers = viewControllers
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color("PrimaryLightGray"))]
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color("PrimaryLightGray"))
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(Color("PrimaryYellow"))]
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color("PrimaryYellow"))
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.selectedIndex = 0
        return tabBarController
    }
}
