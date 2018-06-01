//
//  extension.swift
//  Collection
//
//  Created by stephane martins on 6/1/18.
//  Copyright © 2018 stephane martins. All rights reserved.
//

import UIKit

extension UIImageView{
    func loadImageWithURL(urlString: String)
    {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: {(data,reponse,error) in
            if error != nil
            {
                print("error")
                return
            }
             queue.async {
                DispatchQueue.main.async
                    {
                        self.image = UIImage(data: data!)
                }
            }
        }).resume()
    }
}

