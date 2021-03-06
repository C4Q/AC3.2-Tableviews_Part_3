# AC3.2-Tableviews Part 3 Exercise Solutions

---

### 1. Sorted Section Headers:

```swift
enum MovieType {
	case action, animation, drama
}

class MovieTableViewController: UITableViewController {
	var movieData: [Movie]!
	let cellIdentifier: String = "MovieTableViewCell"
	let cellIdentifierRightAligned: String = "MovieRightAlignedTableViewCell"

	let reelGoodGreen: UIColor = UIColor(red: 109.0/255.0, green: 199.0/255.0, blue: 39.0/255.0, alpha: 1.0)
	let reelGoodGray: UIColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0)

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

		if let navigationController: UINavigationController = self.navigationController {
			navigationController.navigationBar.tintColor = UIColor.white
			navigationController.navigationBar.barTintColor = reelGoodGreen
			navigationController.navigationBar.titleTextAttributes = [
				NSForegroundColorAttributeName : UIColor.white
			]
		}
	}


	// MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return self.filterMovies(for: .action).count
		}
		else if section == 1 {
			return self.filterMovies(for: .animation).count
		}
		else {
			return self.filterMovies(for: .drama).count
		}
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let identifier = indexPath.row % 2 == 0 ? cellIdentifier : cellIdentifierRightAligned
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

		var cellMovie: Movie!
		if indexPath.section == 0 {
			let actionMovies = self.filterMovies(for: .action)
			cellMovie = actionMovies[indexPath.row]
		}
		else if indexPath.section == 1 {
			let animatedMovies = self.filterMovies(for: .animation)
			cellMovie = animatedMovies[indexPath.row]
		}
		else {
			let dramaticMovies = self.filterMovies(for: .drama)
			cellMovie = dramaticMovies[indexPath.row]
		}

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

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 {
			return "Action"
		}
		else if section == 1 {
			return "Animation"
		}
		else {
			return "Drama"
		}
	}

	func filterMovies(for type: MovieType) -> [Movie] {
		var returnMovies: [Movie] = []

		switch type {
		case .action: returnMovies = movieData.filter{ $0.genre == "action" }
		case .animation: returnMovies = movieData.filter{ $0.genre == "animation" }
		case .drama: returnMovies = movieData.filter{ $0.genre == "drama" }
		}

		return returnMovies
	}
}

```