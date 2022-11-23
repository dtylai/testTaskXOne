//
//  WeatherScreenPresenter.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/21/22.
//

import CoreLocation

protocol MainScreenPresenterProtocol {
    func getWeather()
}

class MainScreenPresenter: NSObject, MainScreenPresenterProtocol {
    var view: MainScreenView!
    private var jsonManager = JSONManager()
    
    override init() {
        super.init()
        
    }
    
    @objc func getWeather() {
        let mainScreenWeatherModel = self.weatherToMainScreenWeatherModel(weather: jsonManager.getWeather()!)
        DispatchQueue.main.async {
            self.view.displayWeather(mainScreenWeatherModel: mainScreenWeatherModel)
        }
        
    }
    
    private func weatherToMainScreenWeatherModel(weather: Weather) -> MainScreenWeatherModel {
        let mainScreenCurrentWeatherModel = MainScreenCurrentWeatherModel(city: weather.city, temperature: weather.temperature)
        
        var mainScreenHourlyWeather: [MainScreenHourlyWeatherModel] = []
        for weather in weather.weatherPerDay {
            let mainScreenHourlyWeatherModel = MainScreenHourlyWeatherModel(stringTime: weather.timestamp, icon: weather.weatherType, degrees: weather.temperature)
            mainScreenHourlyWeather.append(mainScreenHourlyWeatherModel)
            if weather.sunset != nil {
                let sunSetMainScreenHourlyWeatherModel = MainScreenHourlyWeatherModel(stringTime: weather.timestamp, icon: "sunset", degrees: "Заход солнца")
                mainScreenHourlyWeather.append(sunSetMainScreenHourlyWeatherModel)
            }
        }
        mainScreenHourlyWeather[0].stringTime = "Сейчас"
        let mainScreenH = MainScreenHourly(description: weather.weatherDescription, hourly: mainScreenHourlyWeather)
        
        var mainScreenDailyWeather: [MainScreenDailyWeatherModel] = []
        for weather in weather.forecast {
            
            let mainScreenDailyWeatherModel = MainScreenDailyWeatherModel(day: weather.getDay(), icon: weather.weatherType, maxTemperature: weather.maxTemperature, minTemperature: weather.minTemperature, chance: weather.chance)
            mainScreenDailyWeather.append(mainScreenDailyWeatherModel)
        }
        mainScreenDailyWeather[0].day = "Сегодня"
        
        let mainScreenWeatherModel = MainScreenWeatherModel(mainScreenCurrentWeatherModel: mainScreenCurrentWeatherModel, mainScreenHourlyWeatherModel: mainScreenH, mainScreenDailyWeatherModel: mainScreenDailyWeather)
        
        return mainScreenWeatherModel
    }
}

