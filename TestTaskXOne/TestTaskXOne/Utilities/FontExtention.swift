//
//  FontExtention.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/23/22.
//

import UIKit

extension UIFont {
   static func returnInterFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Regular_Medium", size: size) ?? UIFont()
    }
}
