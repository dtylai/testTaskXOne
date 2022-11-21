//
//  WeatherScreenConfigurator.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/21/22.
//

import Foundation

protocol WeatherScreenConfiguratorProtocol: class {
    func configure(view: WeatherViewController)
}

class WeatherScreenConfigurator: WeatherScreenConfiguratorProtocol {
    func configure(view: WeatherViewController) {
        let presenter = MainScreenPresenter()
        presenter.view = view
        view.presenter = presenter
    }
}
