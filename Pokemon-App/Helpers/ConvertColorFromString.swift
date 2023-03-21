//
//  ConvertColorFromString.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 21.03.2023.
//

import UIKit

enum StringToColor {
    
    static func convertStringToColor(color: String) -> UIColor {
        
        switch color {
        case "red":
            return.init(red: 250/255, green: 108/255, blue: 109/255, alpha: 1)
        case "brown":
            return.init(red: 243/255, green: 139/255, blue: 105/255, alpha: 1)
        case "black":
            return.black
        case "blue":
            return.init(red: 144/255, green: 203/255, blue: 254/255, alpha: 1)
        case "purple":
            return.init(red: 122/255, green: 62/255, blue: 101/255, alpha: 1)
        case "gray":
            return.gray
        case "green":
            return UIColor.init(red: 79/255, green: 206/255, blue: 178/255, alpha: 1)
        case "pink":
            return.init(red: 217/255, green: 172/255, blue: 245/255, alpha: 1)
        case "yellow":
            return.init(red: 255/255, green: 217/255, blue: 110/255, alpha: 1)
        default:
            return .init(red: 241/255, green: 239/255, blue: 238/255, alpha: 1)
        }
    }
}
