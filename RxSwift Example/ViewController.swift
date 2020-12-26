//
//  ViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2020/12/26.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var completed: UILabel!
    @IBOutlet weak var number: UILabel!
    
    var count = 0.0
    
    var timer:Timer?
    var disposable:Disposable?

    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        isCompletedCount()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        count += 0.1
        number.text = String(format: "%.1f",  count) + String("초가 걸렸어요")
    }
    
    @IBAction func stop(_ sender: Any) {
        disposable?.dispose()
        timer?.invalidate()
        completed.text = "취소되었습니다."
    }
    
    func isCompletedCount() {
        disposable = rxCountNumber()
            .observeOn(MainScheduler.instance)
            .subscribe({[weak self] _ in
                self?.completed.text = "Completed!"
            })
    }
    
    func countNumber(completed: @escaping (Bool?) -> Void) {
        DispatchQueue.global().async {
            for _ in 0...10000000 {
            
            }
            self.timer?.invalidate()
            completed(true)
        }
    }
    
    func rxCountNumber() -> Observable<Bool> {
        return Observable.create { [weak self] o in
            self?.countNumber { (result) in
                o.onNext(result ?? false)
                o.onCompleted()
            }
            return Disposables.create()
        }
    }
}

