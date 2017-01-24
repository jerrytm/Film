//
//  Movie.swift
//  Film
//
//  Created by Tomas Vosicky on 22.11.16.
//  Copyright © 2016 Tomas Vosicky. All rights reserved.
//

import UIKit
import SwiftyJSON

class Movie: NSObject {
    var id: Int!
    var title: String!
    var overview: String?
    var origin: String?
    var genre: String?
    var releaseDate: Date?
    var runtime: Int?
    var poster: UIImage?
    var posterPath: String?
    var backdropPath: String?
    var score: Double?
    var cast: [Person]? = []
    
    init(_ id: Int, _ title: String) {
        self.id = id
        self.title = title
    }
    
    override init() {}
    
    init(_ jsonResult: JSON) {
        if let voteAverage = jsonResult["vote_average"].double {
            self.score = voteAverage
        }
        if let posterPath = jsonResult["poster_path"].string {
            self.posterPath = posterPath
        }
        if let backdropPath = jsonResult["backdrop_path"].string {
            self.backdropPath = backdropPath
        }
        if let title = jsonResult["title"].string {
            self.title = title
        }
        if let overview = jsonResult["overview"].string {
            self.overview = overview
        }
        if let runtime = jsonResult["runtime"].int {
            if runtime != 0 {
                self.runtime = runtime
            }
        }
        if let release = jsonResult["release_date"].string {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.releaseDate = dateFormatter.date(from: release)
        }
        if let origin = jsonResult["production_countries"].array {
            if let name = origin.first?["name"].string {
                self.origin = name
            }
        }
        if let genre = jsonResult["genres"].array {
            if let name = genre.first?["name"].string {
                self.genre = name
            }
        }
        if let id = jsonResult["id"].int {
            self.id = id
        }
        if let score = jsonResult["vote_average"].double {
            self.score = score
        }
    }
}
