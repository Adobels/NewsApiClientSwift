//
//  EverythingResponseObject.swift
//  NewsAddict
//
//  Created by Blazej SLEBODA on 31/01/2020.
//  Copyright © 2020 Blazej SLEBODA. All rights reserved.
//

import Foundation

public struct EverythingResponseObject: Decodable {
    public let status: String
    public let totalResults: Int
    public let articles: [Article]
}
