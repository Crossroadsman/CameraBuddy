//
//  Exposure.swift
//  CameraBuddy
//
//  Created by Alex Koumparos on 2016-10-24.
//  Copyright © 2016 Koumparos Software. All rights reserved.
//

import Foundation

/// Simple Exposure Class
///
/// Computes EV and LV for specified aperture, shutter speed and (LV only) iso.
/// Has a .compared(to:) method to give the LV comparison of one Exposure
/// to another
class Exposure {
    
    // note f1 for 1 sec has ev=0
    // f1 for 1 sec @ iso100 has lv=0
    
    private var _aperture: Double = 1 // f-number
    private var _shutter: Double = 1 // shutter speed in seconds
    private var _iso: Double = 100 // iso as stated
    
    var aperture: Double {
        get {
            return _aperture
        }
        set {
            _aperture = newValue
        }
    }
    
    var shutter: Double {
        get {
            return _shutter
        }
        set {
            _shutter = newValue
        }
    }
    
    var iso: Double {
        get {
            return _iso
        }
        set {
            _iso = newValue
        }
    }
    
    var ev: Double {
        return log2(pow(aperture, 2) / shutter )
    }
    
    var lv: Double {
        return ev + log2(iso / 100.0)
    }
    
    init(aperture: Double, shutter: Double, iso: Double) {
        _aperture = aperture
        _shutter = shutter
        _iso = iso
    }
    
    
    /// Comparison of EVs
    ///
    /// - parameter to: An Exposure object being compared to
    ///
    /// - returns: The EV difference from self to the compared element (i.e., self is x EV from the comparison)
    /// (lower is more light)
    func compared(to: Exposure) -> Double {
        return self.lv - to.lv
    }
    
    
    
}
