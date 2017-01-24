//
//  SearchViewController.swift
//  Film
//
//  Created by Tomas Vosicky on 25.11.16.
//  Copyright © 2016 Tomas Vosicky. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchNavigationController: UINavigationController {
    
    weak var searchPlaceholder: UIView!

    override func viewDidLoad() {
        createSearchPlaceholder()
    }
    
    func showSearchPlaceholder() {
        searchPlaceholder.alpha = 1
    }
    
    func hideSearchPlaceholder() {
        searchPlaceholder.alpha = 0
    }

    func createSearchPlaceholder() {
        
        let searchPlaceholder = UIView()
        searchPlaceholder.backgroundColor = .background
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Nejčastěji hledané"
        placeholderLabel.textColor = .white
        placeholderLabel.font = UIFont.systemFont(ofSize: 21, weight: UIFontWeightLight)
        
        searchPlaceholder.addSubview(placeholderLabel)
        view.addSubview(searchPlaceholder)
        
        let button = UIButton()
        button.setTitle("Hvězdné války", for: .normal)
        button.setTitleColor(.filmTint, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        let button2 = UIButton()
        button2.setTitle("Forrest Gump", for: .normal)
        button2.setTitleColor(.filmTint, for: .normal)
        button2.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        let stackView = UIStackView(arrangedSubviews: [button, button2])
        stackView.axis = .vertical
        stackView.spacing = 0
        searchPlaceholder.addSubview(stackView)
        
        self.searchPlaceholder = searchPlaceholder
        
        searchPlaceholder.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(62)
            make.right.bottom.left.equalTo(view)
        }

        stackView.snp.makeConstraints { (make) in
            make.center.equalTo(searchPlaceholder)
        }
        
        placeholderLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(stackView.snp.top).offset(-20)
            make.centerX.equalTo(stackView)
        }

        showSearchPlaceholder()
    }

}

class SearchViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    let searchController = UISearchController(searchResultsController: nil)
    var navigationControl: SearchNavigationController? = nil
    

    var movies: [Movie]? = []
    
    override func viewDidLoad() {
        
        title = "Vyhledávání"
        
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        view.backgroundColor = .background

        navigationItem.titleView = searchController.searchBar
        
        searchController.searchBar.barStyle = .blackTranslucent
        searchController.searchBar.sizeToFit()
        searchController.searchBar.keyboardAppearance = .dark
        
        tableView.backgroundView?.backgroundColor = .background
        tableView.separatorColor = .separator
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = movies?.count
        if searchController.isActive && searchController.searchBar.text != "" && (count != nil) {
            return count!
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> MovieTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell

        if searchController.isActive && searchController.searchBar.text != "" {
            if let movie = movies?[indexPath.row] {
                cell.textLabel!.text = movie.title
            }
        }

        return cell
    }

    func fetchMovies(query: String) {
        TMDBRequest.search(query: query) { (data) in
            
            if let results = data["results"].array {
                self.movies?.removeAll()
                
                for result in results {
                    self.movies?.append(Movie(result))
                }
                
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
        }

    }
    
    func showDetail(for movie: Movie) {
        detailViewController = DetailViewController()
        detailViewController?.id = movie.id
        navigationController?.pushViewController(detailViewController!, animated: true)
    }
}


extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text!
        if text == "" {
            navigationControl?.showSearchPlaceholder()
        } else {
            navigationControl?.hideSearchPlaceholder()
            fetchMovies(query: text)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print(selectedScope)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movie = movies?[indexPath.row] {
            showDetail(for: movie)
        }
    }
}
