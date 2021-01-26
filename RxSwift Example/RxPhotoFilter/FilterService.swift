//
//  FilterService.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/26.
//

import UIKit
import CoreImage
import RxSwift

class FilterService {
    private var context:CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func rxApplyFilter(to inputImage:UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { (observer) -> Disposable in
            self.applyFilter(to: inputImage) { (filteredImage) in
                observer.onNext(filteredImage)
            }
            return Disposables.create()
        }
    }
    
    func applyFilter(to inputImage:UIImage,completion:@escaping((UIImage) -> ())) {
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image:inputImage) {
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            if let cgImage = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
                
                let processedImage = UIImage(cgImage: cgImage,scale: inputImage.scale,
                                             orientation: inputImage.imageOrientation)
                completion(processedImage)
            }
        }
    }
}
