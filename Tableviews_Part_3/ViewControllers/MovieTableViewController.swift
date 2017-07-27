//
//  MovieTableViewController.swift
//  Tableviews_Part_2//
//  Created by Jason Gresh on 9/22/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

enum MovieType {
	case action, animation, drama
}

class MovieTableViewController: UITableViewController {
	var movieData: [Movie]!
	let cellIdentifier: String = "MovieTableViewCell"
	let cellIdentifierRightAligned: String = "MovieRightAlignedTableViewCell"

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "Movies"
		
		self.movieData = []
		
		for i in movies {
			self.movieData.append(Movie(from: i))
		}
		
		self.movieData = self.movieData.sorted(by: { (a: Movie, b: Movie) -> Bool in
			return a.genre > b.genre ? false : true
		})
		
		self.tableView.rowHeight = UITableViewAutomaticDimension
		self.tableView.estimatedRowHeight = 200.0
	}
	
	
	// MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.movieData.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let identifier: String = indexPath.row % 2 == 0 ? cellIdentifier : cellIdentifierRightAligned
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
		let cellMovie: Movie = self.movieData[indexPath.row]
		
		if let movieCell = cell as? MovieTableViewCell {
			movieCell.movieTitleLabel.text = cellMovie.title + " - (\(cellMovie.genre))"
			movieCell.movieSummaryLabel.text = cellMovie.summary
			movieCell.moviePosterImageView.image = UIImage(named: cellMovie.poster)
		}
		else if let movieRightCell = cell as? MovieRightAlignedTableViewCell {
			movieRightCell.movieTitleLabel.text = cellMovie.title + " - (\(cellMovie.genre))"
			movieRightCell.movieSummaryLabel.text = cellMovie.summary
			movieRightCell.moviePosterImageView.image = UIImage(named: cellMovie.poster)
		}

		return cell
	}

}
