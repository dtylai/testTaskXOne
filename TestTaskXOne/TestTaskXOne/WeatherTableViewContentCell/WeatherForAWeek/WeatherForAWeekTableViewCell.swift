//
//  WeatherForAWeekTableViewCell.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/21/22.
//

import UIKit

fileprivate struct Constants {
    static let cellHeight: CGFloat = 47
}

class WeatherForAWeekTableViewCell: UITableViewCell {
    let bottomSeparatorView = SeparatorView()
    var viewModel: [MainScreenDailyWeatherModel]? {
        didSet {
            weatherTableView.reloadData()
        }
    }
    private lazy var weatherTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WeatherForAWeekCell.self, forCellReuseIdentifier: "weatherForAWeekCell")
        tableView.register(TitleCell.self, forCellReuseIdentifier: "titleCell")
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        //rgba(110, 120, 135, 1)
        tableView.separatorColor = UIColor(red: 110/255.0, green: 120/255.0, blue: 135/255.0, alpha: 1)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        return tableView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutElements()
        layer.cornerRadius = 14
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElements() {
        addSubview(bottomSeparatorView)
        bottomSeparatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomSeparatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bottomSeparatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addSubview(weatherTableView)
        weatherTableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        weatherTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        weatherTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        weatherTableView.bottomAnchor.constraint(equalTo: bottomSeparatorView.topAnchor).isActive = true
    }
}

extension WeatherForAWeekTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = TitleCell()
            cell.backgroundColor = .clear
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "weatherForAWeekCell", for: indexPath) as! WeatherForAWeekCell
            cell.backgroundColor = .clear
            if let data = viewModel?[indexPath.row] {
                cell.setupElements(viewModel: data)
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
    
}

