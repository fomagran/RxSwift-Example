//
//  ListViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/27.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {
    
    @IBOutlet weak var segment:UISegmentedControl!
    @IBOutlet weak var table:UITableView!
    
    let disposeBag = DisposeBag()
    var tasks = BehaviorRelay<[Task]>(value: [])
    var filteredTasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nav = segue.destination as? UINavigationController
        let addVC = nav?.viewControllers.first as? AddListViewController
        
        addVC?.taskObservable
            .subscribe(onNext: { [unowned self] task in
                let priority = Priority(rawValue: self.segment.selectedSegmentIndex-1)
                var value = self.tasks.value
                value.append(task)
                tasks.accept(value)
                self.filteredTask(priority: priority)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateTableView()  {
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    private func filteredTask(priority:Priority?) {
        if priority == nil {
            filteredTasks = tasks.value
        }else{
            tasks.map{
                $0.filter{$0.priority == priority}
            }.subscribe{ [unowned self] tasks in self.filteredTasks = tasks }
            .disposed(by: disposeBag)
        }
        updateTableView()
    }
    
    //segment로 필터링하기
    @IBAction func priorityValueChanged(segmentedControl:UISegmentedControl)  {
        filteredTask(priority: Priority(rawValue: segmentedControl.selectedSegmentIndex-1))
    }
    

}


extension ListViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        cell.label.text = filteredTasks[indexPath.row].title
        return cell
    }
}
