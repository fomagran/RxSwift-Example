//
//  RxPhotoFilterCollectionViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/25.
//

import UIKit
import Photos


class RxPhotoFilterCollectionViewController: UICollectionViewController {

    private var images = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populatePhotos()

        
    }
    
    private func populatePhotos() {
        PHPhotoLibrary.requestAuthorization{ [weak self]
            status in
            if status == .authorized {
                //access photos from photo library
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image,options: nil)
                
                assets.enumerateObjects{ (object,count,stop) in
                    self?.images.append(object)
                }
            
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }

  

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { (image, _) in
            DispatchQueue.main.async {
                cell.photoImageView.image = image
            }
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate
}


extension RxPhotoFilterCollectionViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
}
