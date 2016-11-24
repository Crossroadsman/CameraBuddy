//
//  ViewController.swift
//  CameraBuddy
//
//  Created by Alex Koumparos on 2016-10-22.
//  Copyright © 2016 Koumparos Software. All rights reserved.
//

import UIKit

enum Item {
    case a
    case b
}

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // MARK: - Properties
    // ------------------
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var currentItem = Item.a
    var exposureA = Exposure(aperture: 1.0, shutter: 1.0, iso: 100)
    var exposureB = Exposure(aperture: 1.0, shutter: 1.0, iso: 100)
    
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
        
        // create a tap gesture recognizer to identify taps outside of the number pad
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: "didTapView")
        self.view.addGestureRecognizer(tapRecognizer)
        
        // make VC the delegate of the textfields
        apertureATextField.delegate = self
        apertureBTextField.delegate = self
        isoATextField.delegate = self
        isoBTextField.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    // -----------------
    @IBAction func didEndEditingApertureA(_ sender: UITextField) {
        
        print (sender.text)
        if let text = sender.text, let asDouble = Double(text) {
            print("updating apertureA to \(asDouble)")
            exposureA.aperture = asDouble
            updateUI()
        }
        
    }
    
    @IBAction func didEndEditingApertureB(_ sender: UITextField) {
        
        print (sender.text)
        if let text = sender.text, let asDouble = Double(text) {
            print("updating apertureB to \(asDouble)")
            exposureB.aperture = asDouble
            updateUI()
        }
    }
    
    @IBAction func didEndEditingIsoA(_ sender: UITextField) {
        
        print (sender.text)
        if let text = sender.text, let asDouble = Double(text) {
            print("updating isoA to \(asDouble)")
            exposureA.iso = asDouble
            updateUI()
        }
    }
    
    @IBAction func didEndEditingIsoB(_ sender: UITextField) {
        
        print (sender.text)
        if let text = sender.text, let asDouble = Double(text) {
            print("updating isoB to \(asDouble)")
            exposureB.iso = asDouble
            updateUI()
        }
    }
    
    
    @IBAction func shutterAButtonTapped(_ sender: AnyObject) {
        shutterSpeedPicker.isHidden = false
        currentItem = .a
    }
    
    @IBAction func shutterBButtonTapped(_ sender: AnyObject) {
        shutterSpeedPicker.isHidden = false
        currentItem = .b
    }
    
    // MARK: - UIPickerviewDelegateMethods
    // -----------------------------------
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return shutterSpeeds[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch currentItem {
        case .a:
            shutterA = ShutterSpeed(name: shutterSpeeds[row].name, seconds: shutterSpeeds[row].seconds)
            shutterAButton.setTitle(shutterA.name, for: .normal)
            exposureA.shutter = shutterA.seconds
        case .b:
            shutterB = ShutterSpeed(name: shutterSpeeds[row].name, seconds: shutterSpeeds[row].seconds)
            shutterBButton.setTitle(shutterB.name, for: .normal)
            exposureB.shutter = shutterB.seconds
        default:
            print("error, currentExposure should always be .a or .b")
        }
        shutterSpeedPicker.isHidden = true
        updateUI()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return shutterSpeeds.count
    }
    
    // MARK: - Textfield Delegate Methods
    // ----------------------------------
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Other Methods
    // ---------------------
    func updateUI() {
        evALabel.text = String(format: "%.2f", exposureA.ev)
        evBLabel.text = String(format: "%.2f", exposureB.ev)
        lvALabel.text = String(format: "%.2f", exposureA.lv)
        lvBLabel.text = String(format: "%.2f", exposureB.lv)
    }
    
    func didTapView() {
        self.view.endEditing(true)
    }
    
    


}

