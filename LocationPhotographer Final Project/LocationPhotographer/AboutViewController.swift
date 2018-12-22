//
//  AboutViewController.swift
//  Project #3
//
//  Created by Adeel Qayum on 11/22/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var aboutNameLabel: UILabel!
    
    @IBOutlet weak var aboutVersionNumber: UILabel!
    
    @IBOutlet weak var aboutBundleNumber: UILabel!
    
    @IBOutlet weak var aboutCopyrightLabel: UILabel!
    
    @IBOutlet weak var aboutAccessLabel: UILabel!
    
    @IBOutlet weak var aboutLaunchLabel: UILabel!
    
    var colorArray = [UIColor(red: 164/255.0, green: 224/255.0, blue: 233/255.0, alpha: 1), UIColor(red: 244/255.0, green: 243/255.0, blue: 215/255.0, alpha: 1), UIColor(red: 230/255.0, green: 236/255.0, blue: 248/255.0, alpha: 1), UIColor.red, UIColor.brown, UIColor.green, UIColor.gray]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            aboutNameLabel.text = name
        }
        
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            aboutVersionNumber.text = version
        }
        
        if let bundle = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
            aboutBundleNumber.text = bundle
        }
        
        
        if let copyright = Bundle.main.object(forInfoDictionaryKey: "NSHumanReadableCopyright") as? String {
            aboutCopyrightLabel.text = copyright
        }
        
        if let access = UserDefaults.standard.value(forKey: "YourDefaultKey") as? Date {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM-dd-yyyy HH:mm:ss"
            
            let myString = formatter.string(from: access) // string purpose I add here
            let yourDate = formatter.date(from: myString)
            let string = formatter.string(from: yourDate!)
            
            aboutAccessLabel.text = string
        }
        
        if let launches = String(UserDefaults.standard.integer(forKey: "launchCount")) as? String {
            aboutLaunchLabel.text = launches
        }
        
        self.view.backgroundColor = UIColor(red: 230/255.0, green: 236/255.0, blue: 248/255.0, alpha: 1)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        
        
    }
    
    @objc func doubleTapped() {
        let currentIndex = colorArray.index(of: self.view.backgroundColor!)
        let newColor = getNextColor(index: currentIndex!)
        self.view.backgroundColor = newColor
    }
    
    func getNextColor(index: Int) -> UIColor {
        var newIndex = index + 1
        if (newIndex > (colorArray.count - 1)) {
            newIndex = 0
        }
        return colorArray[newIndex]
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
