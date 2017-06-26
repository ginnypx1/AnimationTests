//
//  ButtonAnimations.swift
//  AnimationTests
//
//  Created by Ginny Pennekamp on 6/26/17.
//  Copyright © 2017 Ginny Pennekamp. All rights reserved.
//

import UIKit

extension AnimationsViewController {
    
    // MARK: - Button Animation
    
    func flashDotOnButton() {
        v.isHidden = true
        b.isHidden = false
        // the following code adds a pulsing orange circle next to button title
        var arr = [UIImage]()
        let w: CGFloat = 18
        for i in 0..<6 {
            let r = UIGraphicsImageRenderer(size: CGSize(width: w, height: w))
            arr += [r.image { ctx in
                let con = ctx.cgContext
                con.setFillColor(UIColor.red.cgColor)
                let ii = CGFloat(i)
                con.addEllipse(in: CGRect(x: 0+ii, y: 0+ii, width: w-ii*2, height: w-ii*2))
                con.fillPath()
                }]
        }
        let im = UIImage.animatedImage(with: arr, duration: 0.5)
        b.setImage(im, for: .normal)
    }
}
