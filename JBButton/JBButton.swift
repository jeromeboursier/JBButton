//
//  JBButton.swift
//  JBButton
//
//  Created by Jérôme Boursier on 17/06/2016.
//  Copyright © 2016 Jérôme Boursier. All rights reserved.
//

import UIKit

/**
 *  Delegate protocol
 *  Method(s) fired by the `button` on notable event(s)
 */
@objc public protocol JBButtonDelegate: AnyObject {
    /**
     Method to handle the tap on the `button` equivalent to the known `touchUpInside` action
     
     - parameter sender: the current `button` tapped
     */
    optional func didTapOnButton(sender: JBButton!)
}

/// The configurable button
@IBDesignable
public class JBButton: UIView {
    
    /// Delegate typed as the `ConfigurableButtonDelegate` protocol
    public weak var delegate: JBButtonDelegate?
    
    /// Workaround: Xcode doesn't allow us to connect any protocol based delegate.
    @IBOutlet private weak var ibDelegate: AnyObject? {
        get { return delegate }
        set { delegate = newValue as? JBButtonDelegate }
    }
    
    /// Inspectable: text to be displayed
    @IBInspectable public var title: String? = "Hit me!"
    /// Inspectable: color of the text
    @IBInspectable public var titleColor: UIColor = UIColor.blackColor()
    /// Inspectable: alignment of the text. Treat as `NSTextAlignment.<alignment>.rawValue`
    @IBInspectable public var titleAlignment: Int = 1
    
    /// Inspectable: image to be displayed
    @IBInspectable public var image: UIImage?
    /// Inspectable: color of the image, if rendered as template
    @IBInspectable public var imageColor: UIColor = UIColor.blackColor()
    /// Inspectable: rendering mode of the image
    /// - 0 for `.Original`
    /// - 1 for `.Template`
    @IBInspectable public var imageRenderingMode: Int {
        get {
            return self.renderingMode.rawValue
        }
        set(idx) {
            self.renderingMode = RenderingMode(rawValue: idx) ?? .original
        }
    }
    /// Inspectable: position of the image in the button
    /// - 0 for `.Top`
    /// - 1 for `.Bottom`
    /// - 2 for `.Left`
    /// - 3 for `.Right`
    /// - 4 for `.Centered`
    @IBInspectable public var imagePosition: Int {
        get {
            return self.positionValue.rawValue
        }
        set(idx) {
            self.positionValue = Position(rawValue: idx) ?? .top
            self.originalPosition = positionValue
        }
    }
    
    /**
     Enum representing the rendering modes of the image
     
     - original: draws the image as is
     - template: templatizes the image
     */
    internal enum RenderingMode: Int {
        case original = 0
        case template = 1
    }
    /// Selected rendering mode of the image
    internal var renderingMode = RenderingMode.original
    
    /**
     Enum representing the positions of the image
     
     - Top:      above the label
     - Bottom:   underneath the label
     - Left:     to the left of the label
     - Right:    to the right of the label
     - Centered: centered, no label
     */
    internal enum Position: Int {
        case top = 0
        case bottom = 1
        case left = 2
        case right = 3
        case centered = 4
    }
    /// Selected position of the image
    internal var positionValue = Position.top
    
    /// Inspectable: corner radius of the button
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = cornerRadius > 0
        }
    }
    /// Inspectable: border width of the button
    @IBInspectable public var borderWidth: CGFloat = 1 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    /// Inspectable: border color of the button
    @IBInspectable public var borderColor: UIColor = UIColor.blackColor() {
        didSet {
            self.layer.borderColor = borderColor.CGColor
        }
    }
    
    /// Inspectable: padding of the button
    @IBInspectable public var padding: CGFloat = 0.0 {
        didSet {
            self.customPadding = (fabs(self.padding) > CGFloat(FLT_EPSILON) && self.padding > CGFloat(FLT_EPSILON) ? self.padding : 0.0)
        }
    }
    
    /// Inspectable: determines whether the button should highlight on tap
    @IBInspectable public var highlight: Bool = true
    /// Original background color of the button
    internal var originalBackgroundColor: UIColor? = UIColor.whiteColor()
    /// Selected padding of the button
    internal var customPadding: CGFloat = 0.0
    /// Label of the title inside the button
    internal(set) var titleLabel: UILabel? = UILabel(frame: CGRect.zero)
    /// Image view inside the button
    private(set) var imageView: UIImageView? = UIImageView(frame: CGRect.zero)
    /// Font of the text
    internal var customFont: UIFont? = UIFont.systemFontOfSize(15)
    
    // MARK:- Animation properties
    
    /// Custom touches began animations - user defined
    public var customTouchesBeganAnimations: CAAnimationGroup?
    /// Custom touches ended animations - user defined
    public var customTouchesEndedAnimations: CAAnimationGroup?
    /// Custom loading animations - user defined
    public var customLoadingAnimations: CAAnimationGroup?
    
    // MARK:- Loading properties
    
    /// Determines whether the title should be hidden while the loading animation is performing
    public var hideTitleOnLoad: Bool = false
    /// Original position of the image
    internal var originalPosition: Position = .top
    /// Loading state of the button
    /// - `true` if the button is loading
    /// - `false` otherwise
    internal(set) public var isLoading: Bool = false
    /// Default loader
    private var defaultLoader = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    /// Custom loader, as a replacment of the default loader - user defined
    internal var customLoader: UIView? = nil
    /// Custom loader start animating block
    internal var customLoaderStart: (Void -> ())? = nil
    /// Custom loader stop animating block
    internal var customLoaderStop: (Void -> ())? = nil
    
    
    // MARK:- Init
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initialization()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    //internal var borderView: UIView! = UIView()
    
    /**
     Private custom convenient initializer
     */
    private func initialization() {
        if self.backgroundColor == nil {
            self.backgroundColor = UIColor.whiteColor()
        }
        
        self.originalBackgroundColor = self.backgroundColor
        
        if self.imageView != nil {
            self.defaultLoader.center = (self.imageView?.center)!
        }
    }
    
    override public func prepareForInterfaceBuilder() {
        self.titleLabel?.text = self.title
        self.titleLabel?.textAlignment = NSTextAlignment(rawValue: NSInteger(self.titleAlignment)) ?? .Center
        self.layer.cornerRadius = self.cornerRadius
        self.layer.masksToBounds = self.cornerRadius > 0
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor.CGColor
    }
    
    /**
     Sets the font of the title
     
     - parameter font: the font to apply to the title
     */
    public func setTitleFont(font: UIFont) {
        self.customFont = font
        self.setNeedsDisplay()
    }
    
    /**
     Set the title, if it needs to be changed in some ways
     
     - parameter title: the font to apply to the title
     */
    public func setTitleText(title: String) {
        self.title = title
        self.setNeedsDisplay()
    }
}
