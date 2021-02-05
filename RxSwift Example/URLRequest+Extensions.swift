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
        return Observable.just(resource.url)
            .flatMap{ url -> Observable<(response:HTTPURLResponse,data:Data)> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.response(request: request)
            }.map{
                response,data -> T in
                if 200..<300 ~= response.statusCode {
                    return try! JSONDecoder().decode(T.self, from: data)
                }else{
                    throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
                }
            }
    }
}

extension URL {
    static func urlForWeatherAPI(city:String) -> URL? {
        return URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(API_KEY)")
    }
}


