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
    
    @IBOutlet weak var filterButton:UIButton!
    @IBOutlet weak var photoImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nav = segue.destination as? UINavigationController,let photosVC = nav.viewControllers.first as? RxPhotoFilterCollectionViewController else {
            fatalError()
        }
        
        photosVC.selectedPhoto.subscribe(onNext:{ [weak self] photo in
            DispatchQueue.main.async {
            self?.updateUI(with: photo)
            }
        })
        .disposed(by: disposeBag)
    }
    
    @IBAction func applyFilter() {
        guard let sourceImage = self.photoImageView.image else {return}
        FilterService().applyFilter(to: sourceImage) { (filteredImage) in
            DispatchQueue.main.async {
                self.photoImageView.image = filteredImage
            }
        }
    }
    
    private func updateUI(with image:UIImage) {
        self.photoImageView.image = image
        self.filterButton.isHidden = false
    }
}
