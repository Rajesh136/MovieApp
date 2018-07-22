//
//  MoviesViewModel.swift
//  MovieApp
//
//  Created by techno krishna on 21/07/18.
//  Copyright © 2018 techno krishna. All rights reserved.
//

import Foundation
import UIKit

class MoviesViewModel {
    var page:Int = 1
    var movieID:Int = 0
    var total_Page:Int = 0
    var gotData:Bool = false
    var movies_url:String {
        return String(format: Constant.BASE_URL+"popular?api_key="+Constant.API_KEY+"&page=\(page)")
    }
    var movie_details_url:String {
        return String(format: Constant.BASE_URL + "\(movieID)?api_key=" + Constant.API_KEY)
    }
    var movies:[MovieDetails] = []
    var collectionView:UICollectionView?
    
    init(page:Int) {
        self.page = page
    }

    init(id:Int) {
        self.movieID = id
    }
 
    
    func getMovies(){
        MoviesListAPI.shared.getDataFromServer(urlString: self.movies_url) { (data) in
            DispatchQueue.global(qos: .background).async {
                
            if let json = data {
                let entities = MovieEntities(json: json as! NSDictionary)
                self.total_Page = entities.total_results!
                    if let results = entities.results {
                        self.movies.append(contentsOf:results)
                    }
                DispatchQueue.main.async {
                     self.collectionView?.reloadData()
                }
               
            }
        }
        }
    }
    
    func getMovieDetails(completion:@escaping (MovieDetails)->Void){
        MoviesListAPI.shared.getDataFromServer(urlString: self.movie_details_url) { (data) in
            if let json = data {
                let details = MovieDetails(json: json as! NSDictionary)
                completion(details)
            }
        }
    }
    
    func configCell(_ indexPath:IndexPath)->UICollectionViewCell{
        let movie = movieAtIndexPath(indexPath.row)
        let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: "MovieCellID", for: indexPath) as! MovieCollectionViewCell
        
        cell.posterImageView.imageFromUrl(movie.poster_path!)
        return cell
    }
    
    func movieAtIndexPath(_ index:Int)->MovieDetails{
        return movies[index]
    }
    
    //
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height && page <= total_Page{
                page = page + 1
                getMovies()
        }
    }
    
}
