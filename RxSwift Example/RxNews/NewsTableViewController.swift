//
//  NewsTableViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/27.
//

import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
   
    }
    
    private func populateNews() {
        let url = URL(string: TOP_HEADLINE_URL)
        
        Observable.just(url)
            .flatMap{
                let request = URLRequest(url: $0)
                return URLSession.shared.rx.data(request: request)
            }.map{data -> [Article]? in
                return try? JSONDecoder().decode(ArticleList.self, from: data).articles
            }.subscribe(onNext:{
                if let articles = articles {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
      
    }
    
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 0
    }

  

}
