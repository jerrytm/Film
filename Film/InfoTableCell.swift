//
//  InfoTableCell.swift
//  Film
//
//  Created by Tomas Vosicky on 23.01.17.
//  Copyright © 2017 Tomas Vosicky. All rights reserved.
//

import UIKit

class InfoTableCell: UIStackView {
    
    weak var label: UILabel!
    weak var text: UILabel!
    
    init(_ labelText: String) {
        super.init(frame: .zero)
        
        spacing = 15
        
        let label = UILabel()
        label.text = labelText
        label.textColor = .filmTint
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        
        let text = UILabel()
        text.textColor = UIColor.init(red: 185/255, green: 180/255, blue: 178/255, alpha: 1)
        text.font = UIFont.systemFont(ofSize: 14)
        
        self.label = label
        self.text = text
        
        addArrangedSubview(label)
        addArrangedSubview(text)
        
        label.snp.makeConstraints { (make) in
            make.width.equalTo(85)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
