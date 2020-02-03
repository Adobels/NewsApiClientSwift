//
//  Source.swift
//  NewsAddict
//
//  Created by Blazej SLEBODA on 01/02/2020.
//  Copyright © 2020 Blazej SLEBODA. All rights reserved.
//

import Foundation

public struct Source: Decodable {
    public let id: String
    public let name: String
    public let description: String
    public let url: String
    public let category: String
    public let language: String
    public let country: String
}
