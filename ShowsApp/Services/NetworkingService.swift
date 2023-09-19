//
//  NetworkingService.swift
//  SimpleNetworkingApp_SwiftUI
//
//  Created by Saša Brezovac on 13.09.2023..
//

import Foundation

protocol NetworkingServiceProtocol {
    func fetch(with request: Request, completion: @escaping (Result<[Show], ErrorHandler>) -> Void)
}

final class NetworkingService: ObservableObject, NetworkingServiceProtocol {
    func fetch(with request: Request, completion: @escaping (Result<[Show], ErrorHandler>) -> Void) {
        guard let urlRequest =  configureRequest(request) else { return }
        let urlSession: URLSession = URLSession.shared
        
        // Create a data task
        urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            // Check for a successful HTTP response (status code 200)
            if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 {
                if let data = data {
                    // Parse the data
                    do {
                        let json = try JSONDecoder().decode([SearchResponse].self, from: data)
                        let shows: [Show] = json.map { $0.show }
                        print(json)
                        completion(.success(shows))
                    }
                    catch {
                        print("Error: \(error)")
                        completion(.failure(.cannotParse))
                        return
                    }
                }
            }
            else {
                print("Error: \(httpResponse.statusCode)")
                completion(.failure(.notfound))
            }
        }
        .resume()
    }
}

extension NetworkingService {
    func configureRequest(_ request: Request) -> URLRequest? {
        let configuration: NetworkConfiguration = NetworkConfiguration(baseUrl: "https://api.tvmaze.com")
        let urlString = configuration.baseUrl + request.path
        
        guard let url = URL(string: urlString) else {
            print("Error creating request URL with: \(urlString)")
            return nil
        }
        
        print("SUCCESSFUL URL: \(urlString)")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.setValue(request.type.rawValue, forHTTPHeaderField: "Content-Type")
        
///Headers
        if let headers = configuration.staticHeaders {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
///Auth header
        if let authorization = configuration.authorizationHeaders {
            for (key, value) in authorization {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
///Parameters & query
        if let parameters = request.parameters {
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
                urlRequest.httpBody = jsonData
            }
        }

        if let query = request.query {
            urlRequest.url = URL(string: urlString.appending(query))
        }
        
        return urlRequest
    }
}
