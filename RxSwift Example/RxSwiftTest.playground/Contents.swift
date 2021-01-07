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

//from으로 옵저버블 생성

let fromObservable = Observable.from([1,2,3])
//1
//2
//3

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


/*
 combineLatest와 zip
 
 combineLatest는 결과 두개를 이전 결과에 맞게 알아서 합쳐줌
 
 ex) A      B       C    D
       1       2    3          4
       1A  1B  2B   3C   3D    4D
 
 zip은 두개의 결과가 짝이 맞아야 합쳐져서 방출됨.
 
 ex) A      B       C    D
       1       2    3          4
       1A      2B  3C          4D
 */

/*
 map,filter,first
 
 map은 결과를 알아서 바꿔서 방출
 
 filter는 해당되는 결과만 방출
 
 first는 맨 첫번째 결과만 방출
 
 */
 




