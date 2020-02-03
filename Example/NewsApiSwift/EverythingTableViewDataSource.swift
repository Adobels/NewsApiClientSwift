//
//  EverythingTableViewDataSource.swift
//  NewsApiSwift_Example
//
//  Created by Blazej SLEBODA on 02/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import NewsApiSwift

class EverythingTableViewDataSource: NSObject, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView? {
        didSet {
            search(for: "macOS")
        }
    }
    
    var dataSource: EverythingResponseObject? {
        didSet {
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    
    func search(for query: String) {
        typealias Key = EverythingUrlParamsKey
        let params = [Key.q.rawValue: query]
        
        newsApi.getRequestEverything(urlParams: params) { result in
            switch result {
            case .success(let result):
                self.dataSource = result
            case .failure(_):
                self.dataSource = nil
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.detailTextLabel?.numberOfLines = 0
        if let dataSource = dataSource?.articles[indexPath.row] {
            cell.textLabel?.text = dataSource.title
            cell.detailTextLabel?.text = dataSource.content
        }
        return cell
    }
}

