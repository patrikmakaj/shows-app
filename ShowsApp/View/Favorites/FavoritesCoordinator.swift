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
    let serviceFactory: ServiceFactory
    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    func start() -> UIViewController {
        return createFavoritesController()
    }
    
    public var tabBarItem: UITabBarItem {
        UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), selectedImage: UIImage(systemName: "heart.fill"))
    }
    
    private func createFavoritesController() -> UIViewController {
        let vm = FavoritesViewModel(favoritesService: serviceFactory.favoriteService)
        let favoritesView = FavoritesView(viewModel: vm)
        vm.onShowTapped = { [weak self] show in
            _ = self?.createDetailView(show: show)
        }
        let vc = UIHostingController(rootView: favoritesView)
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
    
    private func createDetailView(show: Show) -> UIViewController {
        let vm = DetailViewModel(show: show, favoriteService: serviceFactory.favoriteService)
        let detailView = DetailView(viewModel: vm, favoriteService: serviceFactory.favoriteService)
        let vc = UIHostingController(rootView: detailView)
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
}
