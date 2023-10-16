//
//  CastCoordinator.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 16.10.2023..
//

import Foundation
import UIKit
import SwiftUI

final class CastCoordinator: Coordinator {
    private var navigationController: BaseNavigationController = BaseNavigationController()

    
    func start() -> UIViewController {
        return createCastController(cast: [:])
    }

    var tabBarItem: UITabBarItem {
        UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), selectedImage: UIImage(systemName: "house.fill"))
    }
    
    private func createCastController(cast: [Int: (Person, Character?)]) -> UIViewController {
        let vm = CastViewModel(cast: cast)
        let castView = CastView(viewModel: vm)
        let vc = UIHostingController(rootView: castView)
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
}
