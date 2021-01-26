import UIKit
import RxSwift

let strikes = PublishSubject<String>()

let disposeBag = DisposeBag()

//ignoreElements는 completed 됐을때 방출한다.
strikes
    .ignoreElements()
    .subscribe{print("Called")
    }
    .disposed(by: disposeBag)

strikes.onNext("A")
strikes.onNext("B")
//아무것도 프린트 안됨.

strikes.onCompleted()
//Called



