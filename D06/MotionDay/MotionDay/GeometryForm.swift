//
//  GeometryForm.swift
//  MotionDay
//
//  Created by Stephane MARTINS on 6/6/18.
//  Copyright © 2018 Stephane MARTINS. All rights reserved.
//

import Foundation
import UIKit

class GeometryForm: UIView {
    
//    var form = GeometryForm(){
//        didSet{
//            print("dans le didset du geo")
//        }
//    }

    func randForm(position: CGPoint) -> UIView
    {
        if (arc4random_uniform(2) == 0) {
            return createSquares(position: position)
        }
        return createCircles(position: position)
    }
    
    func createSquares(position: CGPoint) -> UIView
    {
        let rect = CGRect(x:position.x - 30, y: position.y - 30, width: 60, height: 60)
        let myView = UIView(frame: rect)
        myView.backgroundColor = randColor()
        return myView
    }
    
    func createCircles(position: CGPoint) -> UIView
    {
        let rect = CGRect(x:position.x - 30, y: position.y - 30, width: 60, height: 60)
        let myView = UIView(frame: rect)
        myView.backgroundColor = randColor()
        myView.layer.cornerRadius = 30
        return myView
    }
    
    func randColor() -> UIColor
    {
        let rand = arc4random_uniform(7)
        
        switch rand
        {
            case 0:
                return .magenta
            case 1:
                return .black
            case 2:
                return .green
            case 3:
                return .yellow
            case 4:
                return .blue
            case 5:
                return .purple
            case 6:
                return .brown
            case 7:
                return .cyan
            default:
                return .red
        }
    }
}
