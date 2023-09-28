//
//  FavoritesCoordinator.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 28.09.2023..
//

import Foundation
import UIKit
import SwiftUI

final class FavoritesCoordinator: Coordinator {
    private var navigationController: BaseNavigationController = BaseNavigationController()
    
    func start() -> UIViewController {
        return createFavoritesController()
    }
    
    public var tabBarItem: UITabBarItem {
        UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), selectedImage: UIImage(systemName: "heart.fill"))
    }
    
    private func createFavoritesController() -> UIViewController {
        let vm = FavoritesViewModel()
        let favoritesView = FavoritesView(viewModel: vm)
        let vc = UIHostingController(rootView: favoritesView)
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
}
