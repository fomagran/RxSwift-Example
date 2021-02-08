//
//  ArticleViewModel.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/02/01.
//

import Foundation
import RxSwift
import RxCocoa


struct ArticleListViewModel {
    
    let viewModels:[ArticleViewModel]
    
    init(_ articles:[ArticleModel]) {
        
        self.viewModels = articles.compactMap(ArticleViewModel.init)
    }
 
}

struct ArticleViewModel {
    
    let article:ArticleModel
    
    init(_ article:ArticleModel) {
        self.article = article
    }
    
    var title:Observable<String> {
        
        return Observable<String>.just(article.title)
    }
    
    var description:Observable<String> {
        return Observable<String>.just(article.description ?? "")
    }
}
