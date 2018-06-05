//
//  PlacesTableViewCell.swift
//  MapTime
//
//  Created by stephane martins on 6/4/18.
//  Copyright © 2018 stephane martins. All rights reserved.
//

import Foundation
import UIKit

class PlacesTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var placesCellLabel: UILabel!
    
    var placeCell : (String, String, Double, Double)? {
        didSet
        {
            if let d = placeCell
            {
                placesCellLabel?.text = d.0
            }
        }
        
    }
}
