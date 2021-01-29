import UIKit
import RxSwift


print("------startWith------")
//startWith : 옵저버블 시작에 값을 합쳐서 보여줄수 있음
let numbers = Observable.of(2,3,4)
let ob = numbers.startWith(1)

ob.subscribe({print($0)})
//next(1)
//next(2)
//next(3)
//next(4)
//completed

print("------concat------")

//concat : Observable을 합쳐서 보여줌.
let first = Observable.of(1,2,3)
let second = Observable.of(4,5,6)

let concat = Observable.concat([first,second])

concat.subscribe({print($0)})
//next(1)
//next(2)
//next(3)
//next(4)
//next(5)
//next(6)
//completed

print("------merge------")

//merge:방출한 값을 차례로 하나의 옵저버블로 만들어줌

let left = PublishSubject<Int>()
let right = PublishSubject<Int>()

let merge = Observable.of(left.asObservable(),right.asObservable()).merge()

merge.subscribe({print($0)})

left.onNext(1)
left.onNext(2)
right.onNext(12)
right.onNext(11)
left.onNext(3)

//next(1)
//next(2)
//next(12)
//next(11)
//next(3)

print("-------combineLatest-----")

//combineLatest:각 옵저버블에서 가장 마지막으로 반환한 값으로 합쳐줌

let a = PublishSubject<Int>()
let b = PublishSubject<Int>()

let combineLatest = Observable.combineLatest(a,b) {left,right in "\(left),\(right)"}

combineLatest.subscribe({print($0)})

a.onNext(1)
a.onNext(2)
b.onNext(11)
a.onNext(3)
b.onNext(5)
//next(2,11)
//next(3,11)
//next(3,5)

print("------withLatestFrom------")

//가장 withLatestFrom(서브젝트)에 있는 서브젝트의 마지막 값을 방출함.
let button = PublishSubject<Bool>()
let textField = PublishSubject<String>()

let withLatestFrom = button.withLatestFrom(textField)
withLatestFrom.subscribe({print($0)})

textField.onNext("S")
textField.onNext("Swi")
button.onNext(true)
textField.onNext("Swif")
textField.onNext("Swift")
button.onNext(true)
//next(Swi)
//next(Swift)

print("------reduce------")
//값을 모두 합쳐준 데이터 하나만 방출
let intRd = Observable.of(1,2,3,4,5,6)
let stringRd = Observable.of("a","b","c")
intRd.reduce(0, accumulator: +).subscribe({print($0)})
stringRd.reduce("", accumulator: +).subscribe({print($0)})
//next(6)
//completed
//next(abc)
//completed

print("------scan------")
//reduce와 다른점은 reduce는 다 더해준 데이터 하나만 방출하지만 scan은 더해질때마다 한번씩 방출한다.
let scanOb = Observable.of(1,2,3,4,5,6)
scanOb.scan(0, accumulator: +).subscribe({print($0)})
//next(1)
//next(3)
//next(6)
//next(10)
//next(15)
//next(21)
//completed












