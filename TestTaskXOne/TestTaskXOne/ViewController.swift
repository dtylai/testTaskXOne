//
//  ViewController.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/20/22.
//

import UIKit

class ViewController: UIViewController {
    
    private let grad = CAGradientLayer()
    private var currentConditionLable = UILabel()
    private var currentTempLable = UILabel()
    private var cityNameLable = UILabel()
    private var currentWeatherStack = UIStackView()
    private var generalView = UIView()
    private var hoursTempView = UIView()
    private var descriptionWeatherLable = UILabel()
    private var seporateLineView = UIView()
    private var hoursTempStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingSubViews()
        configureConstraints()
        hoursTempView.addSubview(descriptionWeatherLable)
        hoursTempView.addSubview(seporateLineView)
        hoursTempView.addSubview(hoursTempStack)
    }
    
    private func addingSubViews() {
        currentWeatherStack.addArrangedSubview(currentTempLable)
        currentWeatherStack.addArrangedSubview(currentConditionLable)
        generalView.addSubview(cityNameLable)
        generalView.addSubview(currentWeatherStack)
        view.addSubview(generalView)
    }
    private func configureConstraints() {
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        
        
        guard let customFont = UIFont(name: "Inter-Regular_Medium", size: 30) else {
            fatalError("""
                Failed to load the "CustomFont-Light" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        
        guard let customFontt = UIFont(name: "Inter-Regular_Medium", size: 16) else {
            fatalError("""
                Failed to load the "CustomFont-Light" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        
        func gradient(initialColor: UIColor, middleColor: UIColor,
                      finalColor: UIColor) -> CAGradientLayer {
            let gradient = CAGradientLayer()
            gradient.frame = view.bounds

            gradient.colors = [initialColor.withAlphaComponent(0.25), middleColor.withAlphaComponent(0.25), finalColor.withAlphaComponent(0.0)].map{$0.cgColor}
            gradient.locations = [0.13, 0.32, 0.64]
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
            return gradient
        }
        //FORCE UNRAPING
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        var firsColor = UIColor(red: 160, green: 221, blue: 255, alpha: 1)
        var seconColor = UIColor(red: 92, green: 194, blue: 252, alpha: 1)
        var thirdColor = UIColor(red: 198, green: 231, blue: 249, alpha: 1)
       // generalView.layer.addSublayer(gradient(initialColor: firsColor, middleColor: seconColor, finalColor: thirdColor))
        
        cityNameLable.textColor = .white
        cityNameLable.font = UIFontMetrics.default.scaledFont(for: customFont)
        cityNameLable.adjustsFontForContentSizeCategory = true
        
        currentConditionLable.font = UIFontMetrics.default.scaledFont(for: customFontt)
        currentConditionLable.adjustsFontForContentSizeCategory = true
        currentConditionLable.textColor = .white
        currentConditionLable.alpha = 0.6
        
        currentTempLable.font = UIFontMetrics.default.scaledFont(for: customFontt)
        currentTempLable.adjustsFontForContentSizeCategory = true
        currentTempLable.textColor = .white
        currentTempLable.alpha = 0.6

        cityNameLable.text = "Минск"
        currentConditionLable.text = "| Облачно"
        currentTempLable.text = "-4"
        currentWeatherStack.axis = .horizontal
        currentWeatherStack.alignment = .fill
        currentWeatherStack.spacing = 5
        
        currentConditionLable.translatesAutoresizingMaskIntoConstraints = false
        currentTempLable.translatesAutoresizingMaskIntoConstraints = false
        cityNameLable.translatesAutoresizingMaskIntoConstraints = false
        currentWeatherStack.translatesAutoresizingMaskIntoConstraints = false
        generalView.translatesAutoresizingMaskIntoConstraints = false
        addContraint(view1: cityNameLable, view2: generalView, size: 60, typeOfConstraints: .topToTop)
        addContraint(view1: cityNameLable, view2: generalView, size: 0, typeOfConstraints: .centerXAnchor)
        addContraint(view1: currentWeatherStack, view2: generalView, size: 0, typeOfConstraints: .centerXAnchor)
        addContraint(view1: currentWeatherStack, view2: cityNameLable, size: 6, typeOfConstraints: .topToBottom)
        addContraint(view1: generalView, view2: view, size: 0, typeOfConstraints: .topToTop)
        addContraint(view1: generalView, view2: view, size: 0, typeOfConstraints: .botttomToBottom)
        addContraint(view1: generalView, view2: view, size: 0, typeOfConstraints: .leftToLeft)
        addContraint(view1: generalView, view2: view, size: 0, typeOfConstraints: .rightToRight)
    }
    
    private enum typeOfContraints {
        case topToTop
        case topToBottom
        case bottomToTop
        case botttomToBottom
        case leftToLeft
        case leftToRight
        case rightToRight
        case rightToLeft
        case height
        case width
        case widthToHeight
        case heightToWidth
        case centerXAnchor
        case centerYAnchor
    }
    
    private func addContraint(view1: UIView, view2: UIView?, size: Double, typeOfConstraints: typeOfContraints) {
        switch typeOfConstraints {
        case .topToBottom:
            guard let view2 = view2 else {
                return
            }
            let _ = view1.topAnchor.constraint(equalTo: view2.bottomAnchor, constant: size).isActive = true
            
        case .botttomToBottom:
            guard let view2 = view2 else {
                return
            }
            let _ = view1.bottomAnchor.constraint(equalTo: view2.bottomAnchor, constant: size).isActive = true
            
        case .rightToRight:
            guard let view2 = view2 else {
                return
            }
            let _ = view1.rightAnchor.constraint(equalTo: view2.rightAnchor, constant: size).isActive = true
            
        case .leftToLeft:
            guard let view2 = view2 else {
                return
            }
            let _ = view1.leftAnchor.constraint(equalTo: view2.leftAnchor, constant: size).isActive = true
            
        case .height:
            let _ = view1.heightAnchor.constraint(equalToConstant: size).isActive = true
            
        case .width:
            let _ = view1.widthAnchor.constraint(equalToConstant: size).isActive = true
            
        case .centerXAnchor:
            guard let view2 = view2 else {
                return
            }
            let _ = view1.centerXAnchor.constraint(equalTo: view2.centerXAnchor).isActive = true
            
        case .centerYAnchor:
            guard let view2 = view2 else {
                return
            }
            let _ = view1.centerYAnchor.constraint(equalTo: view2.centerYAnchor).isActive = true
            
        case .widthToHeight:
            guard let view2 = view2 else {
                return
            }
            let _ = view1.widthAnchor.constraint(equalTo: view2.heightAnchor, multiplier: size).isActive = true
            
        case .topToTop:
            guard let view2 = view2 else {
                return
            }
            let _ = view1.topAnchor.constraint(equalTo: view2.topAnchor, constant: size).isActive = true
        case .bottomToTop:
            guard let view2 = view2 else {
                return
            }
            let _ = view1.bottomAnchor.constraint(equalTo: view2.topAnchor, constant: size).isActive = true
            
        case .leftToRight:
            guard let view2 = view2 else {
                return
            }
            let _ = view1.leftAnchor.constraint(equalTo: view2.rightAnchor, constant: size).isActive = true
            
        case .rightToLeft:
            guard let view2 = view2 else {
                return
            }
            let _ = view1.rightAnchor.constraint(equalTo: view2.leftAnchor, constant: size).isActive = true
            
        case .heightToWidth:
            guard let view2 = view2 else {
                return
            }
            let _ = view1.heightAnchor.constraint(equalTo: view2.widthAnchor, multiplier: size).isActive = true
        }
    }
    
}

