//
//  LocationsLetter.swift
//  LocationPhotographer
//
//  Created by Adeel Qayum on 12/1/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import Foundation

enum FirstLetter: Int {
    
    case a, b, c, d, e, f, g, h, i
    
    static let allValues = [a, b, c, d, e, f, g, h, i]
    
    func name() -> String {
        switch self {
        case .a:                    return "a"
        case .b:                    return "b"
        case .c:                    return "c"
        case .d:                    return "d"
        case .e:                    return "e"
        case .f:                    return "f"
        case .g:                    return "g"
        case .h:                    return "h"
        case .i:                    return "i"
        }
    }
}
