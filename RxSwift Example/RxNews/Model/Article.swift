//
//  Article.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/28.
//

import Foundation

struct Article:Codable {
    let title:String
    let description:String?
    

}

struct ArticleList:Codable {
    let articles:[Article]
    
    static var all:Resource<ArticleList> = {
        let url = URL(string: TOP_HEADLINE_URL)!
        return Resource(url: url)
    }()
}


