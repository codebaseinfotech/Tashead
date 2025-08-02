//
//  ForgotPasswordVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 01/06/23.
//

import UIKit
import LGSideMenuController
class ForgotPasswordVC: UIViewController {
   
    @IBOutlet weak var viewCountItem: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var lblCartCount: UILabel!
    
    // Outlet title
    
    @IBOutlet weak var lblTFForgot: UILabel!
    @IBOutlet weak var lblTSForgotPa: UILabel!
    @IBOutlet weak var btnTSend: UIButton!
    
    var strPhone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtMobileNo.text = strPhone

        lblTFForgot.text = "Forgot Password".localizeString(string: Language.shared.currentAppLang)
        lblTSForgotPa.text = "Forgot Password".localizeString(string: Language.shared.currentAppLang)
        
        btnTSend.setTitle("Send".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
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
        }
        else
        {
            imgBack.image = UIImage(named: "Back")
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
    
    @IBAction func clickedSend(_ sender: Any) {
        
        if isValidMobileNumber()
        {
            callForgotPassword()
        }
 
    }
    
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
    
    @IBAction func clickedCart(_ sender: Any) {
    }
    
    // MARK: - calling API
    
    func callForgotPassword()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["mobile_number":self.txtMobileNo.text ?? "","type":"forgot","country_code":"965"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderPost(SEND_OTP, parameters: param) { response, error, statusCode in
            
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
//                        let otp = response?.value(forKey: "otp") as? String
//                        
//                        let window = UIApplication.shared.windows
//                        window.last?.makeToast("\(otp ?? "")",position: .center)
                        
                        let mainS = UIStoryboard(name: "Main", bundle: nil)
                        let vc = mainS.instantiateViewController(withIdentifier: "OTPVerifyVC") as! OTPVerifyVC
                        vc.strMobileNo = self.txtMobileNo.text ?? ""
                        vc.isFromForgot = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else
                    {
                        let mainS =  UIStoryboard(name: "Home", bundle: nil)
                        let vc = mainS.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
                        vc.modalPresentationStyle = .overFullScreen
                        vc.isAreYou = true
                        vc.strTitle = message ?? ""
                        self.present(vc, animated: false)
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
  

}
