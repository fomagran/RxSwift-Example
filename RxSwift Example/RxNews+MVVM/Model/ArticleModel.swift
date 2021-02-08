//
//  File.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/02/01.
//

import Foundation

struct ArticleListModel:Codable {
    let articles:[ArticleModel]
}

struct ArticleModel:Codable {
    let title:String
    let description:String?
}
