//
//  NetworkingService.swift
//  SimpleNetworkingApp_SwiftUI
//
//  Created by Saša Brezovac on 13.09.2023..
//

import Foundation

protocol NetworkingServiceProtocol {
    func fetchDataGenerics<T: Codable>(of type: T.Type, with request: Request, completion: @escaping (Result<T, ErrorHandler>) -> Void) where T: Codable
    func fetchSearchedShows(query: String, completion: @escaping (Result<[SearchResponse], ErrorHandler>) -> Void)
    func fetchCast(id: Int, completion: @escaping (Result<[Cast], ErrorHandler>) -> Void)
    func fetchSchedule(completion: @escaping (Result<[SearchResponse], ErrorHandler>) -> Void)
}

final class NetworkingService: ObservableObject, NetworkingServiceProtocol {
    
    func fetchDataGenerics<T>(of type: T.Type, with request: Request, completion: @escaping (Result<T, ErrorHandler>) -> Void) where T : Decodable, T : Encodable {
        guard let urlRequest =  configureRequest(request) else { return }
        let urlSession: URLSession = URLSession.shared
        
        // Create a data task
        
        //Removed weak self in [weak self] data, response, error in because of an error
        urlSession.dataTask(with: urlRequest) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            // Check for a successful HTTP response (status code 200)
            if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 {
                if let data = data {
                    // Parse the data
                    do {
                        let json = try JSONDecoder().decode(T.self, from: data)
//                        print(json)
                        completion(.success(json))
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
                completion(.failure(.notfound))
            }
        }
        .resume()
    }
    
    func fetchSearchedShows(query: String, completion: @escaping (Result<[SearchResponse], ErrorHandler>) -> Void) {
        let request = Request(
            path: "/search/shows?q=",
            method: .get,
            type: .json,
            parameters: nil,
            query: query)
        
        fetchDataGenerics(of: [SearchResponse].self, with: request) { result in
            switch result {
            case .success(let succ):
                completion(.success(succ))
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
    func fetchCast(id: Int, completion: @escaping (Result<[Cast], ErrorHandler>) -> Void) {
        let request = Request(
            path: "/shows/\(id)/cast",
            method: .get,
            type: .json,
            parameters: nil,
            query: nil)
        
        fetchDataGenerics(of: [Cast].self, with: request) { result in
            switch result {
            case .success(let cast):
                completion(.success(cast))
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
    func fetchSchedule(completion: @escaping (Result<[SearchResponse], ErrorHandler>) -> Void) {
        let currentDate = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: currentDate)
        let request = Request(
            path: "/schedule?country=US&date="+formattedDate,
            method: .get,
            type: .json,
            parameters: nil,
            query: nil)
        
        fetchDataGenerics(of: [SearchResponse].self, with: request) { result in
            switch result {
            case .success(let succ):
                completion(.success(succ))
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
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
