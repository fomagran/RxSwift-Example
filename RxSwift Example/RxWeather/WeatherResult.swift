//
//  WeatherResult.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/29.
//

import Foundation

struct WeatherResult:Decodable {
    let main:Weather
}

//옵셔널일 경우 새로운 웨더를 만들어서 넣어버린다.
extension WeatherResult {
    static  var empty:WeatherResult {
        return WeatherResult(main: Weather(temp: 0.0, humidity: 0.0))
    }
}

struct Weather:Decodable {
    let temp:Double
    let humidity:Double
}
