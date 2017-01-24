//
//  DetailViewController.swift
//  Film
//
//  Created by Tomas Vosicky on 24.11.16.
//  Copyright © 2016 Tomas Vosicky. All rights reserved.
//

import UIKit
import SnapKit
import CoreData
import MagicalRecord

class DetailViewController: UIViewController {
    
    weak var scrollView: UIScrollView! {
        didSet {
            scrollView.alwaysBounceVertical = true
            scrollView.indicatorStyle = .white
        }
    }
    
    weak var backdropImageView: UIImageView! {
        didSet {
            backdropImageView.backgroundColor = .gray
            backdropImageView.layer.opacity = 0.3
            backdropImageView.contentMode = .scaleAspectFill
        }
    }
    
    weak var posterView: UIImageView! {
        didSet {
            posterView.backgroundColor = .gray
            posterView.contentMode = .scaleAspectFill
            posterView.layer.cornerRadius = 3
            posterView.layer.masksToBounds = true
        }
    }
    
    weak var stackView: UIStackView! {
        didSet {
            stackView.axis = .vertical
            stackView.spacing = 10
        }
    }
    
    weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.systemFont(ofSize: 33, weight: UIFontWeightRegular)
            titleLabel.numberOfLines = 3
            titleLabel.textColor = view.tintColor
        }
    }

    weak var originalTitleLabel: UILabel! {
        didSet {
            originalTitleLabel.font = UIFont.systemFont(ofSize: 25)
            originalTitleLabel.numberOfLines = 0
            originalTitleLabel.textColor = view.tintColor
        }
    }
    
    weak var ratingView: RatingView!

    weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 4
            descriptionLabel.font = UIFont.systemFont(ofSize: 15)
            descriptionLabel.textColor = UIColor.init(white: 187/255, alpha: 1)

            let gesture = UITapGestureRecognizer(target: self, action: #selector(toggleDescription))
            gesture.numberOfTapsRequired = 1
            descriptionLabel.isUserInteractionEnabled = true
            descriptionLabel.addGestureRecognizer(gesture)
        }
    }
    
    weak var addToWatchButton: RoundedButton! {
        didSet {
            addToWatchButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
            addToWatchButton.tintColor = .buttonBlue
            addToWatchButton.toggledTintColor = .buttonRed
        }
    }
    
    weak var infoTable: UIStackView! {
        didSet {
            let topLine = UIView()
            topLine.backgroundColor = UIColor.init(white: 38/255, alpha: 1)
            infoTable.addSubview(topLine)
            topLine.snp.makeConstraints { (make) in
                make.width.equalTo(infoTable)
                make.height.equalTo(1)
                make.left.equalTo(0)
                make.top.equalTo(-8)
            }
            let bottomLine = UIView()
            bottomLine.backgroundColor = UIColor.init(white: 38/255, alpha: 1)
            infoTable.addSubview(bottomLine)
            bottomLine.snp.makeConstraints { (make) in
                make.width.equalTo(infoTable)
                make.height.equalTo(1)
                make.left.equalTo(0)
                make.bottom.equalTo(8)
            }
            
            infoTable.axis = .vertical
            infoTable.spacing = 6
        }
    }
    
    weak var castView: CastView!

    var isFavorite: Bool = false {
        didSet {
            addToWatchButton.isToggled = isFavorite

            if isFavorite {
                addToWatchButton.setTitle("Nechci vidět", for: .normal)
            } else {
                addToWatchButton.setTitle("Chci vidět", for: .normal)
            }
        }
    }
    
    var id: Int?
    
    var watchMovie: WatchMovie?
    
    var movie: Movie? {
        didSet {
            
            titleLabel.text = movie?.title
            titleLabel.setLetterSpacing(-0.8)
            
            if movie?.overview != nil {
                descriptionLabel.text = movie?.overview
                descriptionLabel.setLineHeight(6)
            }
            
            if movie?.score != nil {
                ratingView.score = movie?.score
            }
            
            if movie?.origin != nil {
                let movieOrigin = InfoTableCell("Původ")
                movieOrigin.text.text = movie?.origin
                infoTable.addArrangedSubview(movieOrigin)
            }
            if movie?.genre != nil {
                let movieOrigin = InfoTableCell("Žánr")
                movieOrigin.text.text = movie?.genre
                infoTable.addArrangedSubview(movieOrigin)
            }
            
            if let runtime = movie?.runtime {
                let movieOrigin = InfoTableCell("Délka")
                movieOrigin.text.text = "\(runtime) min"
                infoTable.addArrangedSubview(movieOrigin)
            }
            
            if movie?.releaseDate != nil {
                let movieOrigin = InfoTableCell("V kinech od")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "d. M. yyyy"
                movieOrigin.text.text = dateFormatter.string(from: (movie?.releaseDate)!)
                infoTable.addArrangedSubview(movieOrigin)
            }
            
            if movie?.posterPath != nil {
                posterView.loadImage(usingUrl: TMDBRequest.getImage(for: movie!, type: .poster))
            }
            
            if movie?.backdropPath != nil {
                backdropImageView.loadImage(usingUrl: TMDBRequest.getImage(for: movie!, type: .backdrop))
            }
            
            fetchCredits()

            if let id = movie?.id {
                watchMovie = WatchMovie.mr_findFirst(byAttribute: "id", withValue: id)
                if (watchMovie != nil) {
                    isFavorite = true
                } else {
                    isFavorite = false
                }
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareAction))
        
        view.tintColor = .filmTint

        let castView = CastView()
        let headerView = UIView()
        
        let backdropImageView = UIImageView()
        let titleLabel = UILabel()
        let posterView = UIImageView()
        let ratingView = RatingView()
        let descriptionLabel = UILabel()
        
        let addToWatchButton = RoundedButton()

        let buttonStackView = UIStackView(arrangedSubviews: [addToWatchButton])
        buttonStackView.alignment = .fill
        buttonStackView.spacing = 5
        buttonStackView.distribution = .fillEqually
        
        let infoTable = UIStackView()
        
        let infoTableView = UIView()
        infoTableView.addSubview(infoTable)
        
        let stackView = UIStackView(arrangedSubviews: [buttonStackView, descriptionLabel, infoTableView, castView])
        
        let scrollView = UIScrollView()

        self.scrollView = scrollView
        self.titleLabel = titleLabel
        self.descriptionLabel = descriptionLabel
        self.stackView = stackView
        self.posterView = posterView
        self.backdropImageView = backdropImageView
        self.addToWatchButton = addToWatchButton
        self.infoTable = infoTable

        self.ratingView = ratingView
        self.castView = castView
        
        headerView.addSubview(backdropImageView)
        headerView.addSubview(posterView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(ratingView)

        scrollView.addSubview(headerView)
        scrollView.addSubview(stackView)

        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }

        backdropImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(0)
            make.width.equalTo(headerView)
            make.height.equalTo(220)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.width.equalTo(view).offset(-30)
            make.bottom.equalTo(scrollView)
            make.top.equalTo(headerView.snp.bottom).offset(20)
        }
        
        posterView.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(180)
            make.left.equalTo(15)
            make.bottom.equalTo(0)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(ratingView)
            make.right.equalTo(headerView).offset(-15)
            make.bottom.equalTo(backdropImageView).offset(-3)
        }

        headerView.snp.makeConstraints { (make) in
            make.width.equalTo(scrollView)
            make.height.equalTo(255)
            make.top.left.equalTo(0)
        }
        
        buttonStackView.snp.makeConstraints { (make) in
            make.width.equalTo(stackView)
            make.height.equalTo(45)
        }
        
        ratingView.snp.makeConstraints { (make) in
            make.left.equalTo(posterView.snp.right).offset(15)
            make.bottom.equalTo(posterView.snp.bottom).offset(-3)
            make.height.equalTo(20)
        }
        
        castView.snp.makeConstraints { (make) in
            make.width.equalTo(stackView)
        }
        
        infoTableView.snp.makeConstraints { (make) in
            make.height.equalTo(infoTable).offset(30)
        }

        infoTable.snp.makeConstraints { (make) in
            make.center.equalTo(infoTableView)
            make.width.equalTo(infoTableView)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.id != nil {
            fetchMovie()
        }

        view.backgroundColor = .background
    }
    
    func toggleDescription() {
        descriptionLabel.numberOfLines = 0
    }
    
    func addToFavorites() {
        isFavorite = isFavorite ? false : true

        if (watchMovie != nil) {
            watchMovie?.mr_deleteEntity()
            watchMovie = nil
        } else {
            watchMovie = WatchMovie.mr_createEntity()
            watchMovie?.id = (movie?.id)!
            watchMovie?.title = movie?.title
        }
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
    }
    
    func shareAction() {
        var sharingItems = [AnyObject]()
        
        if let id = movie?.id {
            sharingItems.append(URL(string: "https://www.themoviedb.org/movie/\(id)") as AnyObject)
        }
        
        let activityController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    
    
    func fetchCredits() {
        if let movieId = movie?.id {
            TMDBRequest.movie(id: movieId, type: .cast, success: { (data) in
                if let cast = data["cast"].array {
                    for person in cast {
                        self.movie?.cast?.append(Person(jsonResult: person))
                    }
                }
                
                DispatchQueue.main.async {
                    self.castView.cast = self.movie?.cast
                }
            })
        }
    }
    
    func fetchMovie() {
        if let id = self.id {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            TMDBRequest.movie(id: id, type: .detail, success: { (data) in
                self.movie = Movie(data)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
        }
    }
}
