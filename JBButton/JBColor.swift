//
//  JBColor.swift
//  JBButton
//
//  Created by Jérôme Boursier on 17/06/2016.
//  Copyright © 2016 Jérôme Boursier. All rights reserved.
//

internal extension UIColor {
    
    /**
     Returs a darker color on the color we are working with. Used for a `selected`state.
     
     - returns: a darker color
     */
    func darkerColor() -> UIColor? {
        var h: CGFloat = 0.0, s: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        if (self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)) {
            return UIColor(hue: h, saturation: s, brightness: b * 0.75, alpha: a)
        }
        return nil
    }
}
