import UIKit
import RxSwift

enum MyError:Error {
    case error
}

let observable = Observable<Int>.create { (observer) -> Disposable in
    observer.onNext(1)
    observer.onNext(2)
    observer.onError(MyError.error)
    observer.onNext(3)
    observer.onCompleted()
    return Disposables.create()
}

let subscriber = observable.subscribe{print($0)}




