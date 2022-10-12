//
//  ColoredPageViewController.swift
//  SwiftbookLessonFourthColorPicker
//
//  Created by Supodoco on 11.10.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setColor(for color: UIColor)
}

class ColoredPageViewController: UIViewController {
    
    @IBOutlet var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editButton.layer.cornerRadius = 10
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.color = view.backgroundColor
        settingsVC.delegate = self
    }
}

extension ColoredPageViewController: SettingsViewControllerDelegate {
    func setColor(for color: UIColor) {
        view.backgroundColor = color
    }
}

