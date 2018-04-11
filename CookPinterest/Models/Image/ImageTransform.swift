//
//  ImageTransform.swift
//  CookPinterest
//
//  Created by Jitendra on 11/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

class ImageTransformType: TransformType {
    
    public typealias Object = [Image]
    public typealias JSON = [String:Any]
    
    func transformToJSON(_ value: [Image]?) -> [String:Any]? {
        return nil
    }
    
    func transformFromJSON(_ value: Any?) -> [Image]? {
        
        guard let imagesInfo = value as? [String:[String:AnyObject]] else { return nil }
        
        let imagesValues = Array(imagesInfo.values)
        
        let images = imagesValues.compactMap { return Image(JSON: $0) }
        
        return images
    }
}
