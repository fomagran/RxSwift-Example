//
//  ListViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/27.
//

import UIKit
import RxSwift

class ListViewController: UIViewController {
    
    @IBOutlet weak var segment:UISegmentedControl!
    @IBOutlet weak var table:UITableView!
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nav = segue.destination as? UINavigationController,let addVC = nav.viewControllers.first  as? AddListViewController  else { fatalError()}
        
        addVC.taskSubjectObservable
            .subscribe(onNext:{
                print($0)
            })
            .disposed(by: disposeBag)
        
            
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
