//
//  JBLoading.swift
//  JBButton
//
//  Created by Jérôme Boursier on 17/06/2016.
//  Copyright © 2016 Jérôme Boursier. All rights reserved.
//

// MARK:- Extension for loading stuff
private typealias JBLoading = JBButton
public extension JBLoading {
    
    /**
     Sets the custom loader, and both start and stop animation blocks
     
     - parameter loader: the loader to display
     - parameter start:  the `activityIndicator.startAnimating()` equivalent block
     - parameter stop:   the `activityIndicator.stopAnimating()` equivalent block
     */
    public func setCustomLoader(loader: UIView, startAnimationBlock start: (Void -> ()), stopAnimationBlock stop: (Void -> ())) {
        self.customLoader = loader
        self.customLoaderStart = start
        self.customLoaderStop = stop
    }    
    
    /**
     Prepares the view for loading
     */
    private func prepareForLoading() {
        if self.customLoader == nil {
            let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
            if self.imageRenderingMode == 1 {
                activityIndicator.color = self.imageView?.tintColor
            } else if self.image == nil {
                activityIndicator.color = self.titleColor
            }
            self.customLoader = activityIndicator
            self.customLoaderStart = { activityIndicator.startAnimating() }
            self.customLoaderStop = { activityIndicator.stopAnimating() }
            self.customLoader?.frame = CGRect.zero
        }
        
        self.customLoader?.frame = self.determineLoaderFrame()
    }
    
    /**
     Starts loading. By default, a standard activity indicator will remplace the image.
     
     Title can be changed populating the parameter `title`
     
     It can be customized implementing `setCustomLoader(_:startAnimationBlock:stopAnimationBlock)`
     
     You can `hideTitleOnLoad` if you want it to.
     
     You can also add `customLoadingAnimations` that will be played until you `stopLoading()`
     
     You can also implement the method `startLoading(withTitle:)` to change the title while loading
     
     - parameter title: the title to display while loading
     */
    public func startLoading(withTitle title: String? = nil) {
        
        guard !self.isLoading else {
            return
        }
        
        self.userInteractionEnabled = false
        
        self.isLoading = true
        
        self.prepareForLoading()
        
        
        if self.hideTitleOnLoad || self.image == nil {
            self.positionValue = .centered
        }
        
        self.customLoader?.hidden = false
        self.imageView?.hidden = true
        self.addSubview(self.customLoader!)
        self.customLoaderStart!()
        
        self.launchAnimations(self.customLoadingAnimations, forGlobalKeyPath: "loadingAnimations")
        
        if let newTitle = title where newTitle.characters.count != 0 && !self.hideTitleOnLoad && self.title != nil {
            self.setTitleText(newTitle)
        } else {
            self.setNeedsDisplay()
        }
        
        
    }
    
    /**
     Stops loading. The button is restored to its initial state.
     
     Title can be changed populating the parameter `title`
     
     All loading animations are removed.
     
     - parameter title: the title to display when loading finishes
     */
    public func stopLoading(withTitle title: String? = nil) {
        
        guard self.isLoading else {
            return
        }
        
        self.userInteractionEnabled = true
        
        self.isLoading = false
        
        if self.hideTitleOnLoad || self.image == nil {
            self.positionValue = self.originalPosition
        }
        
        self.customLoader?.removeFromSuperview()
        self.customLoaderStop!()
        self.imageView?.hidden = false
        
        self.layer.removeAllAnimations()
        
        if let newTitle = title where newTitle.characters.count != 0 && self.title != nil {
            self.setTitleText(newTitle)
        } else {
            self.setNeedsDisplay()
        }
    }
}
