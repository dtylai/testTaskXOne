//
//  SeparatorView.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/21/22.
//

import UIKit

class SeparatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = CustomColors.seporatorGray.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
