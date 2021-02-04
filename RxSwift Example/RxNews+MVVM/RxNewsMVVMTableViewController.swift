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
    private var articleListViewModel:ArticleListViewModel!


    override func viewDidLoad() {
        super.viewDidLoad()
        populateNews()
    }

    private func populateNews() {

        URLRequest.load(resource: ArticlesListModel.all)
            .subscribe(onNext:{ articleResponse in
                let articles = articleResponse.articles
                self.articleListViewModel = ArticleListViewModel(articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            }).disposed(by: disposeBag)

    }



    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return articleListViewModel == nil ? 0 : self.articleListViewModel.articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as! ArticleTableViewCell

        let aritcleViewModel = self.articleListViewModel.articleAt(indexPath.row)

        aritcleViewModel.title.asDriver(onErrorJustReturn: "")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)

        aritcleViewModel.description.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)


        return cell
    }



}
