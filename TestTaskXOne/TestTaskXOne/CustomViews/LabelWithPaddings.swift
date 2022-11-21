//
//  LabelWithPaddings.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/21/22.
//

import UIKit

@IBDesignable class LabelWithPaddings: WeatherLabel {

    @IBInspectable var topInset: CGFloat = 10
    @IBInspectable var bottomInset: CGFloat = 10
    @IBInspectable var leftInset: CGFloat = 15
    @IBInspectable var rightInset: CGFloat = 15

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
