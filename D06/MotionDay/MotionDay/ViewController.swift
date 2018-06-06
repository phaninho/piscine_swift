//
//  ViewController.swift
//  MotionDay
//
//  Created by Stephane MARTINS on 6/5/18.
//  Copyright © 2018 Stephane MARTINS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dynamicAnimator = UIDynamicAnimator()
    
    var forms = [UIDynamicItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        if (position.x < 30)
        {
            position.x = 30
        }
        else if (position.x > screenWidth - 30)
        {
            position.x = screenWidth - 30
        }
        createGeometry(position: position)
        addPhysic(forms: forms)
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
        self.view.addSubview(newView)
        forms.append(newView)
    }
    
    func addPhysic(forms: [UIDynamicItem])
    {
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        let gravityBehavior = UIGravityBehavior(items: forms)
        gravityBehavior.magnitude = 1//CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        dynamicAnimator.addBehavior(gravityBehavior)
        
        let collision = UICollisionBehavior(items: forms)
        collision.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collision)

        let itemBeha = UIDynamicItemBehavior()
        itemBeha.elasticity = 1.0
        itemBeha.density = 0.1
        dynamicAnimator.addBehavior(itemBeha)
    }
}
