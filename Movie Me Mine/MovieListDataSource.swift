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
    
    var collectionView: UICollectionView? {
        didSet {
            collectionView?.dataSource = self
            collectionView?.reloadData()
            let cellNib = UINib(nibName:MovieCollectionViewCell.nibName , bundle: nil)
            collectionView?.registerNib(cellNib, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        }
    }
    
    init(movies: [Movie]) {
        self.movies = movies
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
        return collectionView.dequeueReusableCellWithReuseIdentifier(MovieCollectionViewCell.reuseIdentifier, forIndexPath: indexPath)
    }
    
}