//
//  ListViewController.swift
//  Film
//
//  Created by Tomas Vosicky on 06.12.16.
//  Copyright © 2016 Tomas Vosicky. All rights reserved.
//

import UIKit
import MagicalRecord

private let reuseIdentifier = "Cell"

class ListViewController: UITableViewController {
    
    var movies: [WatchMovie]! = []

    var detailViewController: DetailViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Shlédnuté"
        
        view.backgroundColor = .background
        tableView.backgroundView?.backgroundColor = .background
        
        tableView.separatorColor = .separator
        tableView.register(Movie2TableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

        fetchAllMovies()
        tableView.reloadData()
    }

    func fetchAllMovies() {
        movies = WatchMovie.mr_findAll() as! [WatchMovie]!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchAllMovies()
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Movie2TableViewCell
        cell.movie = movies[indexPath.row]
        return cell
    }
    
    func showDetail(for id: Int) {
        detailViewController = DetailViewController()
        detailViewController?.id = id
        navigationController?.pushViewController(detailViewController!, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetail(for: movies[indexPath.row].id)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action: UITableViewRowAction = UITableViewRowAction.init(style: .destructive, title: "Viděl jsem") { (action, indexPath) in
            
            self.movies.remove(at: indexPath.row).mr_deleteEntity()
            tableView.deleteRows(at: [indexPath], with: .fade)
            NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        }
        
        return [action]
    }
}
