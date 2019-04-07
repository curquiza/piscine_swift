//
//  ViewController.swift
//  d09
//
//  Created by Clementine URQUIZAR on 4/5/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit
import curquiza2019
import LocalAuthentication

class ArticlesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    let articleManager = ArticleManager()
    var articlesArray: [Article] = []
    
    @IBOutlet weak var articlesTableView: UITableView! {
        didSet {
            articlesTableView.delegate = self
            articlesTableView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // disable back button
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        // get all articles
        articlesArray = articleManager.getAllArticles()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell") as! ArticleTableViewCell
        cell.article = self.articlesArray[indexPath.row]
        return cell

    }

}

