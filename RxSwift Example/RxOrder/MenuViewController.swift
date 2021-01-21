//
//  MenuViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/21.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var itemCount: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var table: UITableView!
    
    let viewModel = MenuListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
}

extension MenuViewController:UITableViewDelegate {
    
}

extension MenuViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        let menu = viewModel.menus[indexPath.row]
        cell.menu.text = menu.name
        cell.price.text = "\(menu.price)"
        
        
        return cell
    }
    
    
}

