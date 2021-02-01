//
//  WeatherViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/29.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //텍스트필드에 수정이 끝났을때 엔터나 리턴키를 누르면 API 실행
        self.textField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map{self.textField.text}
            .subscribe(onNext:{ city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    }else {
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    private func fetchWeather(by city:String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPI(city: cityEncoded) else { return }
        
        let resource = Resource<WeatherResult>(url:url)
        
        
        let search = URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .catchErrorJustReturn(WeatherResult.empty)
        
        //레이블 바인딩하기
        search.map{"\($0.main.temp)℉"}
            .bind(to: self.temperature.rx.text)
            .disposed(by: disposeBag)
        
        search.map{"\($0.main.humidity)💦"}
            .bind(to: self.humidity.rx.text)
            .disposed(by: disposeBag)
    
    }
    
    private func displayWeather(_ weather:Weather?) {
        if let weather = weather {
            self.temperature.text = "\(weather.temp) ℉"
            self.humidity.text = "\(weather.humidity) 💦"
        }else{
            self.temperature.text = "🙈"
            self.humidity.text = "🚫"
        }
    }
    
    
    
}
