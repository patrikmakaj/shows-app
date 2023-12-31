//
//  SearchCoordinator.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 27.09.2023..
//

import Foundation
import UIKit
import SwiftUI

final class SearchCoordinator: Coordinator {

    let serviceFactory: ServiceFactory
    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    private var navigationController: BaseNavigationController = BaseNavigationController()
    func start() -> UIViewController {
        return createSearchController()
    }
    
    public var tabBarItem: UITabBarItem {
        let tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.cyan], for: .selected)
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.cyan], for: .normal)
        return tabBarItem
    }
    
    private func createSearchController() -> UIViewController {
        let vm = SearchViewModel()
        let searchView = SearchView(viewModel: vm)
        let vc = UIHostingController(rootView: searchView)
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
