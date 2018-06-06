//
//  ViewController.swift
//  MotionDay
//
//  Created by Stephane MARTINS on 6/5/18.
//  Copyright © 2018 Stephane MARTINS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let myView = UIView(frame: CGRect(x:0, y: 0, width: 100, height: 100))
    
    let gravityBehavior = UIGravityBehavior()
    
    let dynamicAnimator = UIDynamicAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ca demarre")
//        gravityBehavior.magnitude = 100
        dynamicAnimator.addBehavior(gravityBehavior)
        gravityBehavior.addItem(myView)
//        view.addSubview(myView)
        initGestures()
    }
    
    func initGestures()
    {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        view.addGestureRecognizer(gesture)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("Hello tap")
        createGeometry(position: sender.location(in: view))
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
        gravityBehavior.addItem(newView)
        self.view.addSubview(newView)
    }
    
   
}

