//
//  ViewController.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/20/22.
//


import UIKit

fileprivate struct Constants {
    static let tempretureSectionHeight: CGFloat = 100
    static let offsetHeight: CGFloat = UIScreen.main.bounds.height/5
    static let heightForFirstRow: CGFloat = 49
    static let bottomContentViewHeight: CGFloat = 10
}

protocol MainScreenView {
    func displayWeather(mainScreenWeatherModel: MainScreenWeatherModel)
}

class WeatherViewController: UIViewController, MainScreenView {
    var presenter: MainScreenPresenterProtocol!
    private let configurator: WeatherScreenConfiguratorProtocol = WeatherScreenConfigurator()
    private var weatherByHoursView = WeatherByHoursView()
    private let bottomView = ContentView()
    private let mainView = UIView()
    
    
    private var topContentView: ContentView = {
        let view = ContentView()
        return view
    }()
    
    private let cityLabel: WeatherLabel = {
        let label = WeatherLabel()
        label.text = "Minsk"
        label.font = UIFont.returnInterFont(size: 30)
        return label
    }()
    
    private let temperatureLabel: WeatherLabel = {
        let label = WeatherLabel()
        label.text = "0"
        label.font = UIFont.returnInterFont(size: 16)
        label.alpha = 0.6
        return label
    }()
    
    private var viewModel: MainScreenWeatherModel?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WeatherForAWeekTableViewCell.self, forCellReuseIdentifier: "weatherForAWeekTableViewCell")
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: Constants.offsetHeight+Constants.tempretureSectionHeight,
                                              left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainView)
        layoutTopContentView()
        bottomViewLayout()
        layoutTableView()
        configurator.configure(view: self)
        presenter.getWeather()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.contentOffset = CGPoint(x: 0, y: -(Constants.offsetHeight+Constants.tempretureSectionHeight))
    }
    
    func configureView() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        mainView.layer.addSublayer(gradient(initialColor: CustomColors.gradient1.color?.withAlphaComponent(0.2) ?? .blue,
                                            middleColor: CustomColors.gradient2.color?.withAlphaComponent(0.2) ?? .red,
                                            finalColor: CustomColors.gradient3.color?.withAlphaComponent(0.2) ?? .green))
    }
    
    func gradient(initialColor: UIColor, middleColor: UIColor,
                  finalColor: UIColor) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        
        gradient.colors = [initialColor, middleColor, finalColor].map{$0.cgColor}
        gradient.locations = [0.13, 0.32, 0.64]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        
        return gradient
    }
    
    func displayWeather(mainScreenWeatherModel: MainScreenWeatherModel) {
        cityLabel.text = mainScreenWeatherModel.mainScreenCurrentWeatherModel.city
        temperatureLabel.text = mainScreenWeatherModel.mainScreenCurrentWeatherModel.temperature
        viewModel = mainScreenWeatherModel
        weatherByHoursView.viewModel = mainScreenWeatherModel.mainScreenHourlyWeatherModel
        tableView.reloadData()
    }
    
    private func layoutTopContentView() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        mainView.addSubview(topContentView)
        topContentView.backgroundColor = .clear
        topContentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        topContentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/5.5).isActive = true
        topContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        topContentView.addSubview(cityLabel)
        cityLabel.topAnchor.constraint(equalTo: topContentView.topAnchor, constant: 60).isActive = true
        cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        topContentView.addSubview(temperatureLabel)
        temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 6).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    private func layoutTableView() {
        mainView.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.topAnchor.constraint(equalTo: topContentView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        
        tableView.addSubview(weatherByHoursView)
        weatherByHoursView.backgroundColor = CustomColors.backgrounGray.color
        weatherByHoursView.translatesAutoresizingMaskIntoConstraints = false
        weatherByHoursView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        weatherByHoursView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        weatherByHoursView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherByHoursView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -9).isActive = true
    }
    
    private func bottomViewLayout() {
        let safeBottomAnchor = mainView.layoutMarginsGuide.bottomAnchor
        mainView.addSubview(bottomView)
        bottomView.backgroundColor = .clear
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.heightAnchor.constraint(equalToConstant: Constants.bottomContentViewHeight).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: safeBottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
    }
    
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        cell = WeatherForAWeekTableViewCell()
        (cell as! WeatherForAWeekTableViewCell).viewModel = viewModel?.mainScreenDailyWeatherModel
        cell.backgroundColor = CustomColors.backgrounGray.color
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel?.mainScreenDailyWeatherModel.count ?? 8)*Constants.heightForFirstRow
    }
}

