//
//  extension.swift
//  Collection
//
//  Created by stephane martins on 6/1/18.
//  Copyright © 2018 stephane martins. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView{
    func loadImageWithURL(urlString: String)
    {
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) as? UIImage
        {
            self.image = imageFromCache
            return
        }
        
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data,reponse,error) in
            if error != nil
            {
                print("error")
                return
            }
            DispatchQueue.main.async
                {
                    let imageToCache = UIImage(data: data!)
                    
                    imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                    self.image = imageToCache
            }
        }).resume()
    }
}

