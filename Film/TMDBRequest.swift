//
//  TMDB.swift
//  Film
//
//  Created by Tomas Vosicky on 06.01.17.
//  Copyright © 2017 Tomas Vosicky. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private let key = "a3a87d6f6b49e5cb3991aa733362da75"
private let lang = "cs-CZ"

class TMDBRequest {
    
    static let discoverUrl = URL.init(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(key)&language=\(lang)")

    typealias SuccessHandler = (JSON) -> Void
    
    class func discover(success: @escaping SuccessHandler) {
        Alamofire.request(discoverUrl!).responseJSON { (resObj) -> Void in
            
            if resObj.result.isSuccess {
                let resJson = JSON(resObj.result.value!)
                success(resJson)
            }
        }
    }
    
    class func search(query: String, success: @escaping SuccessHandler) {
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(key)&language=\(lang)&page=1&query=" + query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)!
        
        Alamofire.request(url).responseJSON { (resObj) -> Void in
            
            if resObj.result.isSuccess {
                let resJson = JSON(resObj.result.value!)
                success(resJson)
            }
        }
    }
    
    enum RequestType {
        case cast, detail
    }
    
    enum ReguestImageType {
        case poster, backdrop
    }

    class func movie(id: Int, type: RequestType, success: @escaping SuccessHandler) {
        let movieUrl: URL
        
        switch type {
        case .cast:
            movieUrl = URL.init(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(key)&language\(lang)")!
        case .detail:
            movieUrl = URL.init(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(key)&language=\(lang)")!
        }
        
        Alamofire.request(movieUrl).responseJSON { (resObj) -> Void in
            
            if resObj.result.isSuccess {
                let resJson = JSON(resObj.result.value!)
                success(resJson)
            }
        }
    }
    
    class func getImage(for movie: Movie, type: ReguestImageType) -> URL {
        let url: URL
        
        switch type {
        case .poster:
            url = URL(string: "https://image.tmdb.org/t/p/w300_and_h450_bestv2" + (movie.posterPath)!)!
        case .backdrop:
            url = URL(string: "https://image.tmdb.org/t/p/w780" + (movie.backdropPath)!)!
        }
        
        return url
    }
    
    class func getImage(for person: Person) -> URL {
        return URL(string: "https://image.tmdb.org/t/p/w300_and_h450_bestv2" + (person.profilePath)!)!
    }
}


//            let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.dark)
//            let blurView = UIVisualEffectView(effect: darkBlur)
//            blurView.frame = imageView.bounds
//            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            blurView.alpha = 0.5
//            imageView.addSubview(blurView)


//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.view.backgroundColor = .clear
