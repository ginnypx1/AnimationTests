//
//  AnimationsViewController.swift
//  AnimationTests
//
//  Created by Ginny Pennekamp on 6/26/17.
//  Copyright © 2017 Ginny Pennekamp. All rights reserved.
//

import UIKit

class AnimationsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var b: UIButton!
    @IBOutlet weak var iv: UIImageView!
    @IBOutlet weak var v: UIView!
    @IBOutlet weak var v2: UIView!
    
    // MARK: - Run Test Animation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // most animations in this file deal with a single view
        // to run animations that don't need this view, uncomment v.isHidden below
        b.isHidden = true
        iv.isHidden = true
        // v.isHidden = true
        v2.isHidden = true
        
        // call animation function you want to test here
        transitionAnimation()
    }
    
    // MARK: - UIViewAnimations
    
    /*basic animation types*/
    
    func beginAndCommit() {
        // not used anymore
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        self.view.backgroundColor = .red
        UIView.commitAnimations()
    }
    
    func blockBasedAnimations() {
        UIView.animate(withDuration: 1) {
            self.v.backgroundColor = .red
        }
    }
    
    func propertyAnimator() {
        let anim = UIViewPropertyAnimator(duration: 1, curve: .linear) {
            self.v.backgroundColor = .red
        }
        anim.startAnimation()
    }
    
    func keyframeAnimation() {
        v.backgroundColor = .red
        var p = self.v.center
        let dur = 0.25
        var start = 0.0
        let dx: CGFloat = 100
        let dy: CGFloat = 50
        var dir: CGFloat = 1
        UIView.animateKeyframes(withDuration: 4, delay: 0, animations: {
            // gradually fades away
            self.v.alpha = 0
            // swings and descends
            UIView.addKeyframe(withRelativeStartTime: start, relativeDuration: dur) {
                p.x += dx*dir; p.y += dy
                self.v.center = p
            }
            start += dur
            dir *= -1
            UIView.addKeyframe(withRelativeStartTime: start, relativeDuration: dur) {
                p.x += dx*dir; p.y += dy
                self.v.center = p
            }
            start += dur
            dir *= -1
            UIView.addKeyframe(withRelativeStartTime: start, relativeDuration: dur) {
                p.x += dx*dir; p.y += dy
                self.v.center = p
            }
            start += dur
            dir *= -1
            UIView.addKeyframe(withRelativeStartTime: start, relativeDuration: dur) {
                p.x += dx*dir; p.y += dy
                self.v.center = p
            }
        })
    }
    
    /*add animations after instantiation*/
    
    func addAnimationAfterInstantiation() {
        let anim = UIViewPropertyAnimator(duration: 1, timingParameters: UICubicTimingParameters(animationCurve: .linear))
        anim.addAnimations {
            self.v.backgroundColor = .red
        }
        anim.addAnimations {
            self.v.center.y += 100
        }
        anim.startAnimation()
    }
    
    /*no animation inside animation*/
    
    func doNotAnimatePart() {
        let anim = UIViewPropertyAnimator(duration: 2, curve: .linear) {
            self.v.backgroundColor = .red
            UIView.performWithoutAnimation {
                self.v.center.y += 100
            }
        }
        anim.startAnimation()
    }
    
    /*animation delay within animation*/
    func animationDelayWithinAnimation() {
        v.backgroundColor = .red
        let anim = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) {
            self.v.center.y += 100
        }
        anim.addAnimations({
            self.v.center.x += 100
        }, delayFactor: 0.5)
        anim.startAnimation()
    }
    
    func animationDelayWithinAnimationStronger() {
        v.backgroundColor = .red
        let yorig = self.v.center.y
        let anim = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) {
            self.v.center.y += 100
        }
        anim.addAnimations({
            self.v.center.y = yorig
        }, delayFactor: 0.5)
        anim.startAnimation()
    }
    
    // MARK: - Autoreverse
    
    func autoreverse() {
        v.backgroundColor = .red
        let opts: UIViewAnimationOptions = .autoreverse
        let xorig = self.v.center.x
        UIView.animate(withDuration: 1, delay: 0, options: opts, animations: {
            // workaround to specify number of repetitions
            UIView.setAnimationRepeatCount(3)
            self.v.center.x += 100
        }, completion: { _ in
            self.v.center.x = xorig
        })
    }
    
    // MARK: - Dissolve effect
    
    func dissolve() {
        v2.isHidden = false
        // dissolve one view into another view
        v.backgroundColor = .red
        v.alpha = 1
        v2.backgroundColor = .black
        v2.alpha = 0
        let anim = UIViewPropertyAnimator(duration: 1, curve: .linear) {
            self.v.alpha = 0
            self.v2.alpha = 1
        }
        anim.addCompletion { _ in
            self.v.removeFromSuperview()
        }
        anim.startAnimation()
    }
    
    // MARK: - Bezier Curve
    
    func specifyTimingParameters() {
        // starts slow, finishes quickly
        v.backgroundColor = .red
        let anim = UIViewPropertyAnimator(duration: 1, timingParameters: UICubicTimingParameters(controlPoint1: CGPoint(x: 0.9, y: 0.1), controlPoint2: CGPoint(x: 0.7, y: 0.9)))
        anim.addAnimations {
            self.v.center.y += 300
        }
        anim.startAnimation()
    }
    
    // MARK: - Cancel Animation
    
    func speedUpAnimationToCancel() {
        v.backgroundColor = .red
        // this is the long animation that is in progress
        let anim = UIViewPropertyAnimator(duration: 4, timingParameters: UICubicTimingParameters())
        anim.addAnimations {
            self.v.center.x += 200
        }
        anim.startAnimation()
        // user presses a button here and animation needs to be stopped fast
        anim.pauseAnimation()
        anim.continueAnimation(withTimingParameters: UICubicTimingParameters(animationCurve: .easeOut), durationFactor: 0.1)
    }
    
    func cancelAnimationAndHurryHome() {
        v.backgroundColor = .red
        // this is the long animation that is in progress
        let anim = UIViewPropertyAnimator(duration: 4, timingParameters: UICubicTimingParameters())
        anim.addAnimations {
            self.v.center.x += 200
        }
        anim.startAnimation()
        // user presses a button here and animation needs to be stopped fast
        anim.pauseAnimation()
        anim.isReversed = true
        anim.continueAnimation(withTimingParameters: UICubicTimingParameters(animationCurve: .easeOut), durationFactor: 0.1)
    }
    
    func cancelAnimationAndHeadOffScreen() {
        v.backgroundColor = .red
        // this is the long animation that is in progress
        let anim = UIViewPropertyAnimator(duration: 4, timingParameters: UICubicTimingParameters())
        anim.addAnimations {
            self.v.center.x += 200
        }
        anim.startAnimation()
        // user presses a button here and animation needs to be stopped fast
        anim.pauseAnimation()
        anim.addAnimations {
            self.v.center = CGPoint(x: -200, y: -200)
        }
        anim.continueAnimation(withTimingParameters: UICubicTimingParameters(animationCurve: .easeOut), durationFactor: 0.1)
    }
    
    func cancelAndStop() {
        v.backgroundColor = .red
        // this is the long animation that is in progress
        let anim = UIViewPropertyAnimator(duration: 4, timingParameters: UICubicTimingParameters())
        anim.addAnimations {
            self.v.center.x += 200
        }
        anim.startAnimation()
        // user presses a button here and animation needs to be stopped fast
        anim.stopAnimation(false)
        anim.finishAnimation(at: .current)
    }
    
    func cancelRepeatingAnimation() {
        v.backgroundColor = .red
        // this animation will go on forever
        let pOrig = self.v.center
        var opts: UIViewAnimationOptions = [.autoreverse, .repeat]
        UIView.animate(withDuration: 1, delay: 0, options: opts, animations: {
            self.v.center.x += 100
        })
        // unless stopped
        opts = .beginFromCurrentState
        UIView.animate(withDuration: 0.1, delay: 0, options: opts, animations: {
            self.v.center = pOrig
        })
    }

}

