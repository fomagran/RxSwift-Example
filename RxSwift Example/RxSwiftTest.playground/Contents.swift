import UIKit
import RxSwift

enum MyError:Error {
    case error
}

//옵저버블 생성
let observable = Observable<Int>.create { (observer) -> Disposable in
    observer.onNext(1)
    observer.onNext(2)
    observer.onError(MyError.error)
    observer.onNext(3)
    observer.onCompleted()
    return Disposables.create()
}

//just로 옵저버블 생성
let justObservable = Observable.just(1)

let subscriber = observable.subscribe{print($0)}


 /*
 observeOn과 subscribeOn
 
 observeOn(thread)은 그 다음부터 thread를 바꿈.
 
 subscribeOn(thread)은 처음 thread를 지정 고로 어디에 써도됨.
 
 */

/* drive의 역할
 
 asDriver를 사용하게 되면 dispose와 complete 결과를 무시할 수 있고
 
 에러상황에만 원하는 값을 방출할 수 있다.
 
 또한 asDriver 이후 subscribe 대신 drive로 하게 되면 자동으로 쓰레드를 메인으로 바꿔줌.
 
 */

 




