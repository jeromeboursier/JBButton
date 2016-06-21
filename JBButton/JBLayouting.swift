//
//  JBLayouting.swift
//  JBButton
//
//  Created by Jérôme Boursier on 17/06/2016.
//  Copyright © 2016 Jérôme Boursier. All rights reserved.
//

// MARK:- Extension for animation stuff
private typealias JBLayouting = JBButton
public extension JBLayouting {
    
    // MARK:- Layouting
    override public func drawRect(rect: CGRect) {
        
        self.cleanView()
        
        let imageView = UIImageView(image: self.image)
        
        let frames: (CGRect, CGRect)?
        switch positionValue {
        case .top:
            frames = self.layoutForTop(fromImageView: imageView)
        case .bottom:
            frames = self.layoutForBottom(fromImageView: imageView)
        case .left:
            frames = self.layoutForLeft(fromImageView: imageView)
        case .right:
            frames = self.layoutForRight(fromImageView: imageView)
        case .centered:
            frames = self.layoutForCentered(fromImageView: imageView)
        }
        
        // Setup image
        self.setupImageView(withFrame: frames!.0)
        
        // Setup label
        self.setupLabel(withFrame: frames!.1)
        
        // Add subviews
        self.addSubview(self.titleLabel!)
        self.addSubview(self.imageView!)
    }
    
    /**
     Cleans the view
     */
    private func cleanView() {
        if self.titleLabel!.isDescendantOfView(self) {
            self.titleLabel!.removeFromSuperview()
        }
        
        if !self.imageView!.isDescendantOfView(self) {
            self.imageView!.removeFromSuperview()
        }
    }
    
    /**
     Determines the layout of the button if the selected layout option is `.top`
     
     - parameter imageView: the imageView containing the image to display
     
     - returns: a tuple containing the frames of both the image and the label
     */
    private func layoutForTop(fromImageView imageView: UIImageView) -> (CGRect, CGRect) {
        let imageViewFrame = CGRect(
            x: self.frame.width/2 - imageView.frame.width/2,
            y: 0 + self.customPadding,
            width: imageView.frame.width,
            height: imageView.frame.height)
        
        let titleLabelFrame = CGRect(
            x: 0 + self.customPadding,
            y: imageView.frame.height + self.customPadding,
            width: self.frame.width - 2 * self.customPadding,
            height: self.frame.height - imageView.frame.height - 2 * self.customPadding)
        
        return (imageViewFrame, titleLabelFrame)
    }
    
    /**
     Determines the layout of the button if the selected layout option is `.bottom`
     
     - parameter imageView: the imageView containing the image to display
     
     - returns: a tuple containing the frames of both the image and the label
     */
    private func layoutForBottom(fromImageView imageView: UIImageView) -> (CGRect, CGRect) {
        let imageViewFrame = CGRect(
            x: self.frame.width/2 - imageView.frame.width/2,
            y: self.frame.height - imageView.frame.height - self.customPadding,
            width: imageView.frame.width,
            height: imageView.frame.height)
        
        let titleLabelFrame = CGRect(
            x: 0 + self.customPadding,
            y: 0 + self.customPadding,
            width: self.frame.width - 2 * self.customPadding,
            height: self.frame.height - imageView.frame.height - 2 * self.customPadding)
        
        return (imageViewFrame, titleLabelFrame)
    }
    
    /**
     Determines the layout of the button if the selected layout option is `.left`
     
     - parameter imageView: the imageView containing the image to display
     
     - returns: a tuple containing the frames of both the image and the label
     */
    private func layoutForLeft(fromImageView imageView: UIImageView) -> (CGRect, CGRect) {
        let imageViewFrame = CGRect(
            x: 0 + self.customPadding,
            y: self.frame.height/2 - imageView.frame.height/2,
            width: imageView.frame.width,
            height: imageView.frame.height)
        
        let titleLabelFrame = CGRect(
            x: imageView.frame.width + self.customPadding,
            y: 0 + self.customPadding,
            width: self.frame.width - imageView.frame.width - 2 * self.customPadding,
            height: self.frame.height - 2 * self.customPadding)
        
        return (imageViewFrame, titleLabelFrame)
    }
    
    /**
     Determines the layout of the button if the selected layout option is `.right`
     
     - parameter imageView: the imageView containing the image to display
     
     - returns: a tuple containing the frames of both the image and the label
     */
    private func layoutForRight(fromImageView imageView: UIImageView) -> (CGRect, CGRect) {
        let imageViewFrame = CGRect(
            x: self.frame.width - imageView.frame.width - self.customPadding,
            y: self.frame.height/2 - imageView.frame.height/2,
            width: imageView.frame.width,
            height: imageView.frame.height)
        
        let titleLabelFrame = CGRect(
            x: 0 + self.customPadding,
            y: 0 + self.customPadding,
            width: self.frame.width - imageView.frame.width - 2 * self.customPadding,
            height: self.frame.height - 2 * self.customPadding)
        
        return (imageViewFrame, titleLabelFrame)
    }
    
    /**
     Determines the layout of the button if the selected layout option is `.centered`
     
     - parameter imageView: the imageView containing the image to display
     
     - returns: a tuple containing the frames of both the image and the label
     */
    internal func layoutForCentered(fromImageView imageView: UIImageView) -> (CGRect, CGRect) {
        let imageViewFrame = CGRect(
            x: self.frame.width/2 - imageView.frame.width/2,
            y: self.frame.height/2 - imageView.frame.height/2,
            width: imageView.frame.width,
            height: imageView.frame.height)
        
        return (imageViewFrame, CGRect.zero)
    }
    
    /**
     Determines the layout of the default frame for the loader
     
     - returns: the default frame for the loader
     */
    internal func defaultFrameForLoader() -> CGRect {
        return CGRect(
            x: self.frame.width/2 - self.titleLabel!.frame.height/4,
            y: self.frame.height/2 - self.titleLabel!.frame.height/4,
            width: self.titleLabel!.frame.height/2,
            height: self.titleLabel!.frame.height/2)
    }
    
    /**
     Determines the frame of the loader
     
     - returns: The calculated frame of the loader
     */
    internal func determineLoaderFrame() -> CGRect {
        
        if self.customLoader?.frame != CGRect.zero {
            return self.customLoader!.frame
        }
        
        if self.hideTitleOnLoad {
            // hide title and center
            self.positionValue = Position.centered
            
            if self.image == nil {
                // hide title and default center
                return self.defaultFrameForLoader()
            } else {
                // hide title and center
                let center = CGPoint(x: self.frame.width/2 - self.imageView!.frame.height/2,
                                     y: self.frame.height/2 - self.imageView!.frame.height/2)
                self.customLoader?.center = center
                self.customLoader?.frame.size = self.imageView!.frame.size
                return self.customLoader!.frame
            }
            
        } else {
            if self.image == nil {
                // hide title and default center
                self.positionValue = Position.centered
                return self.defaultFrameForLoader()
            } else {
                // frame = image frame
                return self.imageView!.frame
            }
        }
    }
    
    /**
     Setups the imageView with user defined attributes
     
     - parameter frame: the frame of the imageView previously calculated
     */
    private func setupImageView(withFrame frame: CGRect) {
        self.imageView?.frame = frame
        self.imageView?.tintColor = self.imageColor
        self.imageView?.backgroundColor = UIColor.clearColor()
        
        if self.image != nil {
            switch self.renderingMode {
            case .original:
                self.imageView?.image = self.image!.imageWithRenderingMode(.AlwaysOriginal)
            case .template:
                self.imageView?.image = self.image!.imageWithRenderingMode(.AlwaysTemplate)
            }
        }
    }
    
    /**
     Setups the label with user defined attributes
     
     - parameter frame: the frame of the label previously calculated
     */
    private func setupLabel(withFrame frame: CGRect) {
        self.titleLabel = UILabel(frame: frame)
        self.titleLabel?.text = self.title
        self.titleLabel?.textColor = self.titleColor
        self.titleLabel?.textAlignment = NSTextAlignment(rawValue: NSInteger(self.titleAlignment)) ?? .Left
        self.titleLabel?.font = self.customFont
        self.titleLabel?.backgroundColor = UIColor.clearColor()
    }
    
}
