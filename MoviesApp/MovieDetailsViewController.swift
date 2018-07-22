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
    var viewModel = MoviesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        if let movieId = id {
         viewModel.movieID = movieId
         viewModel.getMovieDetails(completion: { (movieDetails) in
                     DispatchQueue.main.async {
                         self.configureData(movieDetails)
                     }

         })
        }
    }

    func updateUI(){
        self.popularityLabel.adjustsFontSizeToFitWidth = true
        self.durationLabel.adjustsFontSizeToFitWidth = true
    }
    
    func configureData(_ details:MovieDetails){
            self.movieImage.imageFromUrl(details.poster_path!)
            self.movieTitle.text = details.title
            self.popularityLabel.text = "Popularity: \(details.popularity ?? 0.0)"
            self.durationLabel.text = "Duration: \(min(mins: details.runtime ?? 0))"
            self.releaseDateLabel.text = details.release_date
            self.overViewLabel.text = details.overview
            self.gendersLabel.text  = details.genresString
            self.languagesLabel.text = details.languagesString
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
