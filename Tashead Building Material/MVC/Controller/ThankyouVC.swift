//
//  ThankyouVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 06/05/24.
//

import UIKit

class ThankyouVC: UIViewController {

    @IBOutlet weak var lblThankyou: UILabel!
    @IBOutlet weak var lblDes: UILabel!

    @IBOutlet weak var btnContinue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblThankyou.text = "Thank you for ordering!".localizeString(string: Language.shared.currentAppLang)
        lblDes.text = "Order Placed Successfully!".localizeString(string: Language.shared.currentAppLang)
        
        btnContinue.setTitle("Continue Shopping".localizeString(string: Language.shared.currentAppLang), for: .normal)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedSubmit(_ sender: Any) {
        
        if appDelegate?.getIsGuestLogin() == true
        {
            appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
            appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
            
            appDelegate?.saveIsGuestLogin(dic: false)
            
            UserDefaults.standard.set("", forKey: "token")
             UserDefaults.standard.synchronize()
            
            appDelegate?.saveIsUserLogin(dic: false)
            
            appDelegate?.setUpHome()            
        }
        else
        {
            appDelegate?.setUpHome()
        }
        
        
    }
    

}
