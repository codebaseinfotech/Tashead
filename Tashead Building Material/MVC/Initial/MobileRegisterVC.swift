//
//  MobileRegisterVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 01/06/23.
//

import UIKit
import LGSideMenuController

class MobileRegisterVC: UIViewController {
    
    
    @IBOutlet weak var PopupMain: UIView!
    
    
    @IBOutlet weak var viewCountItem: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var lblCartCount: UILabel!
    
    // Outlet Title
    @IBOutlet weak var lblTRegister: UILabel!
    @IBOutlet weak var lblTSRegister: UILabel!
    @IBOutlet weak var btnTNext: UIButton!
    
    
    
    var isFromHome = false
    var selectViewContrller = UIViewController()
    
    var isGuestLogin = false
    
    var isSocialLogin = false
    
    var socialId = ""
    var socialDevice = ""
    
    var strName = ""
    var strEmail = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTRegister.text = "REGISTRATION".localizeString(string: Language.shared.currentAppLang)
        lblTSRegister.text = "REGISTRATION".localizeString(string: Language.shared.currentAppLang)

        txtMobileNo.placeholder = "Mobile Number".localizeString(string: Language.shared.currentAppLang)

        btnTNext.setTitle("Next".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.lblCartCount.text = appDelegate?.strTotalCount
        
//        if appDelegate?.strTotalCount == "0"
//        {
//            self.viewCountItem.isHidden = true
//        }
//        else
//        {
//            self.viewCountItem.isHidden = false
//        }
        
        if Language.shared.isArabic {
            imgBack.image = UIImage(named: "Back_Ar")
            
            txtMobileNo.textAlignment = .right
        }
        else
        {
            imgBack.image = UIImage(named: "Back")
          
            txtMobileNo.textAlignment = .left
            
        }
        
    }
    
    @IBAction func clickedMenu(_ sender: Any) {
        if Language.shared.isArabic {
            self.sideMenuController?.showRightView(animated: true, completion: nil)
        }
        else
        {
            self.sideMenuController?.showLeftView(animated: true, completion: nil)
        }
    }
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickedNext(_ sender: Any) {
        if isValidMobileNumber()
        {
            callMobileRegisterAPI()
        }
        
     
    }
    @IBAction func clickedCart(_ sender: Any) {
    }
    
    @IBAction func clickedRemovedBg(_ sender: Any) {
        self.PopupMain.isHidden = true
    }
    
    
    @IBAction func clickedLoginPopup(_ sender: Any) {
        self.PopupMain.isHidden = true
        
        appDelegate?.strPhone = self.txtMobileNo.text ?? ""
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedForgotPassPopup(_ sender: Any) {
        self.PopupMain.isHidden = true
        
        appDelegate?.strPhone = self.txtMobileNo.text ?? ""
        
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        vc.strPhone = self.txtMobileNo.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - calling API
    
    func callMobileRegisterAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        var param = ["":""]
        
        
        var url_ = ""
        
        if isGuestLogin == true
        {
            url_ = GUEST_SEND_OTP
            param = ["country_code":"965","mobile_number":self.txtMobileNo.text ?? "","device_type":"1"]
        }
        else
        {
            url_ = SEND_OTP
            param = ["country_code":"965","mobile_number":self.txtMobileNo.text ?? "","type":"register"]
        }
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderPost(url_, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                let user_exist = response?.value(forKey: "user_exist") as? Int

                
                if statusCode == 200
                {
                    if status == 1
                    {
//                        let otp = response?.value(forKey: "otp") as? String
// 
//                        let window = UIApplication.shared.windows
//                        window.last?.makeToast("\(otp ?? "")",position: .center)
                        
                        let mainS = UIStoryboard(name: "Main", bundle: nil)
                        let vc = mainS.instantiateViewController(withIdentifier: "OTPVerifyVC") as! OTPVerifyVC
                        vc.isSocialLogin = self.isSocialLogin
                        vc.socialId = self.socialId
                        vc.socialDevice = self.socialDevice
                        vc.strName = self.strName
                        vc.strEmail = self.strEmail
                        vc.strMobileNo = self.txtMobileNo.text ?? ""
                        vc.isFromHome = self.isFromHome
                        vc.isGuestLogin = self.isGuestLogin
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                        
                        if user_exist == 1
                        {
                            self.PopupMain.isHidden = false
                        }
                        else
                        {
                            self.setUpMakeToast(msg: message ?? "")
                        }
                    }
                }
                else
                {
                    APIClient.sharedInstance.hideIndicator()
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    // MARK: - validation
    
    func isValidMobileNumber() -> Bool
    {
        if txtMobileNo.text == ""
        {
            self.setUpMakeToast(msg: "Please enter mobile number".localizeString(string: Language.shared.currentAppLang))
            return false
        }
        else if (txtMobileNo.text?.count ?? 0) != 8
        {
            self.setUpMakeToast(msg: "Please enter valid mobile number".localizeString(string: Language.shared.currentAppLang))
            return false
        }
        return true
    }
    
}
