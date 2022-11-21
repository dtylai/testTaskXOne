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
    func getWeather(completion: @escaping((WeatherData)->Void))
}

class JSONManager: JSONManagerProtocol {
    
    private let jsonFielName = "TestTaskJSON"
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
    
    func getWeather(completion: @escaping((WeatherData)->Void)) {
        guard let jsonData = readLocalFile(forName: jsonFielName) else {
            return
        }
        let decoder = JSONDecoder()
        do {
            let weather = try decoder.decode(Weather.self, from: jsonData)
            completion(.Success(weather))
        } catch {
            print(error)
            let userInfo = [
                NSLocalizedDescriptionKey : NSLocalizedString("fail", value: "There are some mistakes with data",
                                                              comment: "")
            ]
            let error = NSError(domain: "TestTaskXone.com", code: 202, userInfo: userInfo)
            completion(.Fail(error))
        }
    }
}
