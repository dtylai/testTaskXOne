//
//  IconEnum.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/21/22.
//

import UIKit

enum WeatherIconCases: String {
    case snow = "snow"
    case cloudy = "cloudy"
    case sunset = "sunset"

    init(value: String) {
        switch value {
        case "snow": self = .snow
        case "cloudy": self = .cloudy
        case "sunset": self = .sunset
        default: self = .cloudy
        }
    }

    var iconImage: UIImage {
        return UIImage(named: self.rawValue)!
    }
}
