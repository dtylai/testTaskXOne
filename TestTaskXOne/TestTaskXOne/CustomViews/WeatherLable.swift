//
//  WeatherLable.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/21/22.
//

import UIKit

class WeatherLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
