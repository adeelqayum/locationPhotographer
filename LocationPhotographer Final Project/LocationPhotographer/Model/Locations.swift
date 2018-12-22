//
//  Locations.swift
//  Project #3
//
//  Created by Adeel Qayum on 11/22/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import Foundation
import UIKit

struct LocationItem: Equatable, Codable {
    var title: String
}

class Locations: Codable {
    
    var locationList = [LocationItem]()
    //var backgroundColors = [UIColor]()
    
    func add(title: String) {
        let locationItem = LocationItem(title: title)
        locationList.insert(locationItem, at: 0)
    }
    
    func removeItem(at index: Int) {
        if let _ = locationList[index] as LocationItem? {
            locationList.remove(at: index)
        }
    }
    
    func moveItem(_ fromIndex: Int, _ toIndex: Int) {
        if fromIndex != toIndex {
            let locationItem = locationList[fromIndex]
            locationList.remove(at: fromIndex)
            locationList.insert(locationItem, at: toIndex)
        }
    }
    
    func getFirstLetter(location: String) -> String {
        if let letter = location.first {
            return String(letter)
        }
        return " "
    }
}
