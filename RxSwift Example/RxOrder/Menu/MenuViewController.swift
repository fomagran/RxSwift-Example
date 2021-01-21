//
//  MenuViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/21.
//

import UIKit
import RxSwift
import RxCocoa

class MenuViewController: UIViewController {

    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var itemCount: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var table: UITableView!
    
    let viewModel = MenuListViewModel()
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //RxCocoa로 테이블뷰 처리하기
        viewModel.menuObservable
            .bind(to: table.rx.items(cellIdentifier: "MenuTableViewCell", cellType: MenuTableViewCell.self)) {index,item,cell in
                cell.menu.text = item.name
                cell.price.text = "\(item.price)"
            }
            .disposed(by: disposeBag)
    
        
        //bind를 사용하면 순환참조 걱정 x RxCocoa 사용해서 간단히 표시
        viewModel.itemCount
            .map{"\($0)"}
            .observeOn(MainScheduler.instance)
            .bind(to: itemCount.rx.text)
            .disposed(by: disposeBag)
        
        
        viewModel.totalPrice
            .map{$0.currencyKR()}
            .observeOn(MainScheduler.instance)
            .bind(to: price.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("")
    }
    
    
    @IBAction func handleOrderButton(_ sender: Any) {
        
        viewModel.menuObservable.onNext([Menu(name: "fomagrna", price: 100, count: 3),
                                        Menu(name: "fomagrna", price: 100, count: 3),
                                        Menu(name: "fomagrna", price: 100, count: 3)])
        
     
//        performSegue(withIdentifier: "showOrderViewController", sender: nil)
    }
    @IBAction func handleClearButton(_ sender: Any) {
        
        viewModel.clearAllItems()
    }
}
