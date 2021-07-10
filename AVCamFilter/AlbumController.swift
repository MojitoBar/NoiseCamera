//
//  AlbumController.swift
//  AVCamFilter
//
//  Created by judongseok on 2021/06/16.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation
import UIKit
import Photos

class AlbumController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPhotoLibraryChangeObserver{
   
    var picList: [String] = []
    var fetchResult: PHFetchResult<PHAsset>!
    let picker = UIImagePickerController()
    var imageUrl = PHAsset()
    var imageCount = 0
    var imageLocation: Int?
    @IBOutlet weak var AlbumImage: UIImageView!
    
    @IBOutlet weak var imageState: UILabel!
    @IBAction func BackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var galeryView: UIButton!
    
    @IBAction func galeryButton(_ sender: Any) {
        picker.delegate = self
        
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    @IBAction func onClickDeleteButton(_ sender: Any) {
        guard self.AlbumImage.image != nil else {return}
        
        PHPhotoLibrary.shared().performChanges({PHAssetChangeRequest.deleteAssets([self.imageUrl] as NSArray)}, completionHandler: nil)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        picker.delegate = self
        
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
        PHPhotoLibrary.shared().register(self)
        requestCollection()
        
        checkCount()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageUrl = info[UIImagePickerController.InfoKey.phAsset] as! PHAsset
        print(imageUrl.localIdentifier)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            AlbumImage.image = image
        }
        galeryView.isHidden = true
        dismiss(animated: true, completion: nil)
        
        // 몇 번째 사진인지 확인하기
        imageLocation = picList.firstIndex(of: imageUrl.localIdentifier)
        
        checkCount()
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        // 변화감지
        guard let change = changeInstance.changeDetails(for: fetchResult) else {
            return
        }
        
        fetchResult = change.fetchResultAfterChanges
        
        if imageCount != fetchResult.count {
            print("변화감지")
            imageCount = fetchResult.count
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func requestCollection(){
        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        guard let cameraRollCollection = cameraRoll.firstObject else{
            return
        }
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
        imageCount = fetchResult.count
        
        for i in 0..<imageCount{
            picList.append(fetchResult.object(at: i).localIdentifier)
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func checkCount(){
        if imageLocation == nil {
            imageState.text = ""
        }
        else{
            imageState.text = String(imageLocation! + 1) + " / " + String(imageCount)
        }

    }
}
