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
        label.font = UIFont(name: "Inter-Regular_Medium", size: 18)
        label.text = "-"
        return label
    }()
    
    private let weaherIconImageView: UIImageView = {
        let imageView = UIImageView()
        // /imageView.backgroundColor = .black
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let chanceOfPrecipitationLabel: WeatherLabel = {
        let label = WeatherLabel()
        label.textColor = UIColor(red: 139/255.0, green: 205/255.0, blue: 231/255.0, alpha: 1)
        label.font = UIFont(name: "Inter-Regular_Medium", size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let maxTemperatureLabel: WeatherLabel = {
        let label = WeatherLabel()
        label.font = UIFont(name: "Inter-Regular_Medium", size: 16)
        label.text = "-"
        return label
    }()
    
    private let minTemperatureLabel: WeatherLabel = {
        let label = WeatherLabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.65)
        label.font = UIFont(name: "Inter-Regular_Medium", size: 16)
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
        let celsius = NSString(format:"\u{00B0}") as String
        if let chance = viewModel.chance {
            chanceOfPrecipitationLabel.isHidden = false
            chanceOfPrecipitationLabel.text = chance
        }
        dayLabel.text = viewModel.day
        maxTemperatureLabel.text = viewModel.maxTemperature.description + celsius
        minTemperatureLabel.text = viewModel.minTemperature.description + celsius
        weaherIconImageView.image = viewModel.getIconImage()
    }
    
    private func layoutElements() {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.addArrangedSubview(weaherIconImageView)
        stack.addArrangedSubview(chanceOfPrecipitationLabel)
        
        addSubview(dayLabel)
        dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14).isActive = true
        dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(stack)
        stack.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -30).isActive = true
        stack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(maxTemperatureLabel )
        addSubview(minTemperatureLabel)
        
        maxTemperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14).isActive = true
        maxTemperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        minTemperatureLabel.centerXAnchor.constraint(equalTo: maxTemperatureLabel.trailingAnchor,constant: -85).isActive = true
        minTemperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
