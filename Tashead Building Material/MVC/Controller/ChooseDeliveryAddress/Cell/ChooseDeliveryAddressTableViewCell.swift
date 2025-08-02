//
//  ChooseDeliveryAddressTableViewCell.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 25/07/25.
//

import UIKit

class ChooseDeliveryAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var imgSelect: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
