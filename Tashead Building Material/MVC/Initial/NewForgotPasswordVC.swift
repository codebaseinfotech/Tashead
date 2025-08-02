//
//  NewForgotPasswordVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 02/05/24.
//

import UIKit

class NewForgotPasswordVC: UIViewController {

    @IBOutlet weak var viewTop: UIView!
    
    var strPhone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        viewTop.clipsToBounds = true
        viewTop.layer.cornerRadius = 15
        viewTop.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedLogin(_ sender: Any) {
    }
    @IBAction func clickedForgotPass(_ sender: Any) {
    }
    
    @IBAction func clickedHide(_ sender: Any) {
        self.dismiss(animated: false)
    }
    

}
