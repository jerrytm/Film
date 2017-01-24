//
//  MovieItemCollectionViewCell.swift
//  Film
//
//  Created by Tomas Vosicky on 22.11.16.
//  Copyright © 2016 Tomas Vosicky. All rights reserved.
//

import UIKit
import SnapKit
private let posterImageUrl = "https://image.tmdb.org/t/p/w300_and_h450_bestv2"

extension UIImageView {
    func loadImage(usingUrl url: URL) {
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, requestError) -> Void in
            if let requestError = requestError {
                print(requestError)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
                self.setNeedsLayout()
            }
            
        }).resume()
    }
}

class MovieItemCollectionViewCell: UICollectionViewCell {
    
    var movie: Movie? {
        didSet {
            setupPosterImage()
            titleLabel.text = movie?.title
        }
    }
    
    weak var imageView: UIImageView!
    weak var titleLabel: UILabel!
    
    func setupPosterImage() {
        if let posterPath = movie?.posterPath {
            let imageUrl = URL(string: posterImageUrl + posterPath)
            imageView.loadImage(usingUrl: imageUrl!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        

        addSubview(imageView)
        imageView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.contentView).inset(UIEdgeInsetsMake(0, 0, 20, 0))
        }

        let titleLabel = UILabel()
        titleLabel.textColor = .filmTint
        titleLabel.font = titleLabel.font.withSize(12)

        addSubview(titleLabel)
        
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
        }
        self.imageView = imageView
        self.titleLabel = titleLabel
    }
    
    override var isHighlighted: Bool {
        didSet {
            imageView.alpha = isHighlighted ? 0.4 : 1.0
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.alpha = isSelected ? 0.4 : 1.0
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
