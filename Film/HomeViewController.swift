//
//  HomeViewController.swift
//  Film
//
//  Created by Tomas Vosicky on 22.11.16.
//  Copyright © 2016 Tomas Vosicky. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "Cell"


class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var movies: [Movie]? = []

    var detailViewController: DetailViewController?

    func fetchMovies() {
        TMDBRequest.discover { (data) in
            
            if let results = data["results"].array {
                self.movies?.removeAll()
                
                for result in results {
                    self.movies?.append(Movie(result))
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.view.tintColor = .filmTint

        title = "Objevy"
        
        fetchMovies()

        // 3D Touch register
        registerForPreviewing(with: self as UIViewControllerPreviewingDelegate, sourceView: collectionView!)
    
        collectionView?.register(MovieItemCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .background
        view.tintColor = .filmTint
        collectionView?.indicatorStyle = .white
    }
    
    func showDetail(forMovie movie: Movie) {
        detailViewController = DetailViewController()
        detailViewController?.id = movie.id
        navigationController?.pushViewController(detailViewController!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 176)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 20, 10, 20)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieItemCollectionViewCell
    
        let movie = movies?[indexPath.row]
        cell.movie = movie
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = movies?[indexPath.row] {
            showDetail(forMovie: movie)
        }
    }
}

extension HomeViewController: UIViewControllerPreviewingDelegate {
    
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = collectionView?.indexPathForItem(at: location),
            let cell = collectionView?.cellForItem(at: indexPath) else { return nil }
        detailViewController = DetailViewController()
        detailViewController?.id = movies?[indexPath.row].id
        detailViewController?.preferredContentSize = CGSize(width: 0.0, height: 250)
        previewingContext.sourceRect = cell.frame
        return detailViewController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
}
