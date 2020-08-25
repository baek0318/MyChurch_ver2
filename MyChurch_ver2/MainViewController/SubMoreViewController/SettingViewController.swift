//
//  SettingViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/25.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class SettingViewController : UIViewController {
    
    @IBOutlet weak var fontChangeSlider: UISlider!
    
    @IBOutlet weak var sizeLabel: UILabel!
    
    private var userDefault : UserDefaults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userDefault = UserDefaults.standard
        setFontChangeSlider()
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func setFontChangeSlider() {
        if userDefault!.float(forKey: "sliderValue") == 0 && userDefault!.float(forKey: "fontSetting") == 0 {
            fontChangeSlider.value = 2
            sizeLabel.font = UIFont.systemFont(ofSize: 17)
        }
        else {
            fontChangeSlider.value = userDefault!.float(forKey: "sliderValue")
            sizeLabel.font = UIFont.systemFont(ofSize: CGFloat(userDefault!.float(forKey: "fontSetting")))
        }
        fontChangeSlider.minimumValue = 0
        fontChangeSlider.maximumValue = 4
        fontChangeSlider.isContinuous = false
        fontChangeSlider.addTarget(self, action: #selector(self.fontChange(sender:)), for: .valueChanged)
    }
    
    @objc func fontChange(sender : UISlider) {
        if sender.value == 0 {
            fontChangeSlider.value = 0
            sizeLabel.font = UIFont.systemFont(ofSize: 13)
            userDefault?.set(sender.value, forKey: "sliderValue")
            userDefault?.set(sizeLabel.font.pointSize, forKey: "fontSetting")
        }
        else if sender.value > 0 && sender.value <= 1.0 {
            sender.value = 1.0
            sizeLabel.font = UIFont.systemFont(ofSize: 15)
            userDefault?.set(sender.value, forKey: "sliderValue")
            userDefault?.set(sizeLabel.font.pointSize, forKey: "fontSetting")
        }
        else if sender.value > 1.0 && sender.value <= 2.0 {
            sender.value = 2.0
            sizeLabel.font = UIFont.systemFont(ofSize: 17)
            userDefault?.set(sender.value, forKey: "sliderValue")
            userDefault?.set(sizeLabel.font.pointSize, forKey: "fontSetting")
        }
        else if sender.value > 2.0 && sender.value <= 3.0 {
            sender.value = 3.0
            sizeLabel.font = UIFont.systemFont(ofSize: 19)
            userDefault?.set(sender.value, forKey: "sliderValue")
            userDefault?.set(sizeLabel.font.pointSize, forKey: "fontSetting")
        }
        else {
            sender.value = 4.0
            sizeLabel.font = UIFont.systemFont(ofSize: 21)
            userDefault?.set(sender.value, forKey: "sliderValue")
            userDefault?.set(sizeLabel.font.pointSize, forKey: "fontSetting")
        }
    }
}
