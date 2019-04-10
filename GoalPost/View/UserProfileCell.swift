//
//  UserProfileCell.swift
//  GoalPost
//
//  Created by Kien on 3/15/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class UserProfileCell: UITableViewCell {

    @IBOutlet var imageName: UIImageView!
    
    @IBOutlet var goalLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
