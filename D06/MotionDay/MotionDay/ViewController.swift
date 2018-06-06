//
//  ViewController.swift
//  MotionDay
//
//  Created by Stephane MARTINS on 6/5/18.
//  Copyright © 2018 Stephane MARTINS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let gravityBehavior = UIGravityBehavior()
    
    let dynamicAnimator = UIDynamicAnimator()
    
    let collision = UICollisionBehavior()
    
    var forms: [GeometryForm] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        gravityBehavior.magnitude = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
//        print(gravityBehavior.magnitude)
//        collision.translatesReferenceBoundsIntoBoundary = true
//        dynamicAnimator.addBehavior(collision)
//        dynamicAnimator.addBehavior(gravityBehavior)
//        gravityBehavior.addItem(myView)
        initGestures()
    }
    
    func initGestures()
    {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        view.addGestureRecognizer(gesture)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        var position = sender.location(in: view)
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
//        let screenHeight = screenSize.height
        if (position.x < 50)
        {
            position.x = 50
        }
        else if (position.x > screenWidth - 50)
        {
            position.x = screenWidth - 50
        }
        createGeometry(position: position)
    }
    
    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
        switch sender.state
        {
            case .began:
                    print("dans le began")
            case .changed:
                print("Ca change ", sender.location(in: view))
            case .ended:
                    print("fin de geture")
            case .failed:
                    print("dans fail")
            case .possible:
                    print("dans possible")
            case .cancelled:
                print("Cancelled")
        }
    }
    
    func createGeometry(position: CGPoint)
    {
        let newView = GeometryForm().randForm(position: position)
        gravityBehavior.magnitude = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        dynamicAnimator.addBehavior(gravityBehavior)
        collision.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collision)
        gravityBehavior.addItem(newView)
        self.view.addSubview(newView)
//        forms.append(newView)
    }
}
