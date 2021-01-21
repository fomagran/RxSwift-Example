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
            Menu(id:0,name:"튀김1",price: 100,count:0),
            Menu(id:1,name:"튀김2",price: 100,count:0),
            Menu(id:2,name:"튀김3",price: 100,count:0),
            Menu(id:3,name:"튀김4",price: 100,count:0),
            Menu(id:4,name:"튀김5",price: 100,count:0)
        ]
        
        menuObservable.onNext(menus)
        
    }
    
    
    func clearAllItems() {
       _ = menuObservable.map{ menus in
            menus.map { m in
                Menu(id:0,name: m.name, price: m.price, count: 0)
            }
        }
        .take(1)
        .subscribe(onNext:{
            self.menuObservable.onNext($0)
        })
    }
    
    func changeCount(item:Menu,increase:Int) {
        _ = menuObservable.map{ menus in
             menus.map { m in
                if m.id == item.id {
                    return Menu(id:m.id,name: m.name, price: m.price, count: m.count + increase)
                }else{
                    return Menu(id:m.id,name: m.name, price: m.price, count: m.count)
                }
                
             }
         }
         .take(1)
         .subscribe(onNext:{
             self.menuObservable.onNext($0)
         })
    }
    
    
}
