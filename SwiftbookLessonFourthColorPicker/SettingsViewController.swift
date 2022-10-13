//
//  ViewController.swift
//  SwiftbookLessonFourthColorPicker
//
//  Created by Supodoco on 23.09.2022.
//

import UIKit



class SettingsViewController: UIViewController {
    
    @IBOutlet var coloredView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSliderOutlet: UISlider!
    @IBOutlet var greenSliderOutlet: UISlider!
    @IBOutlet var blueSliderOutlet: UISlider!
    
    @IBOutlet var redColorTextField: UITextField!
    @IBOutlet var greenColorTextField: UITextField!
    @IBOutlet var blueColorTextField: UITextField!
    
    var color: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coloredView.layer.cornerRadius = 10
        
        let ciColor = CIColor(color: color)
        redSliderOutlet.value = Float(ciColor.red)
        greenSliderOutlet.value = Float(ciColor.green)
        blueSliderOutlet.value = Float(ciColor.blue)
        
        changeColor()
        lineConfigure(slider: redSliderOutlet, label: redLabel, textField: redColorTextField)
        lineConfigure(slider: greenSliderOutlet, label: greenLabel, textField: greenColorTextField)
        lineConfigure(slider: blueSliderOutlet, label: blueLabel, textField: blueColorTextField)
        
        textFieldsDelegate()
        addDoneButtonOnKeyboard()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func doneButtonPressed() {
        guard let color = coloredView.backgroundColor else { return }
        delegate.setColor(for: color)
        dismiss(animated: true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        changeColor()
        switch sender {
        case redSliderOutlet:
            lineConfigure(slider: redSliderOutlet,
                          label: redLabel,
                          textField: redColorTextField)
        case greenSliderOutlet:
            lineConfigure(slider: greenSliderOutlet,
                          label: greenLabel,
                          textField: greenColorTextField)
        default:
            lineConfigure(slider: blueSliderOutlet,
                          label: blueLabel,
                          textField: blueColorTextField)
        }
    }
    
    private func lineConfigure(slider: UISlider, label: UILabel, textField: UITextField) {
        label.text = string(from: slider)
        textField.text = self.string(from: slider)
    }
    
    private func textFieldsDelegate() {
        redColorTextField.delegate = self
        greenColorTextField.delegate = self
        blueColorTextField.delegate = self
    }
    
    private func addDoneButtonOnKeyboard() {
        let doneToolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneButtonAction)
        )
        
        doneToolbar.items = [flexSpace, doneButton]
        doneToolbar.sizeToFit()
        
        redColorTextField.inputAccessoryView = doneToolbar
        greenColorTextField.inputAccessoryView = doneToolbar
        blueColorTextField.inputAccessoryView = doneToolbar
    }
    
    @objc private func doneButtonAction() {
        view.endEditing(true)
    }
    
    private func changeColor() {
        coloredView.backgroundColor = UIColor(
            red:   CGFloat(redSliderOutlet.value),
            green: CGFloat(greenSliderOutlet.value),
            blue:  CGFloat(blueSliderOutlet.value),
            alpha: 1
        )
    }
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text,
              let numberValue = Double(newValue),
              numberValue <= 1 && numberValue >= 0
        else {
            textField.shake()
            showAlert(
                with: "Incorrect data format",
                and: "Try using only numbers from 0 to 1",
                handler: textField
            )
            return
        }
        textField.text = String(format: "%.2f", numberValue)
        switch textField {
        case redColorTextField:
            redSliderOutlet.setValue(Float(numberValue), animated: true)
            redLabel.text = string(from: redSliderOutlet)
        case greenColorTextField:
            greenSliderOutlet.setValue(Float(numberValue), animated: true)
            greenLabel.text = string(from: greenSliderOutlet)
        default:
            blueSliderOutlet.setValue(Float(numberValue), animated: true)
            blueLabel.text = string(from: blueSliderOutlet)
        }
        changeColor()
    }
}

extension UIViewController {
    func showAlert(with title: String, and message: String, handler: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { _ in
            handler?.text = ""
        }
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -10.0, 10.0, -7.0, 7.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
