//
//  WikiViewController.swift
//  LocationPhotographer
//
//  Created by Adeel Qayum on 11/25/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WikiViewController: UIViewController {
    
    @IBOutlet weak var wikiView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selectedLocation: LocationItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationTitle = selectedLocation?.title
        
        let finalLocationTitle = convertSpaces(title: locationTitle!)
        
        let urlString = "https://en.wikipedia.org/wiki/\(finalLocationTitle)"
        
        let request = URLRequest(url: URL(string: urlString)!)
        
        self.wikiView.loadRequest(request)
        
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
    
    func convertSpaces(title: String) -> String {
        let replaced = title.replacingOccurrences(of: " ", with: "_")
        return replaced
    }
}
