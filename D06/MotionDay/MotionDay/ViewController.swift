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
    
    var gravityBehavior = UIGravityBehavior()
    
    var forms = [UIDynamicItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initGestures()
    }

    
    func initGestures()
    {
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

    @objc func panGesture(gesture: UIPanGestureRecognizer)
    {
        switch gesture.state {
        case .began:
            self.gravityBehavior.removeItem(gesture.view!)
        case .changed:
            gesture.view?.center = gesture.location(in: gesture.view?.superview)
            dynamicAnimator.updateItem(usingCurrentState: gesture.view!)
        case .ended:
            self.gravityBehavior.addItem(gesture.view!)
        default:
            print("error")
        }

    }
    
    @objc func pinchGesture(gesture: UIPinchGestureRecognizer)
    {
        self.view.bringSubview(toFront: view)
        gesture.view?.transform = (gesture.view?.transform)!.scaledBy(x: gesture.scale, y: gesture.scale)
        gesture.scale = 1.0
        
    }
    
    @objc func rotationGesture(gesture: UIRotationGestureRecognizer)
    {
        var lastRotation: CGFloat = 0
        var originalRotation = CGFloat()
        if gesture.state == .began
        {
            
            gesture.rotation = lastRotation
            originalRotation = gesture.rotation
        }
        else if gesture.state == .changed
        {
            let newRotation = gesture.rotation + originalRotation
            gesture.view?.transform = CGAffineTransform(rotationAngle: newRotation)
        }
        else if gesture.state == .ended
        {
            // Save the last rotation
            lastRotation = gesture.rotation
        }
    }

    
    func createGeometry(position: CGPoint)
    {
        let newView = GeometryForm().randForm(position: position)
        self.view.addSubview(newView)
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        newView.addGestureRecognizer(gesture)
        let zoomGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture))
        newView.addGestureRecognizer(zoomGesture)
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationGesture))
        newView.addGestureRecognizer(rotateGesture)
        forms.append(newView)
    }
    
    func addPhysic(forms: [UIDynamicItem])
    {
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        gravityBehavior = UIGravityBehavior(items: forms)
        gravityBehavior.magnitude = 1//CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        dynamicAnimator.addBehavior(gravityBehavior)
        
        let collision = UICollisionBehavior(items: forms)
        collision.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collision)

        let itemBeha = UIDynamicItemBehavior(items: forms)
        itemBeha.elasticity = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        itemBeha.density = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        dynamicAnimator.addBehavior(itemBeha)

    }
}
