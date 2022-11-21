//
//  WeatherForAWeekCell.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/21/22.
//

import UIKit

class WeatherForAWeekCell: UITableViewCell {
   
    private let dayLabel: WeatherLabel = {
        let label = WeatherLabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "-"
        return label
    }()
    
    private let weaherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let maxTemperatureLabel: WeatherLabel = {
        let label = WeatherLabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "-"
        return label
    }()
    
    private let minTemperatureLabel: WeatherLabel = {
        let label = WeatherLabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.65)
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "-"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupElements(viewModel: MainScreenDailyWeatherModel) {
        dayLabel.text = viewModel.day
        maxTemperatureLabel.text = viewModel.maxTemperature
        minTemperatureLabel.text = viewModel.minTemperature
        weaherIconImageView.image = viewModel.getIconImage()
    }
    
    private func layoutElements() {
        addSubview(dayLabel)
        dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(weaherIconImageView)
        weaherIconImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        weaherIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(maxTemperatureLabel)
        addSubview(minTemperatureLabel)
        
        minTemperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        minTemperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        maxTemperatureLabel.centerXAnchor.constraint(equalTo: minTemperatureLabel.trailingAnchor,
                                                     constant: -65).isActive = true
        maxTemperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
