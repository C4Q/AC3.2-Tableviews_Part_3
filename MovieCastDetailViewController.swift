//
//  MovieCastDetailViewController.swift
//  Tableviews_Part_3
//
//  Created by Sabrina Ip on 9/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MovieCastDetailViewController: UIViewController {

    @IBOutlet weak var actorNamesLabel: UILabel!
    
    internal var selectedMovie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews(for: self.selectedMovie)
    }
    

    internal func updateViews(for movie: Movie) {
        var actorsString = ""
        for actor in movie.cast {
            actorsString.append("-" + actor.firstName + " " + actor.lastName + "\n")
        }
        self.actorNamesLabel.text = actorsString
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
