//
//  InboxTableViewCell.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 09/07/25.
//

import UIKit

class InboxTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescrption: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
