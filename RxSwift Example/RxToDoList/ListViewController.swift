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
    private var filteredTasks = [Task]()
    private var tasks = BehaviorRelay<[Task]>(value: [])
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nav = segue.destination as? UINavigationController,let addVC = nav.viewControllers.first  as? AddListViewController  else { fatalError()}
        
        addVC.taskSubjectObservable
            .subscribe(onNext:{ [unowned self] in
                let priority = Priority(rawValue: self.segment.selectedSegmentIndex - 1)
                var existingTasks = self.tasks.value
                existingTasks.append($0)
                self.tasks.accept(existingTasks)
                //All일때는 nil이라서 filterTasks로 필터해줘야함.
                self.filterTasks(by: priority)
            })
            .disposed(by: disposeBag)
        
            
    }
    
    //priority로 필터하기
    private func filterTasks(by priority:Priority?) {
        if priority == nil {
            self.filteredTasks = self.tasks.value
        }else{
            self.tasks
                .map{$0.filter{$0.priority == priority!}}
                .subscribe(onNext:{ [weak self] tasks in
                    self?.filteredTasks = tasks
                })
                .disposed(by: disposeBag)
        }
    }
    
    @IBAction func add(_ sender: Any) {
    }
    
    //segment로 필터링하기
    @IBAction func priorityValueChanged(segmentedControl:UISegmentedControl)  {
        let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }
    

}


extension ListViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        return cell
    }
}
