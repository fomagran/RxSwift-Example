//
//  Extentsion.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/21.
//

import Foundation

//한국 원 표시하는법
extension Int {
    func currencyKR() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
