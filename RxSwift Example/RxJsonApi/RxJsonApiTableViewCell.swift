//
//  RxJsonApiTableViewCell.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/20.
//

import UIKit
import RxSwift
import RxCocoa

class RxJsonApiTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    var disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func setData(_ data:Person) {
        loadImage(from: data.avatar)
            .observeOn(MainScheduler.instance)
            .bind(to: photo.rx.image)
            .disposed(by: disposeBag)
        
        photo.image = nil
        label.text = data.name
    }
    
    private func loadImage(from url:String) -> Observable<UIImage?> {
        return Observable.create { emitter -> Disposable in
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data,_,error in
                if let error = error {
                    emitter.onError(error)
                    return
                }
                
                guard let data = data,
                      let image = UIImage(data: data) else {
                    emitter.onNext(nil)
                    emitter.onCompleted()
                    return
                }
                emitter.onNext(image)
                emitter.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
