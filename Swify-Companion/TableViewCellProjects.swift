//
//  TableViewCellProjects.swift
//  Swify-Companion
//
//  Created by Julien MORI on 10/27/17.
//  Copyright © 2017 Julien MORI. All rights reserved.
//

import UIKit

class TableViewCellProjects: UITableViewCell {

    @IBOutlet weak var nameProject: UILabel!
    @IBOutlet weak var levelProject: UILabel!

    var project:NSDictionary? {
        didSet {
            if let p = project {
                if let link = p["final_mark"] as? Int {
                    let title = p["project"] as! NSDictionary
                    print(title["name"]!)
                    nameProject.text = title["name"]! as? String
                    levelProject.text = String(p["final_mark"]! as! Int)
                } else {}
            }
        }
    }
}
