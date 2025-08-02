//
//  PopUpVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 05/06/23.
//

import UIKit

class PopUpVC: UIViewController {

    @IBOutlet weak var lblTitlr: UILabel!
    
    @IBOutlet weak var viewMainMissing: UIView!
    @IBOutlet weak var viewMainAreYou: UIView!
    @IBOutlet weak var viewAlertM: UIView!
    @IBOutlet weak var viewAlertA: UIView!
    @IBOutlet weak var viewDeleteCArt: UIView!
    
    @IBOutlet weak var lblTAlertC: UILabel!
    @IBOutlet weak var lblAreYouCart: UILabel!
    @IBOutlet weak var lblTALogout: UILabel!
    @IBOutlet weak var lblTMiss: UILabel!
    @IBOutlet weak var lblTMissing: UILabel!
    
    @IBOutlet weak var btnTYesCart: UIButton!
    @IBOutlet weak var btnTNoCart: UIButton!
    
    @IBOutlet weak var btnYesL: UIButton!
    @IBOutlet weak var btnTNoL: UIButton!
    @IBOutlet weak var btnTOK: UIButton!
    
    var isAreYou = false
    var isLogout = false
    var isDeleteAccount = false

    var isRemoveCart = false
    
    var cartDeleteDelegate: CartDeleteDelegate?
    
    var strTitle = ""
    var strMsg = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTAlertC.text = "Alert".localizeString(string: Language.shared.currentAppLang)
        lblAreYouCart.text = "Are you sure you want to remove this item from your cart?".localizeString(string: Language.shared.currentAppLang)
        lblTALogout.text = "Alert".localizeString(string: Language.shared.currentAppLang)
        lblTMiss.text = "Alert".localizeString(string: Language.shared.currentAppLang)
        lblTMissing.text = "Missing items".localizeString(string: Language.shared.currentAppLang)
        
        btnTYesCart.setTitle("YES".localizeString(string: Language.shared.currentAppLang), for: .normal)
        btnTNoCart.setTitle("NO".localizeString(string: Language.shared.currentAppLang), for: .normal)
        btnTNoL.setTitle("NO".localizeString(string: Language.shared.currentAppLang), for: .normal)
        btnYesL.setTitle("YES".localizeString(string: Language.shared.currentAppLang), for: .normal)
        btnTOK.setTitle("OK".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        if isLogout == true
        {
            lblTitlr.text = "Would you like to Logout?".localizeString(string: Language.shared.currentAppLang)
            
            viewMainAreYou.isHidden = false
            viewDeleteCArt.isHidden = true
            viewMainMissing.isHidden = true
        }
        else if isDeleteAccount == true
        {
            lblTitlr.text = "Would you like to delete account?".localizeString(string: Language.shared.currentAppLang)
            
            viewMainAreYou.isHidden = false
            viewDeleteCArt.isHidden = true
            viewMainMissing.isHidden = true
        }
        else if strTitle == "Payment link sent successfully."
        {
            lblTMissing.text = strTitle.localizeString(string: Language.shared.currentAppLang)
            
            viewMainAreYou.isHidden = true
            viewDeleteCArt.isHidden = true
            viewMainMissing.isHidden = false
        }
        else if strTitle == "Minimum order"
        {
            lblTMissing.text = strMsg
            
            viewMainAreYou.isHidden = true
            viewDeleteCArt.isHidden = true
            viewMainMissing.isHidden = false
        }
        else if isRemoveCart == true
        {
            viewMainAreYou.isHidden = true
            viewDeleteCArt.isHidden = false
            viewMainMissing.isHidden = true
        }
        else if isAreYou == true
        {
            lblTMissing.text = strTitle
            
            viewMainAreYou.isHidden = true
            viewDeleteCArt.isHidden = true
            viewMainMissing.isHidden = false
        }
        else {
            lblTMissing.text = strTitle.localizeString(string: Language.shared.currentAppLang)
            
            viewMainAreYou.isHidden = true
            viewDeleteCArt.isHidden = true
            viewMainMissing.isHidden = false
        }
        
        lblTMissing.textAlignment = .center
        
        viewAlertM.clipsToBounds = true
        viewAlertM.layer.cornerRadius = 15
        viewAlertM.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
     
        viewAlertA.clipsToBounds = true
        viewAlertA.layer.cornerRadius = 15
        viewAlertA.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        
        viewDeleteCArt.clipsToBounds = true
        viewDeleteCArt.layer.cornerRadius = 15
        viewDeleteCArt.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedOk(_ sender: Any) {
        if strTitle == "Payment link sent successfully." || strTitle == "Minimum order" || isAreYou == true {
            self.dismiss(animated: false)
        } else {
            appDelegate?.setUpHome()
        }
    }
    
    @IBAction func clickedYes(_ sender: Any) {
        
        appDelegate?.strTotalCount = "0"
        
        if isLogout == true
        {
            appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
            appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
            appDelegate?.saveCmsAdverd(dic: TBCmsAdverdResult())
            appDelegate?.saveIsGuestLogin(dic: false)
            
            UserDefaults.standard.set("", forKey: "token")
             UserDefaults.standard.synchronize()
            
            appDelegate?.saveIsUserLogin(dic: false)
            
            appDelegate?.setUpHome()
        }
        if isDeleteAccount == true
        {
            appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
            appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
            appDelegate?.saveCmsAdverd(dic: TBCmsAdverdResult())
            appDelegate?.saveIsGuestLogin(dic: false)
            
            UserDefaults.standard.set("", forKey: "token")
             UserDefaults.standard.synchronize()
            
            appDelegate?.saveIsUserLogin(dic: false)
            
            appDelegate?.setUpHome()
        }
        
        
     }
    
    @IBAction func clickedNo(_ sender: Any) {
 
        self.dismiss(animated: false)
    }
    
    @IBAction func clickedDeleteCartYEs(_ sender: Any) {
        cartDeleteDelegate?.onCartDeleteReady(isDelete: true)
        self.dismiss(animated: false)
    }
    
}
