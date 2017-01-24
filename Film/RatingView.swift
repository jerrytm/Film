//
//  RatingView.swift
//  Film
//
//  Created by Tomas Vosicky on 03.12.16.
//  Copyright © 2016 Tomas Vosicky. All rights reserved.
//

import UIKit

class RatingView: UIView {
    
    let stars: [UIImageView] = [
        UIImageView(),
        UIImageView(),
        UIImageView(),
        UIImageView(),
        UIImageView()
    ]
    
    var score: Double! {
        didSet {
            let percent = (score / 10.0)
            let starsSeparator = (Int) (percent * 5.0)
            let percentDisplay = (Int) (percent * 100.0)
            ratingLabel.text = "\(percentDisplay)%"
            if starsSeparator > 1 {
                for i in 1...starsSeparator {
                    stars[i - 1].image = #imageLiteral(resourceName: "filledStar")
                }
            }
        }
    }
    
    weak var ratingLabel: UILabel! {
        didSet {
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
        
        let ratingLabel = UILabel()
        ratingLabel.font = UIFont.systemFont(ofSize: 19)
        ratingLabel.numberOfLines = 1
        ratingLabel.textColor = .white
        addSubview(ratingLabel)

        let stackView = UIStackView(arrangedSubviews: stars)
        stackView.axis = .horizontal
        stackView.spacing = 5
        for star in stars {
            star.image = #imageLiteral(resourceName: "star")
        }
        addSubview(stackView)
        
        ratingLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.left.equalTo(ratingLabel.snp.right).offset(9)
            make.centerY.equalTo(ratingLabel)
        }
        
        self.ratingLabel = ratingLabel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
