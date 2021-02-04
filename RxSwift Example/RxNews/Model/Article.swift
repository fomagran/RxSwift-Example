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
}


