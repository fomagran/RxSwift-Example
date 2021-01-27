//
//  Task.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/27.
//

import Foundation

//enum으로 priority 설정하기
enum Priority:Int {
    case hight
    case medium
    case los
}

struct Task {
    let title:String
    let priority:Priority
}
