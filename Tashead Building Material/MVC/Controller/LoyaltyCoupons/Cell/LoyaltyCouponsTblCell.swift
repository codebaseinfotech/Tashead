//
//  LoyaltyCouponsTblCell.swift
//  Tashead Building Material
//
//  Created by iMac on 04/08/25.
//

import UIKit

class LoyaltyCouponsTblCell: UITableViewCell {

    @IBOutlet weak var imgCoupons: UIImageView!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var lblKD: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
