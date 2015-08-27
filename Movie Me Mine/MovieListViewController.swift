//
//  MovieListViewController.swift
//  Movie Me Mine
//
//  Created by SFurlani on 8/27/15.
//  Copyright © 2015 Optoro. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var movieGrid: UICollectionView!
    @IBOutlet weak var searchProgress: UIProgressView!
    @IBOutlet weak var downloadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: Properties
    
    var database: MovieDatabaseAPI?
    
    var dataSource: MovieListDataSource? {
        didSet {
            
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDatabase(MovieDatabaseAPI())
        self.searchProgress.progress = 0.0
        self.searchProgress.hidden = true
        self.downloadIndicator.stopAnimating()
    }

    
    private func configureDatabase(database: MovieDatabaseAPI) {
        database.configure { (database: MovieDatabaseAPI) in
            print(database.configuration == nil ? "No Config" : "Got Config \(database.configuration.baseURL)")
            
            
            database.popularMovies{
                
                guard let movies = $0 else {
                    return
                }
                
                let source = MovieListDataSource(movies: movies, databaseAPI: database)
                source.collectionView = self.movieGrid
                self.dataSource = source
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.movieGrid.reloadData()
                }
            }
            
        }
        self.database = database
    }
    
    // MARK: Appearance
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return .Fade
    }
    
    func updateView() {
        
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }

}

extension MovieListViewController : UICollectionViewDelegate {

}

extension MovieListViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        print("cancel")
        searchBar.text = nil
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("search: \(searchBar.text)")
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

