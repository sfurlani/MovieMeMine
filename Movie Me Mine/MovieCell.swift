//
//  MovieCell.swift
//  Movie Me Mine
//
//  Created by SFurlani on 8/27/15.
//  Copyright © 2015 Optoro. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    static let nibName = "MovieCell"
    
    static let reuseIdentifier = "movieCell"
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            update()
        }
    }
    
    var databaseAPI: MovieDatabaseAPI? {
        didSet {
            update()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movie = nil
    }
    
    private func update() {
        titleLabel.text = movie?.title
        releaseDateLabel.text = movie?.releaseDate
        poster.image = nil
        if let downloadable = movie {
            downloadPoster(downloadable)
        }
    }

    
    private func downloadPoster(movie: Movie) {
        databaseAPI?.fetchPosterImage(movie, size: Int(poster.frame.width) ) {
            guard self.movie?.id == movie.id else {
                return
            }
            self.poster.image = $0
        }
    }
    
}
