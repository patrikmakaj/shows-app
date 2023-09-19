//
//  NetworkConfiguration.swift
//  SimpleNetworkingApp_SwiftUI
//
//  Created by Saša Brezovac on 13.09.2023..
//

import Foundation


struct NetworkConfiguration {
    let baseUrl: String
    let staticHeaders: [String: String]? = nil
    let authorizationHeaders: [String: String]? = nil
}

enum HTTPMethod: String {
    case get = "get"
    case post = "post"
}

enum RequestType: String {
    case json = "Application/json; charset=utf-8"
    case query = "Application/x-www-form-urlencoded; charset=utf-8"
}

struct Request {
    let path: String
    let method: HTTPMethod
    let type: RequestType
    let parameters: [String: Any]?
    let query: String?
}

enum ErrorHandler: Error {
    case cannotParse
    case notfound
    case other(Int)
    
    init(code: Int) {
        switch code {
        case 404: self = .notfound
        default: self = .other(code)
        }
    }
}
