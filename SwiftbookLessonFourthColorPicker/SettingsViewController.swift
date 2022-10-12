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
        
        redSliderOutlet.value = Float(color.rgba.red)
        greenSliderOutlet.value = Float(color.rgba.green)
        blueSliderOutlet.value = Float(color.rgba.blue)
        
        changeColor()
        redLineConfigure()
        greenLineConfigure()
        blueLineConfigure()
        
        textFieldsDelegate()
        addDoneButtonOnKeyboard()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
            redLineConfigure()
        case greenSliderOutlet:
            greenLineConfigure()
        default:
            blueLineConfigure()
        }
    }
    
    private func redLineConfigure() {
        redLabel.text = string(from: redSliderOutlet)
        redColorTextField.text = string(from: redSliderOutlet)
    }
    
    private func greenLineConfigure() {
        greenLabel.text = string(from: greenSliderOutlet)
        greenColorTextField.text = string(from: greenSliderOutlet)
    }
    
    private func blueLineConfigure() {
        blueLabel.text = string(from: blueSliderOutlet)
        blueColorTextField.text = string(from: blueSliderOutlet)
    }
    
    private func textFieldsDelegate() {
        redColorTextField.delegate = self
        greenColorTextField.delegate = self
        blueColorTextField.delegate = self
    }
    
    private func addDoneButtonOnKeyboard() {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
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

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text,
              let numberValue = Double(newValue),
              numberValue <= 1 && numberValue >= 0
        else {
            showAlert(
                with: "Incorrect data format",
                and: "Try using only numbers from 0 to 1",
                handler: textField
            )
            return
        }
        switch textField {
        case redColorTextField:
            redSliderOutlet.value = Float(numberValue)
            redLabel.text = string(from: redSliderOutlet)
        case greenColorTextField:
            greenSliderOutlet.value = Float(numberValue)
            greenLabel.text = string(from: greenSliderOutlet)
        default:
            blueSliderOutlet.value = Float(numberValue)
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
