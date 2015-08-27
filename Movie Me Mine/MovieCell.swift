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
    
    override var highlighted: Bool {
        didSet {
            self.poster.alpha = highlighted ? 0.5 : 1.0
        }
    }
    
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
        poster.image = nil
        poster.backgroundColor = UIColor.clearColor()
    }
    
    private func update() {
        titleLabel.text = movie?.title
        releaseDateLabel.text = movie?.releaseDate
        if let downloadable = movie {
            downloadPoster(downloadable)
        }
    }
    
    
    
    private func downloadPoster(movie: Movie) {
        databaseAPI?.fetchPosterImage(movie, size: Int(self.poster.frame.width)) { (image) -> () in
            guard self.movie?.id == movie.id else {
                return
            }
            UIView.transitionWithView( self.poster,
                duration: 0.2,
                options: [.CurveEaseOut, .TransitionCrossDissolve],
                animations: {
                    self.poster.image = image
                },
                completion: nil)
        }
    }
    
}
