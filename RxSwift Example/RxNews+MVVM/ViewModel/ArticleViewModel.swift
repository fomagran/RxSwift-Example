//
//  ArticleViewModel.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/02/01.
//

import Foundation
import RxSwift
import RxCocoa

//struct ArticleListViewModel  {
//    let articles:[ArticleViewModel]
//    
//}
//
//extension ArticleListViewModel {
//    init(_ articles:[ArticleModel]) {
//        self.articles = articles.compactMap(ArticleViewModel.init)
//    }
//}
//
//extension ArticleListViewModel {
//    func articleAt(_ index:Int) -> ArticleViewModel {
//        return self.articles[index]
//    }
//}
//
//struct ArticleViewModel {
//    
//    let article:ArticleModel
//    
//    init(_ article:ArticleModel) {
//        self.article = article
//    }
//    
//}
//
//extension ArticleViewModel {
//    var title:Observable<String> {
//        return Observable<String>.just(article.title)
//    }
//    
//    var description:Observable<String> {
//        return Observable<String>.just(article.description ?? "")
//    }
//}
