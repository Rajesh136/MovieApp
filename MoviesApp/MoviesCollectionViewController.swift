//
//  MoviesCollectionViewController.swift
//  MovieApp
//
//  Created by techno krishna on 21/07/18.
//  Copyright © 2018 techno krishna. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MoviesCollectionViewController: UICollectionViewController {
    
    let customLayout = CustomFlowLayout(
        cellsPerRow: 3,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    )
    var viewModel = MoviesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.collectionViewLayout = customLayout
        viewModel.collectionView = collectionView
        viewModel.getMovies()
      }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.configCell(indexPath)
    }

    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewModel.scrollViewDidScroll(scrollView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailsSegue" ,
            let nextVC = segue.destination as? MovieDetailsViewController, let cell = sender as? MovieCollectionViewCell, let index = collectionView?.indexPath(for: cell) {
            
            
            nextVC.id = viewModel.movies[index.row].id
            
        }
    }
}
