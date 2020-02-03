//
//  NewsApi.swift
//  NewsAddict
//
//  Created by Blazej SLEBODA on 31/01/2020.
//  Copyright © 2020 Blazej SLEBODA. All rights reserved.
//

import Foundation

public class NewsApi {
    
    let apiKey: String
    
    public let baseUrl = URL(string: "https://newsapi.org/v2")!
    public let urlSession: URLSession
    
    enum Endpoint: String {
        case
        topHeadlines = "top-headlines",
        everything,
        sources
    }
    
    public enum NewsApiError: Error {
        case urlSession(Error)
        case dataIsNil
        case dataIsEmpty
        case decoder(Error)
    }
    
    public init(apiKey: String) {
        self.apiKey = apiKey
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["X-Api-Key":apiKey]
        urlSession = URLSession(configuration: configuration)
    }
    
    private func endpoint(for endpoint: Endpoint, _ urlParams: [String:String]) -> URL {
        var url = baseUrl
        url.appendPathComponent(endpoint.rawValue)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = urlParams.map { URLQueryItem(name: $0.key, value: $0.value)}
        debugPrint(
            "NewsApi: endpoint: \(endpoint.rawValue)",
            "NewsApi: endpoint absoluteString: " + (urlComponents.url?.absoluteString ?? "is nil"),
            separator: "\n")
        return urlComponents.url!
    }
        
    public func getRequestTopHeadlines(urlParams: [String: String], callback: @escaping (Result<TopHeadlinesResponseObject, NewsApiError>) -> Void) {
        
        let url = self.endpoint(for: .topHeadlines, urlParams)
        
        urlSession.dataTask(with: url) { (data, response, error) in
            debugPrint("NewsApi: \(response.debugDescription)")
            guard error == nil else {
                callback(.failure(.urlSession(error!)))
                return
            }
            
            guard let data = data else {
                callback(.failure(.dataIsNil))
                return
            }

            guard data.isEmpty == false else {
                callback(.failure(.dataIsEmpty))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(TopHeadlinesResponseObject.self, from: data)
                callback(.success(response))
            } catch {
                callback(.failure(.decoder(error)))
            }
            
        }.resume()
    }
    
    public func getRequestEverything(urlParams: [String: String], callback: @escaping (Result<EverythingResponseObject, NewsApiError>) -> Void) {
        
        let url = endpoint(for: .everything, urlParams)
        
        urlSession.dataTask(with: url ) { (data, response, error) in
            debugPrint("NewsApi: \(response.debugDescription)")
            guard error == nil else {
                callback(.failure(.urlSession(error!)))
                return
            }
            
            guard let data = data else {
                callback(.failure(.dataIsNil))
                return
            }

            guard data.isEmpty == false else {
                callback(.failure(.dataIsEmpty))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(EverythingResponseObject.self, from: data)
                callback(.success(response))
            } catch {
                callback(.failure(.decoder(error)))
            }
            
        }.resume()
    }
    
    public func getRequestSources(urlParams: [String:String], callback: @escaping (Result<SourcesResponseObject, NewsApiError>) -> Void) {
        
        let url = endpoint(for: .sources, urlParams)
        
        urlSession.dataTask(with: url) { (data, response, error) in
            debugPrint("NewsApi: \(response.debugDescription)")
            guard error == nil else {
                callback(.failure(.urlSession(error!)))
                return
            }
            
            guard let data = data else {
                callback(.failure(.dataIsNil))
                return
            }

            guard data.isEmpty == false else {
                callback(.failure(.dataIsEmpty))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(SourcesResponseObject.self, from: data)
                callback(.success(response))
            } catch {
                callback(.failure(.decoder(error)))
            }
            
        }.resume()
    }
    
}
