//
//  DeathTableViewCell.swift
//  Death Notes
//
//  Created by stephane martins on 5/28/18.
//  Copyright © 2018 stephane martins. All rights reserved.
//

import UIKit

class DeathTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var deathLabel: UILabel!
    
    var death : (String, String)?{
        didSet
        {
            if let d = death
            {
                nameLabel?.text = d.0
                deathLabel?.text = d.1
            }
        }
    }
    
    
}
