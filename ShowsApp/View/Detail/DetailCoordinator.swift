//
//  DetailCoordinator.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 02.10.2023..
//

import Foundation

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
        let vm = DetailViewModel(show: Show.example)
        let detailView = DetailView(viewModel: vm)
        let vc = UIHostingController(rootView: detailView)
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
}