//
//  OperatorExampleViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/19.
//

import UIKit
import RxSwift

class OperatorExampleViewController: UIViewController {
    let randomNumber1 = "123123213242314356824567032578317F4823742365473458M074328674238501728".map{$0}
    let randomNumber2 = "안녕하세요 저는 안영훈입니다. 1 만나서 반갑습니다.".map{$0}
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let observable1 = Observable.from(randomNumber1)
        let observable2 = Observable.from(randomNumber2)
        
    
        
        let combine = Observable.combineLatest(observable1,observable2){$0.isNumber && $1.isNumber}
        
        combine.subscribe{print($0)}

        
    }
}
