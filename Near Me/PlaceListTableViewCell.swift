//
//  PlaceListTableViewCell.swift
//  Near Me
//
//  Created by Raj Shah on 21/08/17.


import UIKit

class PlaceListTableViewCell: UITableViewCell {

   
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeAddressLabel: UILabel!
    @IBOutlet weak var placeCallButton: UIButton!
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
