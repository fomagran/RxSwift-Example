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
        
        textField.rx.controlEvent(.editingDidEndOnExit)
            .map{self.textField.text}
            .subscribe(onNext:{
                city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(weather:nil)
                    }else {
                        self.fetchWeather(city: city)
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    private func fetchWeather(city:String) {
        
        guard let city = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL.urlForWeatherAPI(city: city) else {return}
        let resource = Resource<WeatherResult>(url: url)
        URLRequest.load(resource:resource)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
              weather in
                DispatchQueue.main.async {
                    self.displayWeather(weather: weather.main)
                }
             
            }).disposed(by: disposeBag)
        
    }
    
    
    private func displayWeather(weather:Weather?){
        if let weather = weather {
            self.temperature.text = "\(weather.temp)"
            self.humidity.text = "\(weather.humidity)"

        }else{
            self.temperature.text = "No data"
            self.humidity.text = "No data"
        }
    }
    
    
    
}
