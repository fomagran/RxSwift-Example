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
        
        _ = APIService.fetchAllMenusRx()
            .map{ data -> [MenuItem] in
                struct Response:Decodable {
                    let menus:[MenuItem]
                }
                
                let response = try! JSONDecoder().decode(Response.self, from: data)
                return response.menus
            }
            .map{menuItems -> [Menu] in
                var menus:[Menu] = []
                menuItems.enumerated().forEach { (index,item) in
                    let menu = Menu.fromMenuItems(id: index, item: item)
                    menus.append(menu)
                }
                return menus
            }
            .take(1)
            .bind(to: menuObservable)
    }
    
    
    //클리어 누르면 5씩 올라가는 오류 해결하자!
    
    func onOrder() {
        
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
                    //max를 사용해서 -값으로 안가게 하기
                    return Menu(id:m.id,name: m.name, price: m.price, count: max(m.count + increase,0))
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
