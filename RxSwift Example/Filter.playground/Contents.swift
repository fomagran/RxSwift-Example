import UIKit
import RxSwift

let strikes = PublishSubject<String>()

let disposeBag = DisposeBag()

//skip(숫자) 숫자만큼 스킵하고 방출한다.
Observable.of(1,2,3,4,5,6)
    .skip(3)
    .subscribe(onNext:{
        print($0)
    }).disposed(by: disposeBag)

////skipWhile 정해진 필터를 스킵하고 그 다음부터 모든 것을 방출. ex) 짝수가 오면 스킵해
Observable.of(2,2,2,4,5,6)
    .skipWhile { $0%2 == 0}
    .subscribe(onNext:{
        print($0)
    })
    .disposed(by: disposeBag)
//5
//6


//skipUntil은 정해진 옵저버블이 방출될때까지 스킵한다.
let subject = PublishSubject<Int>()
let trigger = PublishSubject<Int>()

subject
    .skipUntil(trigger)
    .subscribe(onNext:{print($0)}
    ).disposed(by: disposeBag)



subject.onNext(1)
subject.onNext(2)
//아무것도 출력안됨.
trigger.onNext(2)
subject.onNext(3)
//3

