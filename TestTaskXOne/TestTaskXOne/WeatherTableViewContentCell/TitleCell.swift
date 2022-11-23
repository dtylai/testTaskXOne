//
//  TitleCell.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/23/22.
//

import UIKit

class TitleCell: UITableViewCell {
    
    private let titleLable: WeatherLabel = {
        let label = WeatherLabel()
        label.text = "10-DAY FORECAST"
        label.textColor = CustomColors.textGray.color
        return label
    }()
    
    private let calendarimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "calendar")?.withTintColor(CustomColors.textGray.color ?? .gray)
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElements() {
        addSubview(calendarimageView)
        calendarimageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14).isActive = true
        calendarimageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(titleLable)
        titleLable.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLable.leadingAnchor.constraint(equalTo: calendarimageView.trailingAnchor, constant: 8).isActive = true
    }
}
