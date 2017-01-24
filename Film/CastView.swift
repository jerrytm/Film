//
//  CastView.swift
//  Film
//
//  Created by Tomas Vosicky on 17.01.17.
//  Copyright © 2017 Tomas Vosicky. All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"

class CastView: UIView {

    var cast: [Person]? {
        didSet {
            collectionView.reloadData()
        }
    }

    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize.init(width: 95, height: 150)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.indicatorStyle = .white
        
        collectionView.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let castLabel = UILabel()
        castLabel.text = "Hrají"
        castLabel.textColor = UIColor.init(white: 187/255, alpha: 1)
        castLabel.font = UIFont.systemFont(ofSize: 16)
        addSubview(castLabel)
        
        addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        snp.makeConstraints { (make) in
            make.height.equalTo(150)
        }

//        castLabel.snp.makeConstraints { (make) in
//            make.top.left.equalTo(self)
//        }
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CastView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 1, 0, 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = cast?.count {
            return min(count, 40)
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!  PersonCollectionViewCell
        cell.person = cast?[indexPath.row]
        return cell
    }
}

extension CastView: UICollectionViewDelegate {
    
}
