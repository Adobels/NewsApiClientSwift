//
//  AppDelegate.swift
//  NewsApiSwift
//
//  Created by Blazej SLEBODA on 02/02/2020.
//  Copyright (c) 2020 Blazej SLEBODA. All rights reserved.
//

import UIKit
import NewsApiSwift

let newsApi = NewsApi(apiKey: "get_your_apikey_https://newsapi.org")

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

}

