//
//  TabsController.swift
//  Film
//
//  Created by Tomas Vosicky on 25.11.16.
//  Copyright © 2016 Tomas Vosicky. All rights reserved.
//

import UIKit
import CoreData

class TabsController: UITabBarController {

    var managedObjectContext: NSManagedObjectContext? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let collectionViewLayout = UICollectionViewFlowLayout()
        let home = HomeViewController(collectionViewLayout: collectionViewLayout)

        let homeNavigationController = UINavigationController(rootViewController: home)
        homeNavigationController.tabBarItem = UITabBarItem.init(title: "Objevy", image: #imageLiteral(resourceName: "MovieTabIcon"), selectedImage: #imageLiteral(resourceName: "MovieTabIconActive"))
        
        let watched = ListViewController()
        let watchedNavigationController = UINavigationController(rootViewController: watched)
        watchedNavigationController.tabBarItem = UITabBarItem.init(tabBarSystemItem: .bookmarks, tag: 0)

        
        let search = SearchViewController()
        let searchController = SearchNavigationController(rootViewController: search)
        search.navigationControl = searchController
        searchController.tabBarItem = UITabBarItem.init(tabBarSystemItem: .search, tag: 0)
        let searchNavigationController = searchController
        
        viewControllers = [homeNavigationController, watchedNavigationController, searchNavigationController]
        
        tabBar.barTintColor = .background
        view.tintColor = .filmTint
    }    

}
