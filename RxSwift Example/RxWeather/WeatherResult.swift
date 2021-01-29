//
//  WeatherResult.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/29.
//

import Foundation

struct WeahterResult:Decodable {
    let main:Weather
}

struct Weather:Decodable {
    let temp:Double
    let humidity:Double
}
