//
//  WeatherResult.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/29.
//

import Foundation

struct WeatherResult:Codable {
    let main:Weather
}
struct Weather:Codable {
    let temp:Double
    let humidity:Double
}
