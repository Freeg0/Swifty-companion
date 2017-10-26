//
//  TableViewCellSkills.swift
//  Swify-Companion
//
//  Created by Julien MORI on 10/26/17.
//  Copyright © 2017 Julien MORI. All rights reserved.
//

import UIKit

class TableViewCellSkills: UITableViewCell {
    
    @IBOutlet weak var nameSkills: UILabel!
    @IBOutlet weak var lvlSkills: UILabel!

    var skill:NSDictionary? {
        didSet {
            if let s = skill {
                nameSkills.text = s["name"]! as! String
                lvlSkills.text = String(describing: s["level"]! as! NSNumber)
            }
        }
    }
}
