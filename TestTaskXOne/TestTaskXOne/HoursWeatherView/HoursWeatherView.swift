//
//  HoursWeatherView.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/21/22.
//

import UIKit

class WeatherByHoursView: UIView {

    let topSeparatorView = SeparatorView()
    let bottomSeparatorView = SeparatorView()
    let descriptionLable = UILabel()
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
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        collectionView.register(HoursWeatherCollectionCell.self, forCellWithReuseIdentifier: "HoursWeatherCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutElements()
        descriptionLable.translatesAutoresizingMaskIntoConstraints = false
        descriptionLable.textColor = .white
        descriptionLable.numberOfLines = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElements() {
        addSubview(descriptionLable)
        descriptionLable.topAnchor.constraint(equalTo: topAnchor).isActive = true
        descriptionLable.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        descriptionLable.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        descriptionLable.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        addSubview(bottomSeparatorView)
        bottomSeparatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomSeparatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bottomSeparatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomSeparatorView.topAnchor).isActive = true
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
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        30
    }
    
}
//addSubview(descriptionLable)
//ConstraintAssistant.shared.addContraint(view1: descriptionLable, view2: self, size: 14, typeOfConstraints: .topToTop)
//ConstraintAssistant.shared.addContraint(view1: descriptionLable, view2: self, size: 14, typeOfConstraints: .leftToLeft)
//ConstraintAssistant.shared.addContraint(view1: descriptionLable, view2: self, size: 40, typeOfConstraints: .rightToRight)
//
//addSubview(midleSeparatorView)
//ConstraintAssistant.shared.addContraint(view1: midleSeparatorView, view2: descriptionLable, size: 14, typeOfConstraints: .topToBottom)
//ConstraintAssistant.shared.addContraint(view1: midleSeparatorView, view2: self, size: 14, typeOfConstraints: .leftToLeft)
//ConstraintAssistant.shared.addContraint(view1: midleSeparatorView, view2: self, size: 15, typeOfConstraints: .rightToRight)
//
//addSubview(collectionView)
//ConstraintAssistant.shared.addContraint(view1: collectionView, view2: midleSeparatorView, size: 14, typeOfConstraints: .topToBottom)
//ConstraintAssistant.shared.addContraint(view1: collectionView, view2: self, size: 14, typeOfConstraints: .leftToLeft)
//ConstraintAssistant.shared.addContraint(view1: collectionView, view2: self, size: 15, typeOfConstraints: .rightToRight)
//ConstraintAssistant.shared.addContraint(view1: collectionView, view2: self, size: 20, typeOfConstraints: .botttomToBottom)
