//
//  CameraTextField.swift
//  CameraBuddy
//
//  Created by Alex Koumparos on 2016-10-22.
//  Copyright © 2016 Koumparos Software. All rights reserved.
//

import UIKit

extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
}
