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
    
    
    var textFields = [UITextField]()
    
    // MARK: - ViewController Standard Methods
    // ---------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a tap gesture recognizer to identify taps outside of the number pad
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(ViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
        //delegates
        textFields = [apertureATextField, apertureBTextField, isoATextField, isoBTextField]
        textFields.forEach {$0.delegate = self}

        shutterSpeedPicker.delegate = self
        shutterSpeedPicker.dataSource = self
        
        //configure keyboard
        addDoneButtonToKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    // -----------------
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
    
    //MARK: - TextField Methods
    //-------------------------
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("value: '<\(textField.text)>'")
        
        let text = textField.text!
        
        switch textField {
        case apertureATextField:
            exposureA.aperture = Double(text)!
            updateUI()
        case apertureBTextField:
            exposureB.aperture = Double(text)!
            updateUI()
        case isoATextField:
            exposureA.iso = Double(text)!
            updateUI()
        case isoBTextField:
            exposureB.iso = Double(text)!
            updateUI()
        default:
            fatalError("unknown textField")
        }
        
        //self.view.endEditing(true)
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
    
    /**
     Adds a toolbar which includes a done button to:
     - textfields: the (non-default) keyboard;
     */
    func addDoneButtonToKeyboard() {
        //init toolbar
        let toolbarFrame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30)
        let toolbar = UIToolbar(frame: toolbarFrame)
        
        //define left side empty space so that button appears on right
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        //define the actual button
        //(note that the action has to be a #selector)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        //define the button group
        let arr: [UIBarButtonItem] = [flexSpace, doneButton]
        
        //instantiate button group on toolbar
        toolbar.setItems(arr, animated: false)
        toolbar.sizeToFit()
        
        //assign toolbar as inputAccessoryView to:
        //  - textfields where keyboard is not default
        //  - all textviews
        textFields.forEach {
            if $0.keyboardType != .default {
                $0.inputAccessoryView = toolbar
            }
        }
    }
    
    //need @objc to enable #selector
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }



}

