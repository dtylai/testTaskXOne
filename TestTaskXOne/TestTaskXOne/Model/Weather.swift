//
//  Weather.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/21/22.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let city, temperature, weatherDescription: String
    let weatherPerDay: [WeatherPerDay]
    let forecast: [Forecast]
    
    enum CodingKeys: String, CodingKey {
        case city, temperature
        case weatherDescription = "description"
        case weatherPerDay = "weather_per_day"
        case forecast
    }
}

enum WeekDay: String {
    case monday = "Пн"
    case tuesday = "Вт"
    case wednesday = "Ср"
    case thursday = "Чт"
    case friday = "Пт"
    case saturday = "Сб"
    case sunday = "Вс"
    
    init(value: String) {
        switch value {
        case "понедельник": self = .monday
        case "вторник": self = .tuesday
        case "среда": self = .wednesday
        case "четверг": self = .thursday
        case "пятница": self = .friday
        case "суббота": self = .saturday
        case "воскресенье": self = .sunday
        default:
            self = .monday
        }
    }
}

// MARK: - Forecast
struct Forecast: Codable {
    let date: String
    let minTemperature, maxTemperature: Int
    let weatherType: String
    let chance: String?
    
    enum CodingKeys: String, CodingKey {
        case date
        case minTemperature = "min_temperature"
        case maxTemperature = "max_temperature"
        case weatherType = "weather_type"
        case chance
    }
    
    func getDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        guard let date = dateFormatter.date(from: date) else {
            return "Пн"
        }
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
        dateFormatter.string(from: date)
        let day = WeekDay(value: dateFormatter.string(from: date))
        return day.rawValue
    }
}

// MARK: - WeatherPerDay
struct WeatherPerDay: Codable {
    let timestamp, weatherType, temperature: String
    let sunset: Bool?
    
    enum CodingKeys: String, CodingKey {
        case timestamp
        case weatherType = "weather_type"
        case temperature, sunset
    }
}
