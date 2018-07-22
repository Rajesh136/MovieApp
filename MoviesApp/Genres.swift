//
//  Gendre.swift
//  MoviesApp
//
//  Created by techno krishna on 21/07/18.
//  Copyright © 2018 techno krishna. All rights reserved.
//

import Foundation

class Genres {
    var id:Int?
    var name:String?
    init(json:NSDictionary) {
        self.id = json["id"] as? Int
        self.name = json["name"] as? String
    }
}

