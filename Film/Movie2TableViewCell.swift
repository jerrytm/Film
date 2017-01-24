//
//  Movie2TableViewCell.swift
//  Film
//
//  Created by Tomas Vosicky on 17.01.17.
//  Copyright © 2017 Tomas Vosicky. All rights reserved.
//

import UIKit

//
//  MovieTableViewCell.swift
//  Film
//
//  Created by Tomas Vosicky on 26.11.16.
//  Copyright © 2016 Tomas Vosicky. All rights reserved.
//

import UIKit

class Movie2TableViewCell: UITableViewCell {
    
    let titleLabel: UILabel! = {
        var label = UILabel()
        label.textColor = .filmTint
        return label
    }()
    
    let categoryLabel: UILabel! = {
        var label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        
        addSubview(imageView)
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(95)
            make.right.equalTo(30)
        }

        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(57)
            make.height.equalTo(87)
            make.left.equalTo(15)
            make.centerY.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var movie: WatchMovie? {
        didSet {
            titleLabel.text = movie?.title
//            imageView?.loadImage(usingUrl: TMDBRequest.getImage(for: movie, type: ))
        }
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
