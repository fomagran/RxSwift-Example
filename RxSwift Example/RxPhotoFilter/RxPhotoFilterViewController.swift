//
//  RxPhotoFilterViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/25.
//

import UIKit
import Photos
import RxSwift

class RxPhotoFilterViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var photoImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nav = segue.destination as? UINavigationController,let photosVC = nav.viewControllers.first as? RxPhotoFilterCollectionViewController else {
            fatalError()
        }
        
        photosVC.selectedPhoto.subscribe(onNext:{ [weak self] photo in
            self?.photoImageView.image = photo
        })
        .disposed(by: disposeBag)
    }
}
