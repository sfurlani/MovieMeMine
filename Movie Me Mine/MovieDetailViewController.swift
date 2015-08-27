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
    @IBOutlet weak var close: UIButton!
    
    var database: MovieDatabaseAPI!
    
    var movie: Movie! {
        didSet {
            print(movie)
            update()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        update()
        
    }
    
    private func update() {
        guard let desc = movieDescription, let movie = movie else {
            return
        }
        desc.text = movie.overview
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onClose(sender: AnyObject) {
       dismissViewControllerAnimated(true, completion: nil)
    }
}
