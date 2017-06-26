//
//  ImageViewAnimations.swift
//  AnimationTests
//
//  Created by Ginny Pennekamp on 6/26/17.
//  Copyright © 2017 Ginny Pennekamp. All rights reserved.
//

import UIKit

extension AnimationsViewController {
    
    // MARK: - Image View Animation
    
    func flashImage() {
        v.isHidden = true
        iv.isHidden = false
        // flashes image of construction truck inside the image view
        let truck = UIImage(named: "construction-truck-button")
        let r = UIGraphicsImageRenderer(size: (truck?.size)!)
        let empty = r.image {_ in }
        let picArr = [truck, empty, truck, empty, truck]
        iv.image = empty
        iv.animationImages = picArr as? [UIImage]
        iv.animationDuration = 2
        iv.animationRepeatCount = 0
        iv.startAnimating()
    }
    
    func transitionAnimation() {
        v.isHidden = true
        iv.isHidden = false
        iv.image = UIImage(named: "construction-truck-button")
        // "flips" the button to reveal the other side
        let opts: UIViewAnimationOptions = [.transitionFlipFromLeft, .repeat, .autoreverse] // Top, Right, Bottom, Left
        // .transitionCurlUp, Down and .transitionCrossDissolve
        UIView.transition(with: self.iv, duration: 1, options: opts, animations: {
            self.iv.image = UIImage(named: "emergency-truck-button")
        })
    }
}
