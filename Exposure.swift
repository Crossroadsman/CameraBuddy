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

let nikon50_14WideOpen = Exposure(aperture: 1.4, shutter: 1/250, iso: 100)
let nikon50_14At28 = Exposure(aperture: 2.8, shutter: 1/250, iso: 100)

Exposure(aperture: 1.4, shutter: 1/125, iso: 100).lv
Exposure(aperture: 2.8, shutter: 1/125, iso: 100).lv
Exposure(aperture: 1.4, shutter: 1/125, iso: 100).lv
Exposure(aperture: 1, shutter: 1, iso: 100).ev
Exposure(aperture: 1, shutter: 1, iso: 100).lv

nikon50_14WideOpen.compared(to: nikon50_14At28)
