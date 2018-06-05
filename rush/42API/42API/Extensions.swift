//
//  Extensions.swift
//  42API
//
//  Created by Stephane MARTINS on 6/2/18.
//  Copyright © 2018 Stephane MARTINS. All rights reserved.
//

import Foundation

extension String {
    static func random(length: Int) -> String {
        let charactersString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let charactersArray = Array(charactersString)
        var string = ""
        for _ in 0..<length {
            string.append(charactersArray[Int(arc4random()) % charactersArray.count])
        }
        return string
    }
}
