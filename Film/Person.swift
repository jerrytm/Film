//
//  Person.swift
//  Film
//
//  Created by Tomas Vosicky on 14.12.16.
//  Copyright © 2016 Tomas Vosicky. All rights reserved.
//

import UIKit
import SwiftyJSON

class Person: NSObject {
    var id: Int!
    var name: String!
    var character: String?
    var profilePath: String?
    
    override init(){}
    
    init(jsonResult: JSON) {
        if let id = jsonResult["id"].int {
            self.id = id
        }
        if let name = jsonResult["name"].string {
            self.name = name
        }
        if let character = jsonResult["character"].string {
            self.character = character
        }
        if let profilePath = jsonResult["profile_path"].string {
            self.profilePath = profilePath
        }
    }
}

