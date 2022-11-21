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
    
    private var apiManager: JSONManager!
    private var isErrorMessageWasShown = false
    private var isgetWeatherFinished = false
    
    override init() {
        super.init()

    }
    
    @objc func getWeather() {
            apiManager.getWeather {[unowned self] (weather) in
                switch weather {
                case .Success(let weatherData):
                    let mainScreenWeatherModel = self.weatherToMainScreenWeatherModel(weather: weatherData)
                    DispatchQueue.main.async {
                        self.findBackroundColorToMainScreen(iconName:
                            mainScreenWeatherModel.mainScreenHourlyWeatherModel[0].icon)
                        self.view.displayWeather(mainScreenWeatherModel: mainScreenWeatherModel)
                    }
                case .Fail(let error):
                    DispatchQueue.main.async {
                        self.view.displayErrorMessage(errorMessage: error.localizedDescription)
                    }
                }
            }
    }
    
    private func findBackroundColorToMainScreen(iconName: String) {
        var backgroundColorCase: BackgroundColorCase!
        switch iconName {
        case "clear-day", "sunset", "sunrise", "partly-cloudy-day":
            backgroundColorCase = .day
        case "clear-night", "partly-cloudy-night":
            backgroundColorCase = .night
        case "rain", "snow", "sleet", "wind", "fog":
            backgroundColorCase = .precipitation
        case "cloudy":
            let hour = Calendar.current.component(.hour, from: Date())
            switch hour {
            case 6..<12:
                backgroundColorCase = .day
            default:
                backgroundColorCase = .night
            }
        default:
            backgroundColorCase = .day
        }
        view.setBackroundColor(bacgroundColorCase: backgroundColorCase)
    }
    
    
    private func createErrorMessage(value: String, code: Int) {
        let userInfo = [
            NSLocalizedDescriptionKey :
                NSLocalizedString("fail",
                                  value: value,
                                  comment: "")
        ]
        let error = NSError(domain: "ApiManager.domain", code: code, userInfo: userInfo)
        self.view.displayErrorMessage(errorMessage: error.localizedDescription)
    }
//    view.setBackroundColor(bacgroundColorCase: bacgroundColorCase)
//    view.displayWeather(mainScreenWeatherModel: weaher)

    
    // convert Weather to MainScreenWeatherModel
    private func weatherToMainScreenWeatherModel(weather: Weather) -> MainScreenWeatherModel {
        let mainScreenCurrentWeatherModel = MainScreenCurrentWeatherModel(city: weather.city, temperature: weather.temperature)
        // hourly weatherModel
        var mainScreenHourlyWeather: [MainScreenHourlyWeatherModel] = []
        var sunriseTime: Double!
        var sunsetTime: Double!
        
        
        for weather in weather.weatherPerDay {

            let mainScreenHourlyWeatherModel = MainScreenHourlyWeatherModel(stringTime: weather.timestamp, icon: weather.weatherType, degrees: weather.temperature)
            if let sunset = weather.sunset {
                let sunSetMainScreenHourlyWeatherModel = MainScreenHourlyWeatherModel(stringTime: weather.timestamp, icon: "sunset", degrees: "Заход солнца")
                mainScreenHourlyWeather.append(sunSetMainScreenHourlyWeatherModel)
            }
            mainScreenHourlyWeather.append(mainScreenHourlyWeatherModel)
        }
        mainScreenHourlyWeather[0].stringTime = "Сейчас"
        
        // daily weatherModel
        var mainScreenDailyWeather: [MainScreenDailyWeatherModel] = []
        for weather in weather.forecast {

            let mainScreenDailyWeatherModel = MainScreenDailyWeatherModel(day: weather.getDay(), icon: weather.weatherType, maxTemperature: weather.maxTemperature, minTemperature: weather.minTemperature)
            mainScreenDailyWeather.append(mainScreenDailyWeatherModel)
        }
        mainScreenDailyWeather[0].day = "Сегодня"
        let mainScreenWeatherModel = MainScreenWeatherModel(mainScreenCurrentWeatherModel: mainScreenCurrentWeatherModel, mainScreenHourlyWeatherModel: mainScreenHourlyWeather, mainScreenDailyWeatherModel: mainScreenDailyWeather)
        return mainScreenWeatherModel
    }
    
}

//MARK: - CLLocationManagerDelegate
extension MainScreenPresenter: CLLocationManagerDelegate {
    //trying to get user location and city
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.global().async { [unowned self] in
            if let location = locations.first {
                let url = self.urlManager.getURL(latitude: String(location.coordinate.latitude),
                                                 longitude: String(location.coordinate.longitude))!
                self.apiManager = ApiManager(url: url)
                location.fetchCity { [unowned self] (city, error)  in
                    if let city = city {
                        self.city = city
                    } else {
                        self.city = "Not Found"
                    }
                    if !self.isgetWeatherFinished {
                        self.getWeather()
                    }
                    self.isgetWeatherFinished = true
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        createErrorMessage(value: "Failed to determine location, please go to Settings and turn on the permissions", code: 6)
    }
    
}
