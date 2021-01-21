//
//  MenuListViewModel.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/21.
//

import Foundation
import RxSwift

class MenuListViewModel {
    
    var menuObservable = BehaviorSubject<[Menu]>(value: [])
    
    lazy var totalPrice = menuObservable.map{
        $0.map{ $0.price * $0.count}.reduce(0,+)
    }
    
    lazy var itemCount = menuObservable.map{
        $0.map{ $0.count}.reduce(0,+)
    }
    
    init() {
        
        let menus:[Menu] = [
            Menu(name:"튀김1",price: 100,count:0),
            Menu(name:"튀김2",price: 100,count:0),
            Menu(name:"튀김3",price: 100,count:0),
            Menu(name:"튀김4",price: 100,count:0),
            Menu(name:"튀김5",price: 100,count:0)
        ]
        
        menuObservable.onNext(menus)
        
    }
    
    
}
