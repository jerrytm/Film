//
//  PersonCollectionViewCell.swift
//  Film
//
//  Created by Tomas Vosicky on 26.11.16.
//  Copyright © 2016 Tomas Vosicky. All rights reserved.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    
    weak var faceImage: UIImageView!
    weak var titleLabel: UILabel!
    weak var characterLabel: UILabel!
    
    var person: Person? {
        didSet {
            titleLabel.text = person?.name
            characterLabel.text = person?.character
            if (person?.profilePath != nil) {
                faceImage.image = nil
                faceImage.loadImage(usingUrl: TMDBRequest.getImage(for: person!))
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.snp.makeConstraints { (make) in
            make.width.equalTo(95)
        }
        
        let faceImage = UIImageView()
        faceImage.contentMode = .scaleAspectFill
        faceImage.layer.cornerRadius = 45
    
        faceImage.layer.masksToBounds = true
        faceImage.backgroundColor = .gray
        
        addSubview(faceImage)
        faceImage.snp.makeConstraints({ (make) in
            make.width.height.equalTo(90)
            make.top.centerX.equalTo(self)
        })
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
//        titleLabel.backgroundColor = .blue
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(faceImage.snp.bottom).offset(7)
            make.centerX.equalTo(faceImage.snp.centerX)
            make.width.equalTo(self)
        }
 
        let characterLabel = UILabel()
        characterLabel.textAlignment = .center
        characterLabel.textColor = .gray
//        characterLabel.backgroundColor = .green
        characterLabel.numberOfLines = 1
        characterLabel.font = UIFont.systemFont(ofSize: 12)
        addSubview(characterLabel)
        characterLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.centerX.equalTo(faceImage.snp.centerX)
            make.width.equalTo(self)
        }
        
        self.faceImage = faceImage
        self.titleLabel = titleLabel
        self.characterLabel = characterLabel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
