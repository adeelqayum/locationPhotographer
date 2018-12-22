//
//  InformationViewController.swift
//  Project #3
//
//  Created by Adeel Qayum on 11/22/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import Foundation
import UIKit

class InformationViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var locations: Locations!
    var selectedLocation: LocationItem?
    
    var colorArray = [UIColor(red: 164/255.0, green: 224/255.0, blue: 233/255.0, alpha: 1), UIColor(red: 244/255.0, green: 243/255.0, blue: 215/255.0, alpha: 1), UIColor(red: 230/255.0, green: 236/255.0, blue: 248/255.0, alpha: 1), UIColor.red, UIColor.brown, UIColor.green, UIColor.gray]
    
    @IBOutlet weak var locationDetail: UILabel!
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var imageCollection: [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 164/255.0, green: 224/255.0, blue: 233/255.0, alpha: 1)
        
        locationDetail.text = selectedLocation?.title
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)

        
    }
    
    
    @objc  func swiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if (self.tabBarController?.selectedIndex)! < 2
            { // set here  your total tabs
                self.tabBarController?.selectedIndex += 1
            }
        } else if gesture.direction == .right {
            if (self.tabBarController?.selectedIndex)! > 0 {
                self.tabBarController?.selectedIndex -= 1
            }
        }
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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isToolbarHidden = true
    }
    
    func makeScrollView() {
        for i in 0..<imageCollection.count {
            let imageView = UIImageView()
            let x = self.mainScrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: x, y: 0, width: self.mainScrollView.frame.width, height: self.mainScrollView.frame.height)
            imageView.contentMode = .scaleAspectFit
            imageView.image = imageCollection[i]
            
            mainScrollView.contentSize.width = mainScrollView.frame.size.width * CGFloat(i + 1)
            mainScrollView.addSubview(imageView)
        }
    }
    
    @IBAction func cameraButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.delegate = self
            picker.sourceType = .camera
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: NSLocalizedString("str_warning", comment: ""),
                                           message: NSLocalizedString("str_noCamera", comment: ""),
                                           preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("str_ok", comment: ""), style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func albumButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageCollection.append(image)
            makeScrollView()
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}
