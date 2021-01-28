//
//  Article.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/28.
//

import Foundation

struct ArticlesList:Decodable {
    let articles:[Article]
}

extension ArticlesList {
    static var all:Resource<ArticlesList> = {
       let url = URL(string: TOP_HEADLINE_URL)!
        return Resource(url: url)
    }()
}

//뉴스 중에 타이틀만 있고 description이 없는 경우가 있다 그러므로 옵셔널로 선언해주어야한다.
struct Article:Decodable{
    let title:String
    let description:String?
}
