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

    
    private var navigationController: BaseNavigationController = BaseNavigationController()
    
    func start() -> UIViewController {
        return createSearchController()
    }
    
    public var tabBarItem: UITabBarItem {
        let tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.cyan
        ]
        let attributedTitle = NSAttributedString(string: "Search", attributes: attributes)
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.cyan], for: .selected)
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.cyan], for: .normal)
        return tabBarItem
    }
    
    private func createSearchController() -> UIViewController {
        let vm = SearchViewModel()
        let searchView = SearchView(viewModel: vm)
        let vc = UIHostingController(rootView: searchView)
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
}
