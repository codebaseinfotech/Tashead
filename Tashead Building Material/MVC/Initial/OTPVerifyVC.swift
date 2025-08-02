//
//  OTPVerifyVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 01/06/23.
//

import UIKit
import LGSideMenuController

class OTPVerifyVC: UIViewController {

    @IBOutlet weak var viewCountItem: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var txtOTP: UITextField!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var lblCartCount: UILabel!
    
    // Outlet Title
    @IBOutlet weak var lblTRegister: UILabel!
    @IBOutlet weak var lblTSRegister: UILabel!
    
    @IBOutlet weak var btnTnext: UIButton!
    
    @IBOutlet weak var horizontalTime: NSLayoutConstraint!
    
    var isGuestLogin = false
    var isFromForgot = false
    
    var myTimer: Timer?
    
    var counter = 59
    
    var strMobileNo = ""
    
    var isFromHome = false
    var selectViewContrller = UIViewController()
    
    var isSocialLogin = false
    
    var socialId = ""
    var socialDevice = ""

    var strName = ""
    var strEmail = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isFromForgot == false
        {
            lblTRegister.text = "REGISTRATION".localizeString(string: Language.shared.currentAppLang)
            lblTSRegister.text = "REGISTRATION".localizeString(string: Language.shared.currentAppLang)
        }
        else
        {
            lblTRegister.text = "Forgot Password".localizeString(string: Language.shared.currentAppLang)
            lblTSRegister.text = "Forgot Password".localizeString(string: Language.shared.currentAppLang)
        }

        txtOTP.placeholder = "OTP".localizeString(string: Language.shared.currentAppLang)
        
        btnTnext.setTitle("Next".localizeString(string: Language.shared.currentAppLang), for: .normal)
        btnResend.setTitle("Resend".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        self.lblTimer.text = "00:\(counter)"
        
        self.counter = 59
        startTimer()
        
        self.btnResend.isUserInteractionEnabled = false
        self.btnResend.alpha = 0.5

        
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
        
        self.txtOTP.text = ""
        
        self.lblTimer.text = "00:\(counter)"
        
        myTimer = Timer()
        
        myTimer?.invalidate()
        
        self.counter = 59
        startTimer()
                
        self.btnResend.isUserInteractionEnabled = false
        self.btnResend.alpha = 0.5
        
        if Language.shared.isArabic {
            imgBack.image = UIImage(named: "Back_Ar")
            
            txtOTP.textAlignment = .right
            horizontalTime.constant = 40
        }
        else
        {
            imgBack.image = UIImage(named: "Back")
            
            txtOTP.textAlignment = .left
            horizontalTime.constant = -40
        }
        
    }
    
    func startTimer() {
        
        self.lblTimer.text = "00:\(counter)"
        
        myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        
        counter = 59
        
        self.btnResend.isUserInteractionEnabled = true
        self.btnResend.alpha = 1

        
        myTimer?.invalidate()
    }
    
    @objc func timerFired() {
        
        if counter != 1 {
            // print("\(counter) seconds to the end of the world")
            counter -= 1
            
            self.lblTimer.text = "00:\(counter)"
        }
        else
        {
            stopTimer()
        }
        
        // Code to execute when the timer fires
    }
    
    @IBAction func clickedBAck(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickedResend(_ sender: Any) {
        callMobileRegisterAPI()
    }
    @IBAction func clickedNext(_ sender: Any) {
        if isValidMobileNumber()
        {
            callMobileVerifyAPI()
        }
    }
    @IBAction func clickedCart(_ sender: Any) {
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
    
    // MARK: - calling API
    
    func callMobileVerifyAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        var type = ""
        
        if self.isFromForgot == true
        {
            type = "forgot"
        }
        else
        {
            type = "register"
        }
        
        var param = ["":""]
        
        print(param)
        
        var url_ = ""
        
        if isGuestLogin == true
        {
            url_ = GUEST_VERIFY_OTP
            param = ["country_code":"965","mobile_number":self.strMobileNo,"otp":self.txtOTP.text ?? ""]
        }
        else
        {
            url_ = VERIFY_OTP
            param =  ["country_code":"965","mobile_number":self.strMobileNo,"otp":self.txtOTP.text ?? "","type":type]
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
                
                if statusCode == 200
                {
                    if status == 1
                    {
                      //  self.setUpMakeToast(msg: message ?? "")
                        
                        if self.isFromForgot == true
                        {
                            if let result = response?.value(forKey: "data") as? NSDictionary
                            {
                                let dicData = TBLoginUserResult(fromDictionary: result)
                                
                                appDelegate?.saveCuurentUserData(dic: dicData)
                                appDelegate?.dicCurrentLoginUser = dicData
                                
                                UserDefaults.standard.set(dicData.token ?? "", forKey: "token")
                                 UserDefaults.standard.synchronize()
                                
                                appDelegate?.saveIsUserLogin(dic: true)
                                
                                let mainS = UIStoryboard(name: "Main", bundle: nil)
                                let vc = mainS.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                           
                        }
                        else
                        {
                            
                            if let result = response?.value(forKey: "user") as? NSDictionary
                            {
                                let dicData = TBLoginUserResult(fromDictionary: result)
                                
                                appDelegate?.saveCuurentUserData(dic: dicData)
                                appDelegate?.dicCurrentLoginUser = dicData
                                appDelegate?.saveIsUserLogin(dic: true)
                                appDelegate?.saveIsGuestLogin(dic: true)
                                
                                UserDefaults.standard.set(dicData.token ?? "", forKey: "token")
                                UserDefaults.standard.synchronize()
                                
                                 appDelegate?.setUpHome()
                            }
                            else
                            {
                                let mainS = UIStoryboard(name: "Main", bundle: nil)
                                let vc = mainS.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
                                vc.isSocialLogin = self.isSocialLogin
                                vc.socialId = self.socialId
                                vc.socialDevice = self.socialDevice
                                vc.strName = self.strName
                                vc.strEmail = self.strEmail
                                vc.strMobileNo = self.strMobileNo
                                vc.isFromHome = self.isFromHome
                                vc.selectViewContrller = self.selectViewContrller
                                vc.isGuestLogin = self.isGuestLogin
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                            
                            
                        }
 
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                        
                        self.setUpMakeToast(msg: message ?? "")
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
    
    func callMobileRegisterAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        var type = ""
        
        if self.isFromForgot == true
        {
            type = "forgot"
        }
        else
        {
            type = "register"
        }
        
        var param = ["":""]
        var url_ = ""
        
        if isGuestLogin == true
        {
            url_ = GUEST_SEND_OTP
            param = ["country_code":"965","mobile_number":self.strMobileNo,"device_type":"1"]
        }
        else
        {
            url_ = SEND_OTP
            param = ["country_code":"965","mobile_number":self.strMobileNo,"type":"register"]
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
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        let otp = response?.value(forKey: "otp") as? Int
                        
                        self.setUpMakeToast(msg: "\(otp ?? 0)")
                        
                        self.counter = 59
                        self.startTimer()
                        
                        
                        self.btnResend.isUserInteractionEnabled = false
                        self.btnResend.alpha = 0.5

                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                        
                        self.setUpMakeToast(msg: message ?? "")
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
        if txtOTP.text == ""
        {
            self.setUpMakeToast(msg: "Please enter otp".localizeString(string: Language.shared.currentAppLang))
            return false
        }
        return true
    }
    
}
