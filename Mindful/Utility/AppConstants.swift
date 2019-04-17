//
//  ImageDownloader.swift
//  Mindful
//
//  Created by Yuvraj Sahu on 16/04/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ImageDownloader{
    var sharedInstance = ImageDownloader()
    
    private init(){}
    
    private func getImage(url : URL?) -> UIImage?{
        SDWebImageDownloader.shared().downloadImage(with: <#T##URL?#>, options: <#T##SDWebImageDownloaderOptions#>, progress: <#T##SDWebImageDownloaderProgressBlock?##SDWebImageDownloaderProgressBlock?##(Int, Int, URL?) -> Void#>, completed: <#T##SDWebImageDownloaderCompletedBlock?##SDWebImageDownloaderCompletedBlock?##(UIImage?, Data?, Error?, Bool) -> Void#>)
        return nil
    }
}
