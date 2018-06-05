//
//  extension.swift
//  Collection
//
//  Created by stephane martins on 6/1/18.
//  Copyright © 2018 stephane martins. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

class customImageView: UIImageView{
    
    var imageUrlString: String?
    
//    let activityIndicator: UIActivityIndicatorView = {
//        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
//        aiv.translatesAutoresizingMaskIntoConstraints = false
//        return aiv
//    }()
    
    func loadImageWithURL(urlString: String)
    {
        imageUrlString = urlString
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
                    if self.imageUrlString == urlString
                    {
                        self.image = imageToCache
                    }
            }
        }).resume()
    }
}

