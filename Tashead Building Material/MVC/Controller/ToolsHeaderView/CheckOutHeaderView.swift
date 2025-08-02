//
//  CheckOutHeaderView.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 08/08/24.
//

import UIKit

class CheckOutHeaderView: UIView {

    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var OrderTopCont: NSLayoutConstraint! //20
    
    @IBOutlet weak var OrdeBottomCont: NSLayoutConstraint!//15
    
    @IBOutlet weak var lblOrder: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }

}
