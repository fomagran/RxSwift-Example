import UIKit
import RxSwift


let disposeBag = DisposeBag()

//take 숫자만큼만 방출한다.
Observable.of(1,1,1,4,5,6)
    .take(3)
    .subscribe(onNext:{print($0)})
    .disposed(by: disposeBag)

//takeWhile은 정해진 조건이 되기 전까지만 방출함.
Observable.of(1,1,1,4,5,6)
    .takeWhile({$0%2 == 0})
    .subscribe(onNext:{print($0)})
    .disposed(by: disposeBag)

let subject = PublishSubject<Int>()
let trigger = PublishSubject<Int>()

subject.takeUntil(trigger)
    .subscribe(onNext:{print($0)})
    .disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)
//1
//2
trigger.onNext(1)
subject.onNext(3)
//방출되지 않음 skip과 반대로 작용




