//
//  MoviesViewModel.swift
//  MovieApp
//
//  Created by techno krishna on 21/07/18.
//  Copyright © 2018 techno krishna. All rights reserved.
//

import Foundation
import UIKit

class MoviesViewModel:NSObject {
    var page:Int = 1
    var movieID:Int = 0
    var total_Page:Int = 0
    var movies_url:String {
        return String(format: Constant.BASE_URL+"popular?api_key="+Constant.API_KEY+"&page=\(page)")
    }
    var movie_details_url:String {
        return String(format: Constant.BASE_URL + "\(movieID)?api_key=" + Constant.API_KEY)
    }
    var movies:[MovieDetails] = []
    var collectionView:UICollectionView?
    
    // get movies entities form server
    func getMovies(){
        MoviesListAPI.shared.getDataFromServer(urlString: self.movies_url) { (data) in
            DispatchQueue.global(qos: .background).async {
                
            if let json = data {
                let entities = MovieEntities(json: json as! NSDictionary)
                self.total_Page = entities.total_results ?? 0
                    if let moviesList = entities.results {
                        for  movie in moviesList {
                            DispatchQueue.main.async {
                                self.collectionView?.performBatchUpdates({
                                    let indexPath = IndexPath(row: self.movies.count, section: 0)
                                    self.movies.append(movie)
                                    self.collectionView?.insertItems(at: [indexPath])
                                }, completion: nil)
                            }
                            
                        }
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
            cell.posterImageView.imageFromUrl(movie.poster_path ?? "")
        return cell
    }
    
    func movieAtIndexPath(_ index:Int)->MovieDetails{
        return movies[index]
    }
    // pagination
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height{
                page = page + 1
                getMovies()
        }
    }
    
}
