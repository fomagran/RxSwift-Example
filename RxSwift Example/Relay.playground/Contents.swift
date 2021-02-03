import UIKit
import RxSwift
import RxCocoa

var relay = BehaviorRelay<[Int]>(value:[1,2,3])

let relayOb = relay.asObservable()

relayOb.subscribe({print($0)})

var value = relay.value

value.append(4)

relay.accept(value)









