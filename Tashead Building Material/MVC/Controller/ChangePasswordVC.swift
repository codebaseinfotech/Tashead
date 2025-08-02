//
//  ChangePasswordVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 20/12/23.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var lblCartCount: UILabel!
    
    @IBOutlet weak var viewCountItem: UIView!
    @IBOutlet weak var txtOldPass: UITextField!
    @IBOutlet weak var txtNewPass: UITextField!
    @IBOutlet weak var txtCPass: UITextField!
    
    @IBOutlet weak var lblTChangePass: UILabel!
    @IBOutlet weak var btnTChangePass: UIButton!
    
    @IBOutlet weak var imgBack: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Language.shared.isArabic {
            imgBack.image = UIImage(named: "Back_Ar")
        }
        else
        {
            imgBack.image = UIImage(named: "Back")
        }
        
        lblTChangePass.text = "Change Password".localizeString(string: Language.shared.currentAppLang)
        
        txtNewPass.placeholder = "New Password".localizeString(string: Language.shared.currentAppLang)
        txtOldPass.placeholder = "Old Password".localizeString(string: Language.shared.currentAppLang)
        txtCPass.placeholder = "Confirm Password".localizeString(string: Language.shared.currentAppLang)
        
        btnTChangePass.setTitle("Submit".localizeString(string: Language.shared.currentAppLang), for: .normal)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblCartCount.text = appDelegate?.strTotalCount
        
        if appDelegate?.strTotalCount == "0"
        {
            self.viewCountItem.isHidden = true
        }
        else
        {
            self.viewCountItem.isHidden = true
        }
    }
    
    @IBAction func clickedMenu(_ sender: Any) {
    }
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickedCart(_ sender: Any) {
    }
    
    @IBAction func clickedSubmit(_ sender: Any) {
        if txtOldPass.text == ""
        {
            self.setUpMakeToast(msg: "Enter old passwrod".localizeString(string: Language.shared.currentAppLang))
        }
        else if txtNewPass.text == ""
        {
            self.setUpMakeToast(msg: "Enter new password".localizeString(string: Language.shared.currentAppLang))
        }
        else if txtCPass.text == ""
        {
            self.setUpMakeToast(msg: "Enter cnofirm password".localizeString(string: Language.shared.currentAppLang))
        }
        else if txtNewPass.text != txtCPass.text
        {
            self.setUpMakeToast(msg: "Password Does Not Match".localizeString(string: Language.shared.currentAppLang))
        }
        else
        {
            callChangeAPI()
        }
    }
    
    // MARK: - calling API
    
    func callChangeAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["email":appDelegate?.dicCurrentLoginUser.email ?? "","old_password":self.txtOldPass.text ?? "","new_password": self.txtNewPass.text ?? "","confirm_password":self.txtCPass.text ?? ""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(CHANGE_PASSWORD, parameters: param) { response, error, statusCode in
            
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
                        self.setUpMakeToast(msg: message ?? "")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.clickedBack(self)
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
                    
                    if message?.contains("Unauthenticated.") == true
                    {
                        appDelegate?.strTotalCount = "0"
                        
                        appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
                        appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
                        
                        appDelegate?.saveIsUserLogin(dic: false)
                    }
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
}
