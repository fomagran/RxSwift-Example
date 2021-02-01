//
//  URLRequest+Extensions.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/29.
//

import UIKit
import RxSwift
import RxCocoa

struct Resource<T:Decodable> {
    let url:URL
}

//RxNews를 만들땐 Observable<T?>로 만들어서 옵셔널로 줄것
extension URLRequest {
    static func load<T>(resource:Resource<T>) -> Observable<T>  {
        return Observable.from([resource.url])
            .flatMap{url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }
            .map{data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
            .asObservable()
    }
}

extension URL {
    static func urlForWeatherAPI(city:String) -> URL? {
        return URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(API_KEY)")
    }
}


