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
        
        self.textField.rx.value
            //같은 뷰컨트롤러이기때문에 weak self를 쓸 필요가 없다.
            .subscribe(onNext:{ city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    }else{
                        self.fetchWeather(by: city)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchWeather(by city:String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPI(city: cityEncoded) else { return }
        
        let resource = Resource<WeatherResult>(url:url)
        
        URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .catchErrorJustReturn(WeatherResult.empty)
            .subscribe(onNext:{ result in
                DispatchQueue.main.async {
                    let weather = result?.main
                    self.displayWeather(weather)
                }
               
            })
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
