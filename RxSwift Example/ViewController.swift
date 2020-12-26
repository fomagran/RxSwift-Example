//
//  ViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2020/12/26.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var completed2: UILabel!
    @IBOutlet weak var num2: UILabel!
    @IBOutlet weak var completed: UILabel!
    @IBOutlet weak var number: UILabel!
    
    var count = 0.0
    
    var timer1:Timer?
    var timer2:Timer?
    var disposeBag:DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        isCompletedCount()
    }
    
    func startTimer() {
        timer1 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        timer2 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(update2), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        count += 0.1
        number.text = String(format: "%.1f",  count) + String("초가 걸렸어요")
    }
    
    @objc func update2() {
        count += 0.1
        num2.text = String(format: "%.1f",  count) + String("초가 걸렸어요")
    }
    
    @IBAction func stop(_ sender: Any) {
        disposeBag = DisposeBag()
        timer1?.invalidate()
        timer2?.invalidate()
        completed.text = "취소되었습니다."
        completed2.text = "취소되었습니다."
    }
    
    func isCompletedCount() {
        
         rxCountNumber()
            .observeOn(MainScheduler.instance)
            .subscribe({[weak self] _ in
                self?.completed.text = "Completed!"
            })
            .disposed(by: disposeBag)
        
        rxCountNumber()
            .observeOn(MainScheduler.instance)
            .subscribe({[weak self] _ in
                self?.completed2.text = "Completed!"
            })
            .disposed(by: disposeBag)
        
        
    }
    
    func countNumber(completed: @escaping (Bool?) -> Void) {
        DispatchQueue.global().async {
            for _ in 0...10000000 {
            
            }
            self.timer1?.invalidate()
            completed(true)
        }
    }
    
    func countNumber2(completed: @escaping (Bool?) -> Void) {
        DispatchQueue.global().async {
            for _ in 0...20000000 {
            
            }
            self.timer2?.invalidate()
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
    
    func rxCountNumber2() -> Observable<Bool> {
        return Observable.create { [weak self] o in
            self?.countNumber2 { (result) in
                o.onNext(result ?? false)
                o.onCompleted()
            }
            return Disposables.create()
        }
    }
}

