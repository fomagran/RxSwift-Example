import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()


//let publishSubject = PublishSubject<Int>()
//
//publishSubject.subscribe(onNext:{print($0)})
//
//publishSubject.onNext(1)
//publishSubject.onNext(2)
//publishSubject.onNext(3)
//1
//2
//3

let ob = Observable.just(1)
let sub1 = ob.subscribe(onNext:{print($0)})
let sub2 = ob.subscribe(onNext:{print($0)})

enum MyError:Error {
    case error
}

let asyncSubject = AsyncSubject<Int>()

asyncSubject.subscribe({print($0)})

asyncSubject.onNext(1)
asyncSubject.onNext(2)
asyncSubject.onNext(3)

//next(3)
//completed






//PublishSubject
let publishSubject = PublishSubject<String>()

publishSubject.onNext("Pusblish 1")

//한번 미리 구독을 해놓으면 다음에 onNext를 보내면 그 값이 됨.
publishSubject.subscribe {event in print(event) }

//2가 출력된다.
publishSubject.onNext("Pusblish 2")

publishSubject.onNext("Pusblish 3")

//컴플릿,디스포즈,에러 하면 끝
publishSubject.onCompleted()

//next(Pusblish 2)
//next(Pusblish 3)
//completed


//BehaviorSubject

//초기값을 가진다.
let behaviorSubject = BehaviorSubject<String>(value: "Behavior 1")

behaviorSubject.subscribe { event in
    print(event)
}

behaviorSubject.onNext("Behavior 2")

behaviorSubject.onNext("Behavior 3")

//next(Behavior 1)
//next(Behavior 2)
//next(Behavior 3)


//ReplaySubject

//BufferSize만큼 끝에서부터 기억하고 있다가 방출함.

let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("Replay 1")
replaySubject.onNext("Replay 2")
replaySubject.onNext("Replay 3")

replaySubject.subscribe { (event) in
    print(event)
}

replaySubject.onNext("Replay 4")
replaySubject.onNext("Replay 5")

//next(Replay 2)
//next(Replay 3)
//next(Replay 4)
//next(Replay 5)


//Variable
//Variable은 지금 사용하지 않음.(알아만두기) BehaviorRelay로 대체됨
let variable = Variable(String())

variable.value = "Variable Hello"

variable.asObservable()
    .subscribe{print($0)}

//Behavior Relay (Rxcocoa 추가해줘야함.)

let behaviorRelay = BehaviorRelay(value: "BehaviorRelay 1")


let behaviorRelayArray = BehaviorRelay(value: ["BehaviorRelayArray 1"])
// behaviorRelayArray에 값 추가하기 1
behaviorRelayArray.accept(behaviorRelayArray.value+["BehaviorRelayArray 2"])

// behaviorRelayArray에 값 추가하기 2
var value = behaviorRelayArray.value
value.append("BehaviorRelayArray 3")
value.append("BehaviorRelayArray 4")

behaviorRelayArray.accept(value)

behaviorRelayArray.subscribe{print($0)}

behaviorRelay.asObservable()
    .subscribe{print($0)}

//relay는 accept를 사용한다.
behaviorRelay.accept("BehaviorRelay 2")















