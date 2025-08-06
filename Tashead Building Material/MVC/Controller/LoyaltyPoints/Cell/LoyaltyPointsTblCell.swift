//
//  LoyaltyPointsTblCell.swift
//  Tashead Building Material
//
//  Created by iMac on 01/08/25.
//

import UIKit

class LoyaltyPointsTblCell: UITableViewCell {

    @IBOutlet weak var topViewOrderConstant: NSLayoutConstraint!
    
    @IBOutlet weak var heightViewOrderConstant: NSLayoutConstraint!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
