//
//  AboutVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 05/06/23.
//

import UIKit
import LGSideMenuController

class AboutVC: UIViewController {
    
    @IBOutlet weak var imgCart: UIImageView!
    
    @IBOutlet weak var viewCountItem: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtView: UITextView!
    
    var strTitle = ""
    
    var isOpenSide = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callAboutAPI()
        
        lblTitle.text = strTitle.localizeString(string: Language.shared.currentAppLang)
                
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Language.shared.isArabic {
            imgBack.image = UIImage(named: "Back_Ar")
        }
        else
        {
            imgBack.image = UIImage(named: "Back")
        }
        
        if let isUserLogin = appDelegate?.getIsUserLogin()
                {
                    if isUserLogin == true
                    {
                         imgCart.isHidden = true

                    }
                    else
                    {
                         imgCart.isHidden = true
                    }
                }
                else
                {
                     imgCart.isHidden = true
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
        if isOpenSide == true {
            appDelegate?.setUpHome()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    @IBAction func clickedCart(_ sender: Any) {
        
        if let isUserLogin = appDelegate?.getIsUserLogin()
        {
            if isUserLogin == true
            {
                if appDelegate?.delivery_slot_allowed == 1 {
                    let vc = SelectDeliveryTimeVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let mainS = UIStoryboard(name: "Home", bundle: nil)
                    let vc = mainS.instantiateViewController(withIdentifier: "MyCartVC") as! MyCartVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
//            else
//            {
//                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc: LoginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                vc.isFromHome = true
//                self.navigationController?.pushViewController(vc, animated: false)
//            }
        }
//        else
//        {
//            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc: LoginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//            vc.isFromHome = true
//            self.navigationController?.pushViewController(vc, animated: false)
//        }
    }
    
    func htmlToString(html: String) -> String? {
        // Convert HTML string to NSData
        guard let data = html.data(using: .utf8) else { return nil }
        
        // Use NSAttributedString to parse HTML
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        // Create attributed string with the HTML data
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        
        // Return the plain string
        return attributedString.string
    }
    
    func callAboutAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["":""]
        
        var url_ = ""
        
        if strTitle == "ABOUT US".localizeString(string: Language.shared.currentAppLang)
        {
            url_ = ABOUT_US
        }
        else
        {
            url_ = TERMS_AND_CONDITIONS
        }
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(url_, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                APIClient.sharedInstance.hideIndicator()
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        let dicResult = response?.value(forKey: "result") as? NSDictionary
                        
                        let description = dicResult?.value(forKey: "description") as? String

                        self.txtView.text = self.htmlToString(html: description ?? "")
                        
                    }
                    else
                    {
                        self.setUpMakeToast(msg: message ?? "")
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
