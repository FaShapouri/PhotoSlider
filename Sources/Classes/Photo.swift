//
//  Photo.swift
//  Pods
//
//  Created by nakajijapan on 2015/11/08.
//
//

import UIKit

open class Photo: NSObject {
    
    open var imageURL: URL?
    open var image: UIImage?
    open var caption = ""
    
    public init(imageURL: URL) {
        super.init()
        self.imageURL = imageURL
    }
    
    public init(image: UIImage) {
        super.init()
        self.image = image
    }
    
    public init(imageURL: URL, caption: String) {
        super.init()
        self.imageURL = imageURL
        self.caption = caption
    }
    
    public init(image: UIImage, caption: String) {
        super.init()
        self.image = image
        self.caption = caption
    }

    
}
