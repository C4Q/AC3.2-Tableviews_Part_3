//
//  Alt2TableViewCell.swift
//  Tableviews_Part_3
//
//  Created by Louis Tur on 7/27/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class Alt2TableViewCell: UITableViewCell {

	@IBOutlet weak var movieTitleLabel: UILabel!
	@IBOutlet weak var movieSummaryLabel: UILabel!
	@IBOutlet weak var moviePosterImageView: UIImageView!
	@IBOutlet weak var movieCastLabel: UILabel!
	@IBOutlet weak var containerView: UIView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
