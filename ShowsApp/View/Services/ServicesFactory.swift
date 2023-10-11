//
//  ServicesFactory.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 09.10.2023..
//

import Foundation

class ServiceFactory {
    
    lazy var favoriteService: FavoriteServiceProtocol = {
        FavoriteService(persistenceService: persistenceService)
    }()
    
    lazy var persistenceService: FavoritesPersistenceServiceProtocol = {
        PersistenceService()
    }()
 
}
