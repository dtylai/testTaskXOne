//
//  JSONManager.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/21/22.
//

import UIKit

enum WeatherData {
    case Success(Weather)
    case Fail(Error)
}

protocol JSONManagerProtocol {
    func getWeather() -> Weather?
}

class JSONManager: JSONManagerProtocol {
    
    private let jsonFielName = "JSONF"
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func getWeather() -> Weather? {
        guard let jsonData = readLocalFile(forName: jsonFielName) else {
            return nil
        }
        let decoder = JSONDecoder()
        
            let weather = try? decoder.decode(Weather.self, from: jsonData)
       // print(weather)
            return weather
    }
}
