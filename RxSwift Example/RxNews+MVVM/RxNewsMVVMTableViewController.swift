//
//  RxNewsMVVMTableViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/02/01.
//

import UIKit

import UIKit
import RxSwift
import RxCocoa

class RxNewsMVVMTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    
    var articles = [ArticleModel]()

    private var viewModel:ArticleViewModel!
    private var articleListViewModel:ArticleListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        populateNews()
    }

    private func populateNews() {
        
        let resource = Resource<ArticleListModel>(url:URL(string: TOP_HEADLINE_URL)!)
        
        URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ articleList in
                self.articles = articleList.articles
                self.articleListViewModel = ArticleListViewModel(articleList.articles)
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        
    }



    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return articleListViewModel == nil ? 0 : articleListViewModel.viewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as! ArticleTableViewCell
        
        let articleViewModel = articleListViewModel.viewModels[indexPath.row]
    
        articleViewModel.title.asDriver(onErrorJustReturn: "")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        articleViewModel.description.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)

        return cell
    }



}
