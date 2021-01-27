//
//  AddListViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/27.
//

import UIKit
import RxSwift

class AddListViewController: UIViewController {
    
    private let taskSubject = PublishSubject<Task>()
    var taskSubjectObservable:Observable<Task> {
        return taskSubject.asObservable()
    }

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func save(_ sender: Any) {
        guard let priority = Priority(rawValue: self.segment.selectedSegmentIndex),let title = self.textField.text else { return }
        
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        self.dismiss(animated: true, completion: nil)
    }


}
