//
//  AddListViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/27.
//

import UIKit
import RxSwift

class AddListViewController: UIViewController {
    
    
    private let task = PublishSubject<Task>()
    lazy var taskObservable = task.asObservable()

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func save(_ sender: Any) {
        let priority = Priority(rawValue:segment.selectedSegmentIndex)
        let title = textField.text
        task.onNext(Task(title: title ?? "", priority: priority!))
        self.dismiss(animated: true, completion: nil)
    }


}
