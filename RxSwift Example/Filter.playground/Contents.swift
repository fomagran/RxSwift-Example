import UIKit
import RxSwift

let strikes = PublishSubject<String>()

let disposeBag = DisposeBag()

//element index를 정해주면
strikes.elementAt(2)
    .subscribe(onNext:{_ in print("You are out!")})
    .disposed(by: disposeBag)

strikes.onNext("X")
strikes.onNext("X")
//정해준 index의 element가 방출된다.
strikes.onNext("X")


