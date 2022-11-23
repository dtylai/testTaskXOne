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
    static let numberOfRowsInSection = 1
    static let heightForFirstRow: CGFloat = 49
    static let heightForMainContentCells: CGFloat = 55
    static let bottomContentViewHeight: CGFloat = 30
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
        label.text = "loading"
        label.font = UIFont(name: "Inter-Regular_Medium", size: 30)
        return label
    }()
    private let temperatureLabel: WeatherLabel = {
        let label = WeatherLabel()
        label.text = "0"
        label.font = UIFont(name: "Inter-Regular_Medium", size: 16)
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainView)
        layoutTopContentView()
        bottomViewLayout()
        layoutTableView()
        configurator.configure(view: self)
        presenter.getWeather()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        var firsColor = UIColor(red: 160/255.0, green: 221/255.0, blue: 255/255.0, alpha: 1)
        var seconColor = UIColor(red: 92/255.0, green: 194/255.0, blue: 252/255.0, alpha: 1)
        var thirdColor = UIColor(red: 198/255.0, green: 231/255.0, blue: 249/255.0, alpha: 1)
        mainView.layer.addSublayer(gradient(initialColor: firsColor, middleColor: seconColor, finalColor: thirdColor))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.contentOffset = CGPoint(x: 0, y: -(Constants.offsetHeight+Constants.tempretureSectionHeight))
    }
    
    func gradient(initialColor: UIColor, middleColor: UIColor,
                  finalColor: UIColor) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        
        gradient.colors = [initialColor.withAlphaComponent(0.2), middleColor.withAlphaComponent(0.2), finalColor.withAlphaComponent(0.4)].map{$0.cgColor}
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
    
    //MARK: - Layout elements
    
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
        ConstraintAssistant.shared.addContraint(view1: cityLabel, view2: topContentView, size: 60, typeOfConstraints: .topToTop)
        ConstraintAssistant.shared.addContraint(view1: cityLabel, view2: view, size: 0, typeOfConstraints: .centerXAnchor)
        
        topContentView.addSubview(temperatureLabel)
        ConstraintAssistant.shared.addContraint(view1: temperatureLabel, view2: cityLabel, size: 6, typeOfConstraints: .topToBottom)
        ConstraintAssistant.shared.addContraint(view1: temperatureLabel, view2: view, size: 0, typeOfConstraints: .centerXAnchor)
        
    }
    
    var topAnchor: NSLayoutConstraint?
    var isTopAnchorConnectedToTableView = true
    private func layoutTableView() {
        mainView.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.topAnchor.constraint(equalTo: topContentView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        tableView.addSubview(weatherByHoursView)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
        
        weatherByHoursView.backgroundColor = UIColor(red: 60/255.0, green: 78/255.0, blue: 101/255.0, alpha: 0.6)
        weatherByHoursView.translatesAutoresizingMaskIntoConstraints = false
        weatherByHoursView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        weatherByHoursView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        weatherByHoursView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topAnchor = weatherByHoursView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -9)
        topAnchor!.isActive = true
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


//MARK: - TableViewDelegate
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        cell = WeatherForAWeekTableViewCell()
        (cell as! WeatherForAWeekTableViewCell).viewModel = viewModel?.mainScreenDailyWeatherModel
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        cell.backgroundColor = UIColor(red: 60/255.0, green: 78/255.0, blue: 101/255.0, alpha: 0.6)
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel?.mainScreenDailyWeatherModel.count ?? 8)*Constants.heightForFirstRow
    }
}

