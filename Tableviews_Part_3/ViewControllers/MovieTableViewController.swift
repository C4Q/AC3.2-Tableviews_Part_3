//
//  MovieTableViewController.swift
//  Tableviews_Part_3//
//  Created by Jason Gresh on 9/22/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    enum Century: Int { case twentieth, twentyFirst }
    enum Genre: Int {
        case animation
        case action
        case drama
    }
    
    internal var movieData: [Movie]?

    internal let rawMovieData: [[String : Any]] = movies
    let cellIdentifier: String = "MovieTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Movies"
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200.0
        
        // converting from array of dictionaries
        // to an array of Movie structs
        var movieContainer: [Movie] = []
        for rawMovie in rawMovieData {
            movieContainer.append(Movie(from: rawMovie))
        }
        movieData = movieContainer
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let menuBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "reel"),
                                                             style: .plain,
                                                             target: nil,
                                                             action: nil)
        self.navigationItem.setLeftBarButton(menuBarButton, animated: false)
        
        if let navigationController: UINavigationController = self.navigationController {
            navigationController.navigationBar.tintColor = UIColor.white
            navigationController.navigationBar.barTintColor = UIColor.reelGoodGreen
            navigationController.navigationBar.titleTextAttributes = [
                NSForegroundColorAttributeName : UIColor.white,
                NSFontAttributeName : ReelGoodFonts.ReelGoodNavBarFont!
            ]
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let genre = Genre.init(rawValue: section),
            let data = byGenre(genre) else  {
                return 0
        }
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        guard let genre = Genre.init(rawValue: indexPath.section),
            let data = byGenre(genre) else {
            return cell
        }
        
        if let movieCell: MovieTableViewCell = cell as? MovieTableViewCell {
            movieCell.movieTitleLabel.text = data[indexPath.row].title
            movieCell.movieSummaryLabel.text = data[indexPath.row].summary
            movieCell.moviePosterImageView.image = UIImage(named: data[indexPath.row].poster)
            return movieCell
        }
        
        cell.textLabel?.text = data[indexPath.row].title
        cell.detailTextLabel?.text = String(data[indexPath.row].year)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let genre = Genre.init(rawValue: section) else {
            return ""
        }
        
        switch genre {
        case .action:
            return "Action"
        case .animation:
            return "Animation"
        case .drama:
            return "Drama"
        }
    }
    
    // MARK: - Utility
    func by(_ c: Century) -> [Movie]? {
        let filter: (Movie) -> Bool
        switch c {
        case .twentieth:
            filter = { (a) -> Bool in
                a.year < 2001
            }
        case .twentyFirst:
            filter = { (a) -> Bool in
                a.year >= 2001
            }
        }
        
        // after filtering, sort
        let filtered = movieData?.filter(filter).sorted { $0.year < $1.year }
        
        return filtered
    }
    
    func byGenre(_ genre: Genre) -> [Movie]? {
        let filter: (Movie) -> Bool
        switch genre {
        case .action:
            filter = { (a) -> Bool in
                a.genre == "action"
            }
        case .animation:
            filter = { (a) -> Bool in
                a.genre == "animation"
            }
        case .drama:
            filter = { (a) -> Bool in
                a.genre == "drama"
            }
        }
        
        // after filtering, sort
        let filtered = movieData?.filter(filter).sorted { $0.year < $1.year }
        
        return filtered
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // 1. check sender for the cell that was tapped
        if let tappedMovieCell: MovieTableViewCell = sender as? MovieTableViewCell {
            
            // 2. check for the right storyboard segue

            if segue.identifier == "MovieDetailSegue" {
                
                // 3. get reference to the destination view controller
                let movieDetailViewController: MovieDetailViewController = segue.destination as! MovieDetailViewController
                
                // 4. get our cell's indexPath
                let cellIndexPath: IndexPath = self.tableView.indexPath(for: tappedMovieCell)!
                
                // 5. get our cell's Movie
                guard let genre = Genre.init(rawValue: cellIndexPath.section),
                    let data = byGenre(genre) else {
                        return
                }
                
                // 6. set the destionation's selectedMovie property
                let selectedMovie: Movie = data[cellIndexPath.row]
                movieDetailViewController.selectedMovie = selectedMovie
            }
            
            if segue.identifier == "MovieCastDetailSegue" {
                
                // 3. get reference to the destination view controller
                let movieCastDetailViewController: MovieCastDetailViewController = segue.destination as! MovieCastDetailViewController
                
                // 4. get our cell's indexPath
                let cellIndexPath: IndexPath = self.tableView.indexPath(for: tappedMovieCell)!
                
                // 5. get our cell's Movie
                guard let genre = Genre.init(rawValue: cellIndexPath.section),
                    let data = byGenre(genre) else {
                        return
                }
                
                // 6. set the destionation's selectedMovie property
                let selectedMovie: Movie = data[cellIndexPath.row]
                movieCastDetailViewController.selectedMovie = selectedMovie
            }
        }
    }
}
