import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

//toArray 사용하기 : 배열로 만들어줌
let observable = Observable.of(1,2,3,4,5)
observable
    .toArray()
    .subscribe({print($0)})
    .disposed(by: disposeBag)

//map 사용하기
observable.map{$0*2}
    .subscribe({print($0)})
    .disposed(by: disposeBag)

//flatMap 사용하기
struct Student {
    var score:BehaviorRelay<Int>
}

let foma = Student(score: BehaviorRelay(value: 100))
let gran = Student(score: BehaviorRelay(value: 95))

let student = PublishSubject<Student>()

//flatMap으로 옵저버블 흐름자체를 바꿔버린다.
student.asObservable()
    .flatMap { $0.score.asObservable() }
    .subscribe({print($0)})
    .disposed(by: disposeBag)

student.onNext(foma)
//100

//중간에 객체안의 값이 바뀌면 바로 출력됨.
foma.score.accept(80)
//80

//map으로 하면 아래와 같이 출력됨.
student.asObservable()
    .map{$0.score}
    .subscribe({print($0)})

student.onNext(foma)
//next(RxRelay.BehaviorRelay<Swift.Int>)

//flatMapLatest
student.asObservable()
    .flatMapLatest{$0.score.asObservable()}
    .subscribe{print($0)}
    .disposed(by: disposeBag)

student.onNext(foma)
foma.score.accept(90)
student.onNext(gran)
//가장 마지막이 gran이므로 foma의 값이 바뀌든 말든 상관쓰지않는다.
foma.score.accept(86)


