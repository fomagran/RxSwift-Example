//
//  File.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/02/01.
//

import Foundation

struct ArticlesListModel:Decodable {
    let articles:[ArticleModel]
}

extension ArticlesListModel {
    static var all:Resource<ArticlesListModel> = {
       let url = URL(string: TOP_HEADLINE_URL)!
        return Resource(url: url)
    }()
}

//뉴스 중에 타이틀만 있고 description이 없는 경우가 있다 그러므로 옵셔널로 선언해주어야한다.
struct ArticleModel:Decodable{
    let title:String
    let description:String?
}
