//
//  HoursWeatherView.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/21/22.
//

import UIKit

class WeatherByHoursView: UIView {
    let middleSeparatorView = SeparatorView()
    var descriptionLable:  WeatherLabel = {
       let label = WeatherLabel()
       label.text = "-"
       label.textColor = .white
       label.numberOfLines = 2
       return label
   }()
    var viewModel: MainScreenHourly? {
        didSet {
            descriptionLable.text = viewModel?.description
            collectionView.reloadData()
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
                                        at: .left, animated: false)
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        collectionView.register(HoursWeatherCollectionCell.self, forCellWithReuseIdentifier: "HoursWeatherCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = backgroundColor
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutElements()
        backgroundColor = .red
        layer.cornerRadius = 14
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElements() {
        addSubview(descriptionLable)
        descriptionLable.topAnchor.constraint(equalTo: topAnchor, constant: 14).isActive = true
        descriptionLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14).isActive = true
        descriptionLable.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        addSubview(middleSeparatorView)
        middleSeparatorView.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor, constant: 14).isActive = true
        middleSeparatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14).isActive = true
        middleSeparatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14).isActive = true
        middleSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: middleSeparatorView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension WeatherByHoursView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.hourly.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HoursWeatherCell", for: indexPath) as! HoursWeatherCollectionCell
        cell.setupElements(data: viewModel?.hourly[indexPath.row])
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        25
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        27
    }
}
