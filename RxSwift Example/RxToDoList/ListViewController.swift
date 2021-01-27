//
//  ListViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/27.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var segment:UISegmentedControl!
    @IBOutlet weak var table:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func add(_ sender: Any) {
    }
}


extension ListViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        return cell
    }
    
    
}
