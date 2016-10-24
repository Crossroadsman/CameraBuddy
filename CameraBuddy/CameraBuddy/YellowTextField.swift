//
//  YellowTextField.swift
//  CameraBuddy
//
//  Created by Alex Koumparos on 2016-10-24.
//  Copyright © 2016 Koumparos Software. All rights reserved.
//

import UIKit

@IBDesignable class YellowTextField: UITextField {

    @IBInspectable var placeholderTextColor: UIColor? {
        didSet {
            
            // textFields have an attributedPlaceholder property.
            // This is the placeholder text in the form of an attributedString
            let rawString = attributedPlaceholder?.string ?? ""
            
            // An attributed string is a string combined with a bunch of attributes (regarding how the text should be rendered)
            // Included among these attributes is the colour of the text.
            let str = NSAttributedString(string: rawString, attributes: [NSForegroundColorAttributeName: placeholderTextColor!])
            attributedPlaceholder = str
        }
    }
}
