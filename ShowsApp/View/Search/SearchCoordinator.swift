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
    
    private func createSearchController() -> UIViewController {
        let vm = SearchViewModel()
        let searchView = SearchView(viewModel: vm)
        let vc = UIHostingController(rootView: searchView)
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
}
