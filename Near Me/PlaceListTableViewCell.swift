//
//  PlaceListTableViewCell.swift
//  Near Me
//
//  Created by Anshul Shah on 21/07/17.
//  Copyright © 2017 Anshul Shah. All rights reserved.
//

import UIKit

class PlaceListTableViewCell: UITableViewCell {

   
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeAddressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


class PlaceListCellView : UIView{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 05
    }
}
