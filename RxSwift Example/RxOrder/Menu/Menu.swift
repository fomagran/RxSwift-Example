//
//  Menu.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/21.
//

import Foundation

//View를 위한 Model : ViewModel
struct Menu:Decodable {
    var id:Int
    var name:String
    var price:Int
    var count:Int
}

extension Menu {
    static func fromMenuItems(id:Int,item:MenuItem) -> Menu {
        return Menu(id: id, name: item.name, price: item.price, count: 0)
    }
}
