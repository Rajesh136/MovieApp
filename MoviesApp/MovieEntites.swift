//
//  MovieEntites.swift
//  MovieApp
//
//  Created by techno krishna on 21/07/18.
//  Copyright © 2018 techno krishna. All rights reserved.
//

import Foundation


class MovieEntities {
    var page:Int?
    var total_results:Int?
    var total_pages:Int?
    var results:[MovieDetails]?
    
    init(json:NSDictionary) {
        self.page = json["page"] as? Int
        self.total_results = json["total_results"] as? Int
        self.total_pages = json["total_pages"] as? Int
        if let results = json["results"] as? [NSDictionary] {
            self.results = results.map{MovieDetails(json:$0)}
        }
    }
}
