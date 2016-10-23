//
//  ViewController.swift
//  CameraBuddy
//
//  Created by Alex Koumparos on 2016-10-22.
//  Copyright © 2016 Koumparos Software. All rights reserved.
//

import UIKit

enum Exposure {
    case a
    case b
}

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Properties
    // ------------------
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var currentExposure = Exposure.a
    
    // MARK: - IBOutlets
    // -----------------
    @IBOutlet weak var apertureATextField: UITextField!
    @IBOutlet weak var apertureBTextField: UITextField!
    
    @IBOutlet weak var shutterAButton: UIButton!
    @IBOutlet weak var shutterBButton: UIButton!
    
    @IBOutlet weak var isoATextField: UITextField!
    @IBOutlet weak var isoBTextField: UITextField!
    
    @IBOutlet weak var evALabel: UILabel!
    @IBOutlet weak var evBLabel: UILabel!
    
    @IBOutlet weak var lvALabel: UILabel!
    @IBOutlet weak var lvBLabel: UILabel!
    
    @IBOutlet weak var shutterSpeedPicker: UIPickerView!
    
    // MARK: - ViewController Standard Methods
    // ---------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        shutterSpeedPicker.delegate = self
        shutterSpeedPicker.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    // -----------------
    @IBAction func shutterAButtonTapped(_ sender: AnyObject) {
        shutterSpeedPicker.isHidden = false
        currentExposure = .a
    }
    
    @IBAction func shutterBButtonTapped(_ sender: AnyObject) {
        shutterSpeedPicker.isHidden = false
        currentExposure = .b
    }
    
    // MARK: - UIPickerviewDelegateMethods
    // -----------------------------------
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return shutterSpeeds[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch currentExposure {
        case .a:
            shutterA = ShutterSpeed(name: shutterSpeeds[row].name, seconds: shutterSpeeds[row].seconds)
            shutterAButton.setTitle(shutterA.name, for: .normal)
        case .b:
            shutterB = ShutterSpeed(name: shutterSpeeds[row].name, seconds: shutterSpeeds[row].seconds)
            shutterBButton.setTitle(shutterB.name, for: .normal)
        default:
            print("error, currentExposure should always be .a or .b")
        }
        shutterSpeedPicker.isHidden = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return shutterSpeeds.count
    }


}

