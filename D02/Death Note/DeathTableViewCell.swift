//
//  DeathTableViewCell.swift
//  Death Note
//
//  Created by Stephane MARTINS on 5/29/18.
//  Copyright © 2018 Stephane MARTINS. All rights reserved.
//

import UIKit

class DeathTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    
    var death : (String, String, String)?{
        didSet
        {
            if let d = death
            {
                nameLabel?.text = d.0
                deathLabel?.text = d.1
                dateLabel?.text = d.2
            }
        }

    }
}
