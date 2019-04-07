//
//  ViewController.swift
//  curquiza2019
//
//  Created by Clementine Urquizar on 04/01/2019.
//  Copyright (c) 2019 Clementine Urquizar. All rights reserved.
//

import UIKit
import curquiza2019

class ViewController: UIViewController {

    let articleManager = ArticleManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Test de la video
//        let article1 = articleManager.newArticle()
//        article1.title = "Article 1"
//        article1.content = "my first article in French"
//        article1.creation_date = Date() as NSDate
//        article1.modif_date = Date() as NSDate
//        article1.language = "fr"
//
//        let article2 = articleManager.newArticle()
//        article2.title = "Article number 2"
//        article2.content = "bla bla bla bla bla bla bla bla bla bla bla"
//        article2.creation_date = Date() as NSDate
//        article2.language = "en"
//        articleManager.save() // /!\ save les changements
//        print("\n", articleManager.getAllArticles(), "\n")
//
//        let article3 = articleManager.newArticle()
//        article3.title = "NUMBER 3"
//
//        print("\n", articleManager.getAllArticles(), "\n")
        
        // Mes tests
        let article1 = articleManager.newArticle()
        article1.title = "Article 1"
        article1.language = "fr"
        article1.content = "toto et titi"
        article1.creation_date = Date() as NSDate
        article1.modif_date = Date() as NSDate

        let article2 = articleManager.newArticle()
        article2.title = "Article 2 titi"
        article2.language = "fr"
        article2.content = "coco"

        let article3 = articleManager.newArticle()
        article3.title = "Article 3"
        article3.language = "en"

        articleManager.save()

        print("\n", articleManager.getAllArticles(), "\n")
        print("\nTest getArticles containStr:\n", articleManager.getArticles(containString: "titi"), "\n")
        print("\nTest getArticles containStr:\n", articleManager.getArticles(withLang: "en"), "\n")

        articleManager.removeArticle(article: article1)

        articleManager.save()

        print("\n", articleManager.getAllArticles(), "\n")
        
        // Verifier la persistance (commenter partie précedent et run de nouveau)
//        print("\n", articleManager.getAllArticles(), "\n")
        
    }

}

