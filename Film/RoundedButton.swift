//
//  RoundedButton.swift
//  Film
//
//  Created by Tomas Vosicky on 30.11.16.
//  Copyright © 2016 Tomas Vosicky. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override init(frame: CGRect) {
        self.toggledTintColor = nil
        self.isToggled = false
        super.init(frame: frame)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)

        contentEdgeInsets = UIEdgeInsetsMake(14, 10, 13, 10)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        tintColor = .buttonGreen
        backgroundColor = tintColor
        toggledTintColor = tintColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getBackground() -> UIColor {
        if isBordered {
            return UIColor.clear
        }
        return isToggled ? toggledTintColor : tintColor
    }

    var toggledTintColor: UIColor!
    
    var isBordered: Bool = false {
        didSet {
            backgroundColor = .clear
            layer.borderWidth = 1
            layer.borderColor = tintColor.cgColor
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.8 : 1
        }
    }
    
    var isToggled: Bool {
        didSet {
            backgroundColor = getBackground()
//            titleLabel?.textColor = isHighlighted ? UIColor.init(red: 189/255, green: 242/255, blue: 198/255, alpha: 1) : .white
        }
    }
}

