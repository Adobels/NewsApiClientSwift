//
//  TopHeadlinesResponseObject.swift
//  NewsAddict
//
//  Created by Blazej SLEBODA on 01/02/2020.
//  Copyright © 2020 Blazej SLEBODA. All rights reserved.
//

import Foundation

public struct TopHeadlinesResponseObject: Decodable {
    public let status: String
    public let totalResults: Int
    public let articles: [Article]
}
