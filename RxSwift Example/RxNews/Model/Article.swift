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

//모델을 만들때 타입 뒤에 ?붙여줘야 데이터가 표시된다.
struct Article:Decodable{
    let title:String
    let description:String?
}
