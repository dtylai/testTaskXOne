//
//  WeatherScreenDataModels.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/21/22.
//

import UIKit

struct MainScreenWeatherModel: Codable {
    let mainScreenCurrentWeatherModel: MainScreenCurrentWeatherModel
    let mainScreenHourlyWeatherModel: MainScreenHourly
    let mainScreenDailyWeatherModel: [MainScreenDailyWeatherModel]
}

struct MainScreenCurrentWeatherModel: Codable {
    let city: String
    let temperature: String
    
    static func getCurrentDay() -> String {
        let index = Calendar.current.component(.weekday, from: Date())
        return Calendar.current.weekdaySymbols[index - 1]
    }
}

struct MainScreenHourly: Codable {
    let description: String
    let hourly: [MainScreenHourlyWeatherModel]
}
struct MainScreenHourlyWeatherModel: Codable {
    var stringTime: String
    let icon: String
    let degrees: String
    
    
    func getIconImage() -> UIImage {
        let iconCase = WeatherIconCases(value: icon)
        return iconCase.iconImage
    }
}


struct MainScreenDailyWeatherModel: Codable {
    var day: String
    let icon: String
    let maxTemperature: Int
    let minTemperature: Int
    
    func getIconImage() -> UIImage {
        let iconCase = WeatherIconCases(value: icon)
        return iconCase.iconImage
    }
}

