//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by techno krishna on 21/07/18.
//  Copyright © 2018 techno krishna. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var showbtn: UIButton!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var gendersLabel: UILabel!
    @IBOutlet weak var overViewLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    var id:Int?
    var bUrl:String {
        return String(format: Constant.BASE_URL + "\(111)?api_key=" + Constant.API_KEY)
    }
   // var baseUrl:String = "https://api.themoviedb.org/3/movie/8355?api_key=7a312711d0d45c9da658b9206f3851dd"
    var movieDetails:MovieDetails?
    var viewModel:MoviesViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        if let movieId = id {
         viewModel = MoviesViewModel(id: movieId)
         viewModel?.getMovieDetails(completion: { (movieDetails) in
            self.movieDetails = movieDetails
                     DispatchQueue.main.async {
                         self.configureData()
                     }

         })
        }
    }

    func updateUI(){
        self.popularityLabel.adjustsFontSizeToFitWidth = true
        self.durationLabel.adjustsFontSizeToFitWidth = true
    }
    
    func configureData(){
        if let details = self.movieDetails {
            self.movieImage.imageFromUrl(details.poster_path!)
            self.movieTitle.text = details.title
            self.popularityLabel.text = "Popularity: \(details.popularity ?? 0.0)"
            self.durationLabel.text = "Duration: \(min(mins: details.runtime ?? 0))"
            self.releaseDateLabel.text = details.release_date
            self.overViewLabel.text = details.overview
            self.gendersLabel.text  = details.genresString
            self.languagesLabel.text = details.languagesString
        }
    }
   
    @IBAction func showAction(_ sender: UIButton) {
        if showbtn.currentTitle == "Show full" {
            overViewLabelHeight.constant = overViewLabel.heightForView()
            mainScrollView.contentSize.height = view.frame.height+overViewLabel.heightForView()
            showbtn.setTitle("Show less", for: .normal)
        } else {
            overViewLabelHeight.constant = 50
            mainScrollView.contentSize.height = view.frame.height+50
            showbtn.setTitle("Show full", for: .normal)
        }
    }
    
    
}
