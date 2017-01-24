//
//  MovieTableViewCell.swift
//  Film
//
//  Created by Tomas Vosicky on 26.11.16.
//  Copyright © 2016 Tomas Vosicky. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
  
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textLabel?.textColor = .white
        backgroundColor = .green
//        selectionStyle = .none
        
        let backgroundView = UIView()
        selectedBackgroundView = backgroundView
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.red : UIColor.clear
        }
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.red : UIColor.clear
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
