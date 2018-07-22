//
//  MovieDetails.swift
//  MovieApp
//
//  Created by techno krishna on 21/07/18.
//  Copyright © 2018 techno krishna. All rights reserved.
//

import Foundation

class MovieDetails {
        private let baseUrl:String = "https://image.tmdb.org/t/p/w200/"
        var id:Int?
        var popularity:Double?
        var poster_path:String?
        var release_date:String?
        var title:String?
        var runtime:Int?
        var overview: String?
        var genres:[Genres] = []
        var languages:[Languages] = []
    
        init(json:NSDictionary) {
            self.popularity = json["popularity"] as? Double
            self.poster_path = baseUrl+(json["poster_path"] as? String ?? "")!
            self.release_date = json["release_date"] as? String
            self.title = json["title"] as? String
            self.runtime = json["runtime"] as? Int
            self.overview = json["overview"] as? String
            self.id = json["id"] as? Int
            if let genres = json["genres"] as? [NSDictionary]{
                for genre in genres {
                    self.genres.append(Genres(json: genre))
                }
            }
            
            if let languages = json["spoken_languages"] as? [NSDictionary]{
                for lang in languages {
                    self.languages.append(Languages(json: lang))
                }
            }
        }
    
    var genresString: String {
        return genres.map { $0.name! }.joined(separator: ", ")
    }

    var languagesString: String {
        return languages.map { $0.name! }.joined(separator: ", ")
    }
}
