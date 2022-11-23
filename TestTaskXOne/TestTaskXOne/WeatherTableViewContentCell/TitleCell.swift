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
        label.font = UIFont(name: "Inter-Regular_Medium", size: 14)
        label.text = "10-DAY FORECAST"
        label.textColor = UIColor(red: 149/255.0, green: 161/255.0, blue: 177/255.0, alpha: 1)
        return label
    }()
    
    private let calendarimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "calendar1")?.withTintColor(UIColor(red: 149/255.0, green: 161/255.0, blue: 177/255.0, alpha: 1))
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
