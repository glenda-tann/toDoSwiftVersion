//
//  toDoTableViewCell.swift
//  toDo Swift Version
//
//  Created by Zoe Tse on 13/7/19.
//  Copyright © 2019 Zoe Tse. All rights reserved.
//

import UIKit

class toDoTableViewCell: UITableViewCell {
 
    @IBOutlet weak var toDoImage: UIImageView!
    @IBOutlet weak var toDoItem: UILabel!
    @IBOutlet weak var toDoDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
