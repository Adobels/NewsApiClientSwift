//
//  Article.swift
//  NewsAddict
//
//  Created by Blazej SLEBODA on 01/02/2020.
//  Copyright © 2020 Blazej SLEBODA. All rights reserved.
//

import Foundation

public struct Article: Decodable {
    public let source: Source
    public let author: String?
    public let title: String
    public let description: String
    public let url: String
    public let urlToImage: String?
    public let publishedAt: String
    public let content: String?
    
    public struct Source: Decodable {
        public let id: String?
        public let name: String
    }
}
