//
//  LocationListCell.swift
//  LocationLists
//
//  Created by Michael Pujol on 9/18/17.
//  Copyright © 2017 Michael Pujol. All rights reserved.
//

import UIKit

class LocationListCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var listLabel: UILabel!
    @IBOutlet var statusLevel: UILabel!
    @IBOutlet var listProgressView: UIProgressView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
