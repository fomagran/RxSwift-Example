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
                cell.onChange = { [weak self] increase in
                    self?.viewModel.changeCount(item: item, increase: increase)
                   
                }
            }
            .disposed(by: disposeBag)
        
        //UI를 에러났을때 끊어지지 않게 하는것 drive를 사용하면 자동으로 메인쓰레드에서 돌아가게 된다.
        viewModel.itemCount
            .map{"\($0)"}
            .asDriver(onErrorJustReturn: "")
            .drive(itemCount.rx.text)
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
        
     
//        performSegue(withIdentifier: "showOrderViewController", sender: nil)
    }
    @IBAction func handleClearButton(_ sender: Any) {
        viewModel.clearAllItems()
    }
}
