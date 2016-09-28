//
//  MovieDetailViewController.swift
//  Tableviews_Part_3
//
//  Created by Sabrina Ip on 9/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

        @IBOutlet weak var moviePosterImageView: UIImageView!
        @IBOutlet weak var genreLabel: UILabel!
        @IBOutlet weak var locationLabel: UILabel!
        @IBOutlet weak var summaryLabel: UILabel!
        @IBOutlet weak var summaryFullTextLabel: UILabel!
        
        internal var selectedMovie: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateViews(for: self.selectedMovie)
    }

    internal func updateViews(for movie: Movie) {
        self.moviePosterImageView.image = UIImage(named: movie.poster)!
        self.genreLabel.text = "Genre: " + movie.genre.capitalized
        self.locationLabel.text = "Locations: " + movie.locations.joined(separator: ", ")
        self.summaryFullTextLabel.text = movie.summary
    }
}
