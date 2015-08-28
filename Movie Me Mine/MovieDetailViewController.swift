//
//  MovieDetailViewController.swift
//  Movie Me Mine
//
//  Created by SFurlani on 8/27/15.
//  Copyright © 2015 Optoro. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieBackdrop: UIImageView!
    @IBOutlet weak var close: UIButton!
    
    var database: MovieDatabaseAPI!
    
    var movie: Movie! {
        didSet {
            update()
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return .Fade
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        movieDescription.layer.cornerRadius = 8.0
        moviePoster.layer.cornerRadius = 8.0
        
        
        if let database = database, let toFetch = movie {
            database.fetchMovieDetails(toFetch) {
                guard let fetched = $0 else {
                    return
                }
                
                self.movie = fetched
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        update()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        movieDescription.flashScrollIndicators()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        close.layer.cornerRadius = close.frame.width / 2
    }
    
    private func update() {
        guard let desc = movieDescription, let movie = movie else {
            return
        
        }
        dispatch_async(dispatch_get_main_queue()) {
            desc.text = movie.movieDescription()
            desc.setContentOffset(CGPointZero, animated: false)
            desc.flashScrollIndicators()
        }
        
        database.fetchPosterImage(movie, size: nil) { (image) in
            UIView.transitionWithView( self.moviePoster,
                duration: 0.2,
                options: [.CurveEaseOut, .TransitionCrossDissolve, .AllowAnimatedContent],
                animations: { self.moviePoster.image = image },
                completion: nil)
        }
        
        database.fetchBackdropImage(movie, size: nil) { (image) in
            UIView.transitionWithView( self.movieBackdrop,
                duration: 0.2,
                options: [.CurveEaseOut, .TransitionCrossDissolve, .AllowAnimatedContent],
                animations: { self.movieBackdrop.image = image },
                completion: nil)
        }
        
    }

    @IBAction func onClose(sender: AnyObject) {
       dismissViewControllerAnimated(true, completion: nil)
    }
}
