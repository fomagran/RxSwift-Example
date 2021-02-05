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
    let disposeBag = DisposeBag()
    var articles = [Article]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        URLRequest.load(resource: ArticleList.all)
//            .subscribe(onNext:{ [weak self]
//                
//                articleList in
//                if let articleList = articleList?.articles {
//                    self?.articles = articleList
//                    self?.tableViewUpdate()
//                }
//            }).disposed(by: disposeBag)
        
    }
    
    private func tableViewUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as! ArticleTableViewCell
        
        cell.titleLabel.text = articles[indexPath.row].title
        cell.descriptionLabel.text = articles[indexPath.row].description
        
        return cell
    }

  

}
