//
//  ViewController.swift
//  SwiftbookLessonFourthColorPicker
//
//  Created by Supodoco on 23.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var coloredView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSwitchOutlet: UISlider!
    @IBOutlet var greenSwitchOutlet: UISlider!
    @IBOutlet var blueSwitchOutlet: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coloredView.layer.cornerRadius = 10
        changeColor()
    }
    
    @IBAction func redSwitchAction() {
        redLabel.text = String(format: "%.2f", redSwitchOutlet.value)
        changeColor()
    }
    @IBAction func greenSwitchAction() {
        greenLabel.text = String(format: "%.2f", greenSwitchOutlet.value)
        changeColor()
    }
    @IBAction func blueSwitchAction() {
        blueLabel.text = String(format: "%.2f", blueSwitchOutlet.value)
        changeColor()
    }
    
    private func changeColor() {
        coloredView.backgroundColor = UIColor(
            red:   CGFloat(redSwitchOutlet.value),
            green: CGFloat(greenSwitchOutlet.value),
            blue:  CGFloat(blueSwitchOutlet.value),
            alpha: 1
        )
    }
}

