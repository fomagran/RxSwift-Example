//
//  Task.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/27.
//

import Foundation

enum Priority:Int {
    case high
    case medium
    case low
}

struct Task {
    let title:String
    let priority:Priority
}
