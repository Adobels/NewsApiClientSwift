//
//  NewsApi.swift
//  NewsAddict
//
//  Created by Blazej SLEBODA on 31/01/2020.
//  Copyright © 2020 Blazej SLEBODA. All rights reserved.
//

import Foundation

public class NewsApi {
    
    public let apiKey: String
    
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
        configuration.httpAdditionalHeaders = ["x-api-key":apiKey]
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
        
    func getRequest<T: Decodable>(url: URL, callback: @escaping (Result<T,NewsApiError>) -> Void ) {
        urlSession.dataTask(with: url) { (data, response, error) in
            debugPrint("NewsApi: \(response.debugDescription)")
            guard error == nil else {
                DispatchQueue.main.async {
                    callback(.failure(.urlSession(error!)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    callback(.failure(.dataIsNil))
                }
                return
            }

            guard data.isEmpty == false else {
                DispatchQueue.main.async {
                    callback(.failure(.dataIsEmpty))
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    callback(.success(response))
                }
            } catch {
                DispatchQueue.main.async {
                    callback(.failure(.decoder(error)))
                }
            }
            
        }.resume()
    }
    
    public func getRequestTopHeadlines(urlParams: [String: String], callback: @escaping (Result<TopHeadlinesResponseObject, NewsApiError>) -> Void) {
        
        let url = self.endpoint(for: .topHeadlines, urlParams)
        getRequest(url: url, callback: callback)

    }
    
    public func getRequestEverything(urlParams: [String: String], callback: @escaping (Result<EverythingResponseObject, NewsApiError>) -> Void) {
        
        let url = endpoint(for: .everything, urlParams)
        getRequest(url: url, callback: callback)
    }
    
    public func getRequestSources(urlParams: [String:String], callback: @escaping (Result<SourcesResponseObject, NewsApiError>) -> Void) {
        
        let url = endpoint(for: .sources, urlParams)
        getRequest(url: url, callback: callback)
    }
    
}
