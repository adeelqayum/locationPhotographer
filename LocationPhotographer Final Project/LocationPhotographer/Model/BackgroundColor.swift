//
//  BackgroundColor.swift
//  LocationPhotographer
//
//  Created by Adeel Qayum on 11/26/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import Foundation
import UIKit

class BackgroundColor {
    
    var colorArray = [UIColor(red: 164/255.0, green: 224/255.0, blue: 233/255.0, alpha: 1), UIColor(red: 244/255.0, green: 243/255.0, blue: 215/255.0, alpha: 1), UIColor(red: 230/255.0, green: 236/255.0, blue: 248/255.0, alpha: 1), UIColor.red, UIColor.brown, UIColor.green, UIColor.gray]
    
    func getNextColor(index: Int) -> UIColor {
        var newIndex = index + 1
        if (index > (colorArray.count - 1)) {
            newIndex = 0
        }
        return colorArray[newIndex]
    }
    
}
