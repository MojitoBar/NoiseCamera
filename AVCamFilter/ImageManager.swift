//
//  ImageManager.swift
//  AVCamFilter
//
//  Created by judongseok on 2021/06/30.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation
import Photos

class ImageManager {
    static let shared = ImageManager()
    
    private let imageManager = PHImageManager()
    
    func requestImage(from asset: PHAsset, thumnailSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        self.imageManager.requestImage(for: asset, targetSize: thumnailSize, contentMode: .aspectFill, options: nil) { image, info in
            completion(image)
        }
    }
}
