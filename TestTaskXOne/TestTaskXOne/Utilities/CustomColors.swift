//
//  CustomColors.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/23/22.
//

import UIKit

enum CustomColors: String, CaseIterable {
    case backgrounGray
    case chanceBlue
    case seporatorGray
    case textGray
    case gradient1
    case gradient2
    case gradient3
    
    var color: UIColor? {
        UIColor(named: rawValue)
    }
}
