//
//  ResetPasswordVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 03/05/24.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var lblCartCount: UILabel!
    
    @IBOutlet weak var viewCountItem: UIView!
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
        
        lblTChangePass.text = "Reset Password".localizeString(string: Language.shared.currentAppLang)
        
        txtNewPass.placeholder = "New Password".localizeString(string: Language.shared.currentAppLang)
        txtCPass.placeholder = "Confirm Password".localizeString(string: Language.shared.currentAppLang)
        
        btnTChangePass.setTitle("Submit".localizeString(string: Language.shared.currentAppLang), for: .normal)

        callGetCartAPI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblCartCount.text = appDelegate?.strTotalCount
        
//        if appDelegate?.strTotalCount == "0"
//        {
//            self.viewCountItem.isHidden = true
//        }
//        else
//        {
//            self.viewCountItem.isHidden = false
//        }
    }
    
    @IBAction func clickedMenu(_ sender: Any) {
    }
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickedCart(_ sender: Any) {
    }
    
    @IBAction func clickedSubmit(_ sender: Any) {
        if txtNewPass.text == ""
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
        
        let param = ["password":self.txtNewPass.text ?? "","password_confirmation":self.txtCPass.text ?? ""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(RESET_PASSWORD, parameters: param) { response, error, statusCode in
            
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
                        
                        appDelegate?.setUpHome()
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
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    func callGetCartAPI()
    {
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(GET_MY_CART_BY_USER, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                var arrCart: [TBCartListCartItem] = [TBCartListCartItem]()
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        if let dicResult = response?.value(forKey: "result") as? NSDictionary
                        {
                            if let arrCartItems = dicResult.value(forKey: "cart_items") as? NSArray
                            {
                                for obj in arrCartItems
                                {
                                    let dicData = TBCartListCartItem(fromDictionary: obj as! NSDictionary)
                                    arrCart.append(dicData)
                                }
                            }
                        }
                        
                        appDelegate?.strTotalCount = "\(arrCart.count)"
                        
                        if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCountItem.isHidden = true
                        }
                        else
                        {
                            self.viewCountItem.isHidden = false
                        }
                        
                        self.lblCartCount.text = "\(arrCart.count)"
                    }
                    else
                    {
                        appDelegate?.strTotalCount = "0"
                        self.lblCartCount.text = "0"
                        
                        if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCountItem.isHidden = true
                        }
                        else
                        {
                            self.viewCountItem.isHidden = false
                        }
                        
                        APIClient.sharedInstance.hideIndicator()
                    }
                    
                }
                else
                {
                    if appDelegate?.strTotalCount == "0"
                    {
                        self.viewCountItem.isHidden = true
                    }
                    else
                    {
                        self.viewCountItem.isHidden = false
                    }
                    
                    self.lblCartCount.text = "0"
                    APIClient.sharedInstance.hideIndicator()
                }
            }
            else
            {
                self.lblCartCount.text = "0"
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
}
