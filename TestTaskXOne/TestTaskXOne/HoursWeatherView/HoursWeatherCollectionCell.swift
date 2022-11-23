//
//  HoursWeatherCollectionCell.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/21/22.
//

import UIKit

fileprivate struct Constants {
    static let spacingBetweenElements: CGFloat = 14
}

class HoursWeatherCollectionCell: UICollectionViewCell {
    private let timeLabel: WeatherLabel = {
        let label = WeatherLabel()
        label.text = "-"
        return label
    }()
    
    private let temperatureLabel: WeatherLabel = {
        let label = WeatherLabel()
        label.text = "-"
        return label
    }()
    
    private let weaherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutElements()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        weaherIconImageView.image = nil
        timeLabel.text = "11"
        temperatureLabel.text = "4"
    }
    
    func setupElements(data: MainScreenHourlyWeatherModel?) {
        let celsius = NSString(format:"\u{00B0}") as String
        guard let data = data else { return }
        if data.degrees == "Заход солнца" {
            temperatureLabel.font = UIFont.returnInterFont(size: 18)
            timeLabel.text = data.stringTime
            temperatureLabel.text = data.degrees
            weaherIconImageView.image = data.getIconImage()
            return
        }
        timeLabel.text = data.stringTime
        temperatureLabel.text = data.degrees + celsius
        weaherIconImageView.image = data.getIconImage()
    }
    
    private func layoutElements() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.spacingBetweenElements
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(weaherIconImageView)
        stackView.addArrangedSubview(temperatureLabel)
        
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
}
