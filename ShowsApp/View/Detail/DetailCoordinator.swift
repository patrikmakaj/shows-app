//
//  DetailCoordinator.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 02.10.2023..
//

import Foundation
import UIKit
import SwiftUI

final class DetailCoordinator: Coordinator {
    private var navigationController: BaseNavigationController = BaseNavigationController()
    
    func start() -> UIViewController {
        return createDetailController()
    }
    
    
    var tabBarItem: UITabBarItem {
        UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), selectedImage: UIImage(systemName: "house.fill"))
    }
    
    private func createDetailController() -> UIViewController {
        let vm = DetailViewModel(show: Show.example, favoriteService: FavoriteService(persistenceService: PersistenceService()))
        let detailView = DetailView(viewModel: vm, favoriteService: FavoriteService(persistenceService: PersistenceService()))
        let vc = UIHostingController(rootView: detailView)
        vm.onShowAllCast = { [weak self] allCast in
            _ = self?.createCastController(cast: allCast)
        }
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
    
    private func createCastController(cast: [Int: (Person, Character?)]) -> UIViewController {
        let vm = CastViewModel(cast: cast)
        let castView = CastView(viewModel: vm)
        let vc = UIHostingController(rootView: castView)
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
    
}
