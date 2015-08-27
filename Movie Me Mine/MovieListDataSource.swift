//
//  MovieListDataSource.swift
//  Movie Me Mine
//
//  Created by SFurlani on 8/27/15.
//  Copyright © 2015 Optoro. All rights reserved.
//

import UIKit

final class MovieListDataSource: NSObject {
    let movies: [Movie]
    
    let databaseAPI: MovieDatabaseAPI
    
    var collectionView: UICollectionView? {
        didSet {
            collectionView?.dataSource = self
            collectionView?.reloadData()
            let cellNib = UINib(nibName:MovieCell.nibName , bundle: nil)
            collectionView?.registerNib(cellNib, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        }
    }
    
    init(movies: [Movie], databaseAPI: MovieDatabaseAPI, collectionView: UICollectionView? = nil) {
        self.movies = movies
        self.collectionView = collectionView
        self.databaseAPI = databaseAPI
    }
    
    
}

extension MovieListDataSource : UICollectionViewDataSource {

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MovieCell.reuseIdentifier, forIndexPath: indexPath)
        
        guard let movieCell = cell as? MovieCell else {
            return cell
        }
        
        movieCell.databaseAPI = self.databaseAPI
        
        guard indexPath.row < movies.count else {
            return movieCell
        }
        
        movieCell.movie = movies[indexPath.row]
        
        return movieCell
    }
    
}