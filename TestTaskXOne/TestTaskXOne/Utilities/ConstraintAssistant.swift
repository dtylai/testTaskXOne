//
//  ConstraintAssistant.swift
//  TestTaskXOne
//
//  Created by Dmitry Tulay on 11/21/22.
//

import UIKit

enum TypeOfContraints {
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

class ConstraintAssistant {
    static let shared = ConstraintAssistant()
    private init(){}
    
    private func addContraint(view1: UIView, view2: UIView?, size: Double, typeOfConstraints: TypeOfContraints) {
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
