//
//  JBAnimated.swift
//  JBButton
//
//  Created by Jérôme Boursier on 17/06/2016.
//  Copyright © 2016 Jérôme Boursier. All rights reserved.
//

// MARK:- Extension for animation stuff
private typealias JBAnimated = JBButton
public extension JBAnimated {
    
    /**
     Attachs animations to the layer of the button
     
     - parameter animations: a group of animations
     - parameter keyPath:    the key path
     */
    internal func launchAnimations(animations: CAAnimationGroup?, forGlobalKeyPath keyPath: String) {
        guard animations != nil else {
            return
        }
        self.layer.addAnimation(animations!, forKey: keyPath)
    }
    
    // MARK:- UIKit
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        if self.highlight {
            self.backgroundColor = self.backgroundColor!.darkerColor()
        }
        
        self.launchAnimations(self.customTouchesBeganAnimations, forGlobalKeyPath: "touchesBegan")
    }
    
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        self.backgroundColor = self.originalBackgroundColor
        
        self.launchAnimations(self.customTouchesEndedAnimations, forGlobalKeyPath: "touchesEnded")
        
        self.delegate?.didTapOnButton?(self)
    }
}