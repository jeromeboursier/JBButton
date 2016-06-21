# JBButton

JBButton is a configurable and animatable button written in Swift. It provides a loading state, fully customizable, in order to avoid using blocking huds.

![Connect](https://dl.dropboxusercontent.com/u/29777458/JBButton/Connect50.png) 
![Facebook](https://dl.dropboxusercontent.com/u/29777458/JBButton/Facebook50.png) 
![Go!](https://dl.dropboxusercontent.com/u/29777458/JBButton/Go!50.png) 
![KeepBrowsing](https://dl.dropboxusercontent.com/u/29777458/JBButton/KeepBrowsing50.png) 
![Key](https://dl.dropboxusercontent.com/u/29777458/JBButton/Key50.png) 
![LogIn](https://dl.dropboxusercontent.com/u/29777458/JBButton/LogIn50.png)  
![PinIt](https://dl.dropboxusercontent.com/u/29777458/JBButton/PinIt50.png) 
![Tweet](https://dl.dropboxusercontent.com/u/29777458/JBButton/Tweet50.png) 


## Features

- [x] Configurable directly in Interface Builder (IBDesignable)
- [x] Delegate method to handle tap gesture
- [x] Animatable touches began and ended
- [x] Handle loading state / provides a default loader
- [x] Easy to use methods

## Requirements

- iOS 8.0+
- Xcode 7.3+

---

## Installation

### 📦CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

If no pods are installed, you can setup yout project with the following command:
It will create a brand new `Podfile` in your project
```bash
$ pod init
```

To integrate JBButton into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'JBButton'
end
```

Then, run the following command:

```bash
$ pod install
```

### ✋Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate JBButton into your project manually by downloading the `JBButton.framework` and adding it into your projet.

---

## Usage

### Creating a simple JBButton

#### 1. Add a UIView

Drag and drop a UIView in the ViewController you want to add a JBButton. In the Identity inspector, set it as a `JBButton` custom class and press `Enter`. It'll automagically set the right module for you. 
Then, just customise it in the Attributes inspector! As the button is an IBDesignable component, most of the layouting can be done throughout the storyboard. Check out the simple example below.

Interface builder | Result
------------ | -------------
![IBDesignable](https://dl.dropboxusercontent.com/u/29777458/JBButton/IBDesignable.png) | ![Tweet](https://dl.dropboxusercontent.com/u/29777458/JBButton/Tweet.png)


#### 2. Declare it in your View Controller
**Don't forget to import the `JBButton` first** 🙃

Depending on the language you are working on:

```swift
@IBOutlet weak var tweet: JBButton!
```

or

```objective-C
@property(nonatomic, weak) IBOutlet JBButton *tweet;
```

**If you want to interact with the button**, you class may extends the `JBButtonDelegate` protocol, in order to handle the `didTapOnButton(:)` method, and the `delegate` can be set either in code or in the interface builder.


#### 3. 👀Inspectables explained
There's plenty of `IBInspectables` in the interface builder. You can take a look at the code documentation for more details, or refer to this table.

Inspectable | Type | Documentation | Default value
------------ | ------------- | ------------- | -------------
`title` | String? | Text to be displayed | `"Hit me!"`
`titleColor` | UIColor | Color of the text | `UIColor.blackColor()`
`titleAlignment` | Int | Alignment of the text. Treat as `NSTextAlignment.<alignment>.rawValue` | `1` (i.e. `NSTextAlignmentCenter`)
`image` | UIImage? | Image to be displayed | No default value
`imageColor`| UIColor | Color of the image, if rendered as template | `UIColor.blackColor()`
`imageRenderingMode` | Int | Rendering mode of the image.<br> `0` for `.Original`<br> `1` for `.Template` | `0`
`imagePosition`| Int | Position of the image in the button.<br>`0` for `.Top`<br>`1` for `.Bottom`<br>`2` for `.Left`<br>`3` for `.Right`<br>`4` for `.Centered` | `0`
`cornerRadius`| CGFloat | Corner radius of the button | `0`
`borderWidth` | CGFloat | Border width of the button | `1`
`borderColor` | UIColor | Border color of the button | `UIColor.blackColor()`
`padding` | CGFloat | Padding of the button | `0`
`highlight` | Bool | Determines whether the button should highlight on tap | `true`
    
 In the example below, <br>`imageRenderingMode` is set as template, <br>`imagePosition` is set to top, <br>`highlight` to true, ...
    
Quick tap | Longer tap
------------ | -------------
![TweetTap](https://dl.dropboxusercontent.com/u/29777458/JBButton/TweetTap.gif) |![TweetTapLong](https://dl.dropboxusercontent.com/u/29777458/JBButton/TweetTapLong.gif)

#### 4. 👀Accessible properties and methods

Property or method | Documentation 
------------ | -------------
`delegate: JBButtonDelegate?` | The delegate of the button. Can be set either in code or in IB.
`customTouchesBeganAnimations: CAAnimationGroup?` | The custom touches began animation group. Set it in code.
`customTouchesEndedAnimations: CAAnimationGroup?` | The custom touches ended animation group. Set it in code.
`customLoadingAnimations: CAAnimationGroup?` | The custom loading animation group. Set it in code.
`hideTitleOnLoad: Bool` | Tells the button whether to hide the title on load or not.
`isLoading: Bool` | Tells you if the button is in a loading state or not.
`setTitleFont(font: UIFont)` | To set a custom font for the title.
`setTitleText(title: String)` | To set a new title.


### Animations
Animating the button has been made simply. You can set properties such as `customTouchesBeganAnimations` or `customTouchesEndedAnimations` to pass `CAAnimationGroup`.

_Example:_

```swift
// Scale animation
let scaleDown = CASpringAnimation(keyPath: "transform.scale")
scaleDown.damping = 0.4
scaleDown.initialVelocity = 12.0
scaleDown.fromValue = 1.0
scaleDown.toValue = 0.9

// Group set to customTouchesBeganAnimations
let group = CAAnimationGroup()
group.animations = [scaleDown]
group.duration = 0.35
group.fillMode = kCAFillModeForwards
group.removedOnCompletion = false
self.pinIt.customTouchesBeganAnimations = group

// Reverse scale animation
let scaleUp = CASpringAnimation(keyPath: "transform.scale")
scaleUp.damping = 0.4
scaleUp.initialVelocity = 12.0
scaleUp.fromValue = 0.9
scaleUp.toValue = 1.0

// Rotation animation
let rotate = CABasicAnimation(keyPath: "transform.rotation")
rotate.fillMode = kCAFillModeBoth
rotate.toValue = (360 * M_PI / 180)

// Group set to customTouchesEndedAnimations
let group2 = CAAnimationGroup()
group2.animations = [scaleUp, rotate]
group2.duration = 0.35
group2.fillMode = kCAFillModeForwards
group2.removedOnCompletion = false 
self.pinIt.customTouchesEndedAnimations = group2
```

_Result:_

![PinItAnimated](https://dl.dropboxusercontent.com/u/29777458/JBButton/PinItAnimated.gif)

### Loading
The button can be used to avoid annoying HUDS. It provides convenient methods to handle long loading processes.
It can be quite well customized, but examples will speak for themselves.

#### Examples

##### 1. Simple button with default loader - Sign in with Facebook

###### 1.1. What do we want?
> A simple Facebook sign in button containing a text and the Facebook logo. We want it to be _"loading"_ while the connexion process is running. 

The default behaviour of the component is to replace the image with a `UIActivityIndicatorView`.

###### 1.2. Result
![FacebookLoader](https://dl.dropboxusercontent.com/u/29777458/JBButton/FacebookLoader.gif)

###### 1.3. Sample code
Not quite much to do... For this kind of need, IB is enough.

To activate the _"loading state"_ you just need to implement the delegate method `didTapOnButton(:)` with the following:

```swift 
func didTapOnButton(sender: JBButton!) {
	if sender == self.signInWithFacebook {
		sender.startLoading(withTitle: "Signing in")
	}
}
```
The method `startLoading(:)` with no more configuration will replace the image with the default loader, and the title will be replaced. You can fire that method without the `withTitle`parameter.

###### 1.4. Alternative
In the `viewDidLoad(:)`, you can tell the button to
```swift 
self.signInWithFacebook.hideTitleOnLoad = true
```
In that particular scenario, the text will be hidden while loading, and the loader will be centered.

![FacebookLoaderNoText](https://dl.dropboxusercontent.com/u/29777458/JBButton/FacebookLoaderNoText.gif)

##### 2. Simple button with custom loader - 1Password connect
###### 2.1. What do we want?
> A simple 1Password connect button containig a text and the 1Password logo. We want it to be _"loading"_ while the connexion process is running. We want to add a custom loader.

###### 2.2. Result
![OnePasswordLoader](https://dl.dropboxusercontent.com/u/29777458/JBButton/OnePasswordLoader.gif)

###### 2.3. Sample code
```swift 
// Creating a custom indicator
let indicator = NVActivityIndicatorView(frame: CGRect.zero, type: NVActivityIndicatorType.Pacman, color: UIColor.whiteColor(), padding: 0)
// Setting it to the button
self.onePassword.setCustomLoader(indicator, startAnimationBlock: { () in
	indicator.startAnimation()
}, stopAnimationBlock: { () in
	indicator.stopAnimation()
})

// Set the font
self.onePassword.setTitleFont(UIFont(name: "Menlo-Regular", size: 18)!)
```

⚠️🎵**Note #1:** When the custom indicator is created, the frame is set to `CGRect.zero`. It'll let the button calculate the frame automatically.⚠️

⚠️🎵**Note #2:** When the custom indicator is created, the start and stop methods must be defined in the `startAnimationBlock` and the `stopAnimationBlock` for the button to be able to properly start and stop animating. Here, I used the wonderful pod from @ninjaprox [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView). These indicators responds to custom start and stop methods `startAnimation()` and `stopAnimations()`.⚠️

```swift 
func didTapOnButton(sender: JBButton!) {
	if sender == self.onePassword {
		sender.startLoading()
	}
}
```

###### 2.4. Alternative
In the `viewDidLoad(:)`, you can tell the button to

```swift 
self.onePassword.hideTitleOnLoad = true
```

In that particular scenario, the text will be hidden while loading, and the loader will be centered (if the frame is set to `CGRect.zero`).

![OnePasswordLoaderNoText](https://dl.dropboxusercontent.com/u/29777458/JBButton/OnePasswordLoaderNoText.gif)

##### 3. Random animation on an image based button - Key button
###### 3.1. What do we want?
> A bordered button containing just an image. We want the _"loading"_ process to be **animated** - like really 👯👯.

###### 3.2. Result
![KeyLoader](https://dl.dropboxusercontent.com/u/29777458/JBButton/KeyLoader.gif)

###### 3.3. Sample code
```swift 
// Pulse animation
let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
pulseAnimation.duration = 2
pulseAnimation.toValue = 1.15

// Rotate animation
let rotateLayerAnimation = CABasicAnimation(keyPath: "transform.rotation")
rotateLayerAnimation.duration = 0.5
rotateLayerAnimation.beginTime = 0.5
rotateLayerAnimation.fillMode = kCAFillModeBoth
rotateLayerAnimation.toValue = (360 * M_PI / 180)

// Group set to customLoadingAnimations
let group = CAAnimationGroup()
group.animations = [pulseAnimation, rotateLayerAnimation]
group.duration = 2
group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
group.autoreverses = true
group.repeatCount = FLT_MAX
self.key.customLoadingAnimations = group
```

```swift 
func didTapOnButton(sender: JBButton!) {
	if sender == self.key {
		sender.startLoading()
	}
}
```

##### 4. Black & shadowed button - Go! button
###### 4.1. What do we want?
> A black button titled "Go!". We want it to have a shadow. We want the _"loading"_ state to be discrete, with a custom nice loader. We want the shadow to disappear when we tap the button, and to reappear when we stop tapping the button - animated, of course.

###### 4.2. Result
![GoLoader](https://dl.dropboxusercontent.com/u/29777458/JBButton/GoLoader.gif)

###### 4.3. Sample code
```swift 
// Set the title font
self.go.setTitleFont(UIFont(name: "Copperplate-Light", size: 18.0)!)

// Hide the shadow on tap
let hideShadowAnimation = CABasicAnimation(keyPath: "shadowOpacity")
hideShadowAnimation.fromValue = 0.5
hideShadowAnimation.toValue = 0

let hideShadow = CAAnimationGroup()
hideShadow.animations = [hideShadowAnimation]
hideShadow.duration = 0.2
hideShadow.fillMode = kCAFillModeForwards
hideShadow.removedOnCompletion = false
self.go.customTouchesBeganAnimations = hideShadow

// Show the shadow when tap stops
let showShadowAnimation = CABasicAnimation(keyPath: "shadowOpacity")
showShadowAnimation.fromValue = 0
showShadowAnimation.toValue = 0.5

let showShadow = CAAnimationGroup()
showShadow.animations = [showShadowAnimation]
showShadow.duration = 0.2
showShadow.fillMode = kCAFillModeForwards
showShadow.removedOnCompletion = false
self.go.customTouchesEndedAnimations = showShadow

// Add a shadow
self.go.layer.masksToBounds = false
self.go.layer.shadowColor = UIColor.blackColor().CGColor
self.go.layer.shadowOffset = CGSize(width: 5, height: 5)
self.go.layer.shadowOpacity = 0.5

// Add a custom loader
let indicator = NVActivityIndicatorView(frame: CGRect.zero, type: NVActivityIndicatorType.BallPulseSync, color: UIColor.whiteColor(), padding: 0)
self.go.setCustomLoader(indicator, startAnimationBlock: { () in
    indicator.startAnimation()
    }, stopAnimationBlock: { () in
indicator.stopAnimation()
})
```

```swift 
func didTapOnButton(sender: JBButton!) {
	if sender == self.go {
		sender.startLoading()
	}
}
```

###### 4.4. ⚠️Troubleshooting
To add a shadow that way to a UIView, it may not have a rounded corner. In order to add a shadow to a rounded UIView, please refer to the next example.


##### 5. Gradiant layered-rounded-shadowed-animated button - Log in button
###### 5.1. What do we want?
> Basically, a button. But... We want it to have a gradiant layer, to be rounded, to have a shadow, to be animated while loading, animated while tapping, and to contain a custom login button. That's quite simple right? 👯💃

###### 5.2. Result
![GradiantLoader](https://dl.dropboxusercontent.com/u/29777458/JBButton/GradiantLoader.gif)

###### 5.3. Sample code
As I want to have a rounded and shadowed button, I needed to embbed the `JBButton` in a UIView of the same size in the IB.

```swift 
// Set the title font
self.gradientLogin.setTitleFont(UIFont(name: "AmericanTypewriter-Bold", size: 18.0)!)

// Create a gradiant layer
let c1 = UIColor(red: 0/255, green: 161/255, blue: 0/255, alpha: 1)
let c2 = UIColor(red: 0/255, green: 161/255, blue: 255/255, alpha: 1)
let gradientLayer = CAGradientLayer()
gradientLayer.frame = self.gradientLogin.bounds
gradientLayer.colors = [c1.CGColor, c2.CGColor]
gradientLayer.startPoint = CGPoint(x: 0, y: 0)
gradientLayer.endPoint = CGPoint(x: 1, y: 1)
self.gradientLogin.layer.addSublayer(gradientLayer)
// Rounded
self.gradientLogin.cornerRadius = 25

// Add the custom indicator
let indicator = NVActivityIndicatorView(frame: CGRect.zero, type: NVActivityIndicatorType.LineScalePulseOut, color: UIColor.whiteColor(), padding: 0)
self.gradientLogin.setCustomLoader(indicator, startAnimationBlock: { () in
    indicator.startAnimation()
    }, stopAnimationBlock: { () in
indicator.stopAnimation()
})

// Add a shadow to the container view
self.gradientLoginContainer.layer.masksToBounds = false
self.gradientLoginContainer.layer.shadowColor = UIColor.blackColor().CGColor
self.gradientLoginContainer.layer.shadowOffset = CGSize(width: 5, height: 5)
self.gradientLoginContainer.layer.shadowOpacity = 0.5

// Scale animation
let scaleSmallAnimation = CASpringAnimation(keyPath: "transform.scale")
scaleSmallAnimation.fromValue = 1.0
scaleSmallAnimation.toValue = 0.9
scaleSmallAnimation.damping = 0.4
scaleSmallAnimation.initialVelocity = 12.0
// Group set to customTouchesBeganAnimations
let touchesBegan = CAAnimationGroup()
touchesBegan.animations = [scaleSmallAnimation]
touchesBegan.duration = 0.2
touchesBegan.fillMode = kCAFillModeForwards
touchesBegan.removedOnCompletion = false
self.gradientLogin.customTouchesBeganAnimations = touchesBegan

// Scale animation
let scaleBigAnimation = CASpringAnimation(keyPath: "transform.scale")
scaleBigAnimation.fromValue = 0.9
scaleBigAnimation.toValue = 1.0
scaleBigAnimation.damping = 0.4
scaleBigAnimation.initialVelocity = 12.0
// Group set to customTouchesEndedAnimations
let touchesEnded = CAAnimationGroup()
touchesEnded.animations = [scaleBigAnimation]
touchesEnded.duration = 0.2
touchesEnded.fillMode = kCAFillModeForwards
touchesEnded.removedOnCompletion = false
self.gradientLogin.customTouchesEndedAnimations = touchesEnded

// Pulse animation
let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
pulseAnimation.duration = 2
pulseAnimation.toValue = 0.85
// Group set to customLoadingAnimations
let group = CAAnimationGroup()
group.animations = [pulseAnimation]
group.duration = 2
group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
group.autoreverses = true
group.repeatCount = FLT_MAX
self.gradientLogin.customLoadingAnimations = group
```

```swift 
func didTapOnButton(sender: JBButton!) {
	if sender == self.gradientLogin {
		sender.startLoading()
	}
}
```
