//
//  MovieCollectionViewCell.swift
//  Movie Me Mine
//
//  Created by SFurlani on 8/27/15.
//  Copyright © 2015 Optoro. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    static let nibName = "MovieCollectionViewCell"
    
    static let reuseIdentifier = "movieCell"
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var movie: Movie? {
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
        
        
    }

}
