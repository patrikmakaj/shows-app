//
//  ShowAllCoordinator.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 12.10.2023..
//

import Foundation
import UIKit
import SwiftUI

final class ShowAllCoordinator: Coordinator {
    private var navigationController: BaseNavigationController = BaseNavigationController()
    let serviceFactory: ServiceFactory

    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    func start() -> UIViewController {
        return createShowAllController(allShows: [Show.example])
    }

    var tabBarItem: UITabBarItem {
        UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), selectedImage: UIImage(systemName: "house.fill"))
    }
    
    private func createShowAllController(allShows: [Show]) -> UIViewController {
        let vm = ShowAllViewModel(allShows: allShows, favoritesService: serviceFactory.favoriteService)
        let showAllView = ShowAllView(viewModel: vm)
        let vc = UIHostingController(rootView: showAllView)
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
