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

    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var itemCount: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var table: UITableView!
    
    let viewModel = MenuListViewModel()
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        
        //bind를 사용하면 순환참조 걱정 x RxCocoa 사용해서 간단히 표시
        viewModel.itemCount
            .map{"\($0)"}
            .bind(to: itemCount.rx.text)
            .disposed(by: disposeBag)
        
        
        viewModel.totalPrice
            .scan(0, accumulator: +)
            .map{$0.currencyKR()}
            .bind(to: price.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("")
    }
    
    
    @IBAction func handleOrderButton(_ sender: Any) {
        
     
//        performSegue(withIdentifier: "showOrderViewController", sender: nil)
    }
}

extension MenuViewController:UITableViewDelegate {
    
}

extension MenuViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        let menu = viewModel.menus[indexPath.row]
        cell.menu.text = menu.name
        cell.price.text = "\(menu.price)"
        
        
        return cell
    }
    
    
}

