//
//  HomeCoordinator.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 27.09.2023..
//

import Foundation
import UIKit
import SwiftUI

final class HomeCoordinator: Coordinator {
    private var navigationController: BaseNavigationController = BaseNavigationController()
    let serviceFactory: ServiceFactory

    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    func start() -> UIViewController {
        return createHomeController()
    }
    
    var tabBarItem: UITabBarItem {
        UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), selectedImage: UIImage(systemName: "house.fill"))
    }
    
    private func createHomeController() -> UIViewController {
        let vm = HomeViewModel(favoritesService: serviceFactory.favoriteService)
        let homeView = HomeView(viewModel: vm)
        let vc = UIHostingController(rootView: homeView)
        vm.onShowTapped = { [weak self] show in
            _ = self?.createDetailView(show: show)
        }
        vm.onShowAllTapped = { [weak self] allShows in
            _ = self?.createShowAllController(allShows: allShows)
        }
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
        
    private func createShowAllController(allShows: [Show]) -> UIViewController {
        let vm = ShowAllViewModel(allShows: allShows, favoritesService: serviceFactory.favoriteService)
        let homeView = ShowAllView(viewModel: vm)
        let vc = UIHostingController(rootView: homeView)
        vm.onShowTapped = { [weak self] show in
            _ = self?.createDetailView(show: show)
        }
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
