//
//  SideMenuVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 01/06/23.
//

import UIKit
import LGSideMenuController

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var viewLogout: UIView!
    @IBOutlet weak var lblLogout: UILabel!
    
    
    @IBOutlet weak var viewOrder_: UIView!
    @IBOutlet weak var viewFav_: UIView!
    @IBOutlet weak var viewAllHide: UIView!
    @IBOutlet weak var viewAccount_: UIView!
    @IBOutlet weak var viewAccountHiesgh_: NSLayoutConstraint! //50
    
    @IBOutlet weak var viewLineHide: UIView!
    
    @IBOutlet weak var lblTHome: UILabel!
    @IBOutlet weak var lblTAccount: UILabel!
    @IBOutlet weak var lblTOrder: UILabel!
    @IBOutlet weak var lblTWishList: UILabel!
    @IBOutlet weak var lblTAbout: UILabel!
    @IBOutlet weak var lblTContact: UILabel!
    @IBOutlet weak var lblTC: UILabel!
    @IBOutlet weak var blFeedback: UILabel!
    @IBOutlet weak var lblTell: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    
    
    @IBOutlet weak var lblLng: UILabel!
    
    @IBOutlet weak var lblTNotification: UILabel!
    
    @IBOutlet weak var viewComm: UIView!
    @IBOutlet weak var lblComition: UILabel!
    
    @IBOutlet weak var viewCredits: UIView!
    @IBOutlet weak var lblMyCredits: UILabel!
    @IBOutlet weak var viewMainInbox: UIView!
    @IBOutlet weak var lblInbox: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let isUserLogin = appDelegate?.getIsUserLogin()
        {
            if isUserLogin == true
            {
                self.callProfileDetailAPI()
 
            }
            else {
                viewComm.isHidden = true
                viewCredits.isHidden = true
            }
        }
        else
        {
            viewComm.isHidden = true
            viewCredits.isHidden = true
        }
        
        lblInbox.text = "MY INBOX".localizeString(string: Language.shared.currentAppLang)

        lblLogout.text = "LOGOUT".localizeString(string: Language.shared.currentAppLang)
        lblTHome.text = "HOME".localizeString(string: Language.shared.currentAppLang)
        lblComition.text = "MY COMMISSIONS".localizeString(string: Language.shared.currentAppLang)
        lblMyCredits.text = "MY CREDITS".localizeString(string: Language.shared.currentAppLang)
        lblTAccount.text = "MY ACCOUNT".localizeString(string: Language.shared.currentAppLang)
        lblTOrder.text = "MY ORDERS".localizeString(string: Language.shared.currentAppLang)
        lblTWishList.text = "MY FAVORITE".localizeString(string: Language.shared.currentAppLang)
        lblTAbout.text = "ABOUT US".localizeString(string: Language.shared.currentAppLang)
        lblTContact.text = "CONTACT US".localizeString(string: Language.shared.currentAppLang)
        lblTC.text = "TERMS & CONDITIONS".localizeString(string: Language.shared.currentAppLang)
        blFeedback.text = "FEEDBACK".localizeString(string: Language.shared.currentAppLang)
        lblTell.text = "TELL A FRIEND".localizeString(string: Language.shared.currentAppLang)
        lblLanguage.text = "LANGUAGE".localizeString(string: Language.shared.currentAppLang)
        lblTNotification.text = "NOTIFICATION".localizeString(string: Language.shared.currentAppLang)
        
        lblMyCredits.text = "MY CREDITS".localizeString(string: Language.shared.currentAppLang)
        
        if Language.shared.isArabic {
            lblTHome.textAlignment = .right
            lblTAccount.textAlignment = .right
            lblTOrder.textAlignment = .right
            lblTWishList.textAlignment = .right
            lblTAbout.textAlignment = .right
            lblTContact.textAlignment = .right
            lblTC.textAlignment = .right
            blFeedback.textAlignment = .right
            lblTell.textAlignment = .right
            lblLanguage.textAlignment = .right
            lblTNotification.textAlignment = .right
            lblLng.text = ""
            
        } else {
            lblTHome.textAlignment = .left
            lblTAccount.textAlignment = .left
            lblTOrder.textAlignment = .left
            lblTWishList.textAlignment = .left
            lblTAbout.textAlignment = .left
            lblTContact.textAlignment = .left
            lblTC.textAlignment = .left
            blFeedback.textAlignment = .left
            lblTell.textAlignment = .left
            lblLanguage.textAlignment = .left
            lblTNotification.textAlignment = .left
            
            lblLng.text = ""
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if appDelegate?.getIsGuestLogin() == true
        {
            viewOrder_.isHidden = true
            viewFav_.isHidden = true
            viewAllHide.isHidden = true
            
            viewAccount_.isHidden = true
            viewLineHide.isHidden = true
            viewComm.isHidden = true
            viewCredits.isHidden = true
            
            viewAccountHiesgh_.constant = 0
            viewLogout.isHidden = false
        }
        else {
            viewLogout.isHidden = true
        }
        
        if let isUserLogin = appDelegate?.getIsUserLogin()
        {
            if isUserLogin == true
            {
                callGetCartAPI()
            }
        }
        
    }
    
    @IBAction func clickedClose(_ sender: Any) {
 
        if Language.shared.isArabic {
            self.sideMenuController?.hideRightViewAnimated(sender: self)
        }
        else
        {
            self.sideMenuController?.hideLeftViewAnimated(sender: self)
        }
        
    }
    
    @IBAction func clickedLogout(_ sender: Any) {
        
        let mainS =  UIStoryboard(name: "Home", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
        vc.isLogout = true
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    
    
    // Action in SideMenu btn
    
    @IBAction func clickedMyAccount(_ sender: Any) {
        
        if appDelegate?.getIsGuestLogin() == false
        {
            
            if let isUserLogin = appDelegate?.getIsUserLogin()
            {
                if isUserLogin == true
                {
                    let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                    let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
                    let navigation = controller.rootViewController as! UINavigationController
                    let OrderHistoryVC = mainStoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                    navigation.viewControllers = [OrderHistoryVC]
                    if Language.shared.isArabic {
                        self.sideMenuController?.hideRightViewAnimated(sender: self)
                    }
                    else
                    {
                        self.sideMenuController?.hideLeftViewAnimated(sender: self)
                    }
                }
                else
                {
                    let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
                    let navigation = controller.rootViewController as! UINavigationController
                    let OrderHistoryVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    navigation.viewControllers = [OrderHistoryVC]
                    if Language.shared.isArabic {
                        self.sideMenuController?.hideRightViewAnimated(sender: self)
                    }
                    else
                    {
                        self.sideMenuController?.hideLeftViewAnimated(sender: self)
                    }
                }
            }
            else
            {
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
                let navigation = controller.rootViewController as! UINavigationController
                let OrderHistoryVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                navigation.viewControllers = [OrderHistoryVC]
                if Language.shared.isArabic {
                    self.sideMenuController?.hideRightViewAnimated(sender: self)
                }
                else
                {
                    self.sideMenuController?.hideLeftViewAnimated(sender: self)
                }
            }
            
        }
        
        
    }
    
    @IBAction func clickedMyOrder(_ sender: Any) {
        
        if appDelegate?.getIsGuestLogin() == false
        {
            if let isUserLogin = appDelegate?.getIsUserLogin()
            {
                if isUserLogin == true
                {
                    let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                    let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
                    let navigation = controller.rootViewController as! UINavigationController
                    let OrderHistoryVC = mainStoryboard.instantiateViewController(withIdentifier: "MyOrdersVC") as! MyOrdersVC
                    navigation.viewControllers = [OrderHistoryVC]
                    if Language.shared.isArabic {
                        self.sideMenuController?.hideRightViewAnimated(sender: self)
                    }
                    else
                    {
                        self.sideMenuController?.hideLeftViewAnimated(sender: self)
                    }
                }
                else
                {
                    let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
                    let navigation = controller.rootViewController as! UINavigationController
                    let OrderHistoryVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    navigation.viewControllers = [OrderHistoryVC]
                    if Language.shared.isArabic {
                        self.sideMenuController?.hideRightViewAnimated(sender: self)
                    }
                    else
                    {
                        self.sideMenuController?.hideLeftViewAnimated(sender: self)
                    }
                }
            }
            else
            {
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
                let navigation = controller.rootViewController as! UINavigationController
                let OrderHistoryVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                navigation.viewControllers = [OrderHistoryVC]
                if Language.shared.isArabic {
                    self.sideMenuController?.hideRightViewAnimated(sender: self)
                }
                else
                {
                    self.sideMenuController?.hideLeftViewAnimated(sender: self)
                }
            }
        }
        
    }
    @IBAction func clickedWishList(_ sender: Any) {
        
        if let isUserLogin = appDelegate?.getIsUserLogin()
        {
            if isUserLogin == true
            {
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
                let navigation = controller.rootViewController as! UINavigationController
                let OrderHistoryVC = mainStoryboard.instantiateViewController(withIdentifier: "WishListViewController") as! WishListViewController
                navigation.viewControllers = [OrderHistoryVC]
                if Language.shared.isArabic {
                    self.sideMenuController?.hideRightViewAnimated(sender: self)
                }
                else
                {
                    self.sideMenuController?.hideLeftViewAnimated(sender: self)
                }
            }
            else
            {
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
                let navigation = controller.rootViewController as! UINavigationController
                let OrderHistoryVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                navigation.viewControllers = [OrderHistoryVC]
                if Language.shared.isArabic {
                    self.sideMenuController?.hideRightViewAnimated(sender: self)
                }
                else
                {
                    self.sideMenuController?.hideLeftViewAnimated(sender: self)
                }
            }
        }
        else
        {
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
            let navigation = controller.rootViewController as! UINavigationController
            let OrderHistoryVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigation.viewControllers = [OrderHistoryVC]
            if Language.shared.isArabic {
                self.sideMenuController?.hideRightViewAnimated(sender: self)
            }
            else
            {
                self.sideMenuController?.hideLeftViewAnimated(sender: self)
            }
        }
    }
    
    @IBAction func clickedAboutUs(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
        let navigation = controller.rootViewController as! UINavigationController
        let AboutVC = mainStoryboard.instantiateViewController(withIdentifier: "AboutVC") as! AboutVC
        AboutVC.isOpenSide = true
        navigation.viewControllers = [AboutVC]
        AboutVC.strTitle = "ABOUT US".localizeString(string: Language.shared.currentAppLang)
        if Language.shared.isArabic {
            self.sideMenuController?.hideRightViewAnimated(sender: self)
        }
        else
        {
            self.sideMenuController?.hideLeftViewAnimated(sender: self)
        }
    }
    @IBAction func clickedContactUs(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
        let navigation = controller.rootViewController as! UINavigationController
        let ContactVC = mainStoryboard.instantiateViewController(withIdentifier: "ContactVC") as! ContactVC
        navigation.viewControllers = [ContactVC]
        if Language.shared.isArabic {
            self.sideMenuController?.hideRightViewAnimated(sender: self)
        }
        else
        {
            self.sideMenuController?.hideLeftViewAnimated(sender: self)
        }
    }
    @IBAction func clickedTerms(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
        let navigation = controller.rootViewController as! UINavigationController
        let AboutVC = mainStoryboard.instantiateViewController(withIdentifier: "AboutVC") as! AboutVC
        navigation.viewControllers = [AboutVC]
        AboutVC.isOpenSide = true
        AboutVC.strTitle = "TERMS & CONDITIONS".localizeString(string: Language.shared.currentAppLang)
        if Language.shared.isArabic {
            self.sideMenuController?.hideRightViewAnimated(sender: self)
        }
        else
        {
            self.sideMenuController?.hideLeftViewAnimated(sender: self)
        }
    }
    @IBAction func clickedFeedBack(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
        let navigation = controller.rootViewController as! UINavigationController
        let FeedBackVC = mainStoryboard.instantiateViewController(withIdentifier: "FeedBackVC") as! FeedBackVC
        navigation.viewControllers = [FeedBackVC]
        if Language.shared.isArabic {
            self.sideMenuController?.hideRightViewAnimated(sender: self)
        }
        else
        {
            self.sideMenuController?.hideLeftViewAnimated(sender: self)
        }
    }
    @IBAction func clickedTell(_ sender: Any) {
        
        let textToShare = "Download Tashead Application"
        
        if let urlToShare = URL(string: "https://apps.apple.com/app/tashead-building-material/id6450504288") {
            let activityViewController = UIActivityViewController(activityItems: [textToShare, urlToShare], applicationActivities: nil)
            
            // For iPad, you need to set the sourceView to avoid a crash
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            // Present the view controller
            self.present(activityViewController, animated: true, completion: nil)
        } else {
            print("Invalid URL")
        }
        
    }
    
    @IBAction func clickedMyCommi(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
        let navigation = controller.rootViewController as! UINavigationController
        let SelectLangViewController = mainStoryboard.instantiateViewController(withIdentifier: "CommissionHistoryVC") as! CommissionHistoryVC
        navigation.viewControllers = [SelectLangViewController]
        if Language.shared.isArabic {
            self.sideMenuController?.hideRightViewAnimated(sender: self)
        }
        else
        {
            self.sideMenuController?.hideLeftViewAnimated(sender: self)
        }
    }
    
    @IBAction func clickedLoyaltyPoints(_ sender: Any) {
        let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
        let navigation = controller.rootViewController as! UINavigationController
        let SelectLangViewController = LoyaltyPointsVC()
        navigation.viewControllers = [SelectLangViewController]
        if Language.shared.isArabic {
            self.sideMenuController?.hideRightViewAnimated(sender: self)
        }
        else
        {
            self.sideMenuController?.hideLeftViewAnimated(sender: self)
        }
    }
    
    
    @IBAction func clickedCredits(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
        let navigation = controller.rootViewController as! UINavigationController
        let SelectLangViewController = mainStoryboard.instantiateViewController(withIdentifier: "CreditHistoryVC") as! CreditHistoryVC
        navigation.viewControllers = [SelectLangViewController]
        if Language.shared.isArabic {
            self.sideMenuController?.hideRightViewAnimated(sender: self)
        }
        else
        {
            self.sideMenuController?.hideLeftViewAnimated(sender: self)
        }
    }
    
    
    @IBAction func clickedLanguage(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
        let navigation = controller.rootViewController as! UINavigationController
        let SelectLangViewController = mainStoryboard.instantiateViewController(withIdentifier: "SelectLangViewController") as! SelectLangViewController
        navigation.viewControllers = [SelectLangViewController]
        if Language.shared.isArabic {
            self.sideMenuController?.hideRightViewAnimated(sender: self)
        }
        else
        {
            self.sideMenuController?.hideLeftViewAnimated(sender: self)
        }
    }
    @IBAction func clickedNotification(_ sender: UISwitch) {
    }
    
    // Action SoicalMedia
    
    @IBAction func clickedTwitter(_ sender: UIButton) {
        if sender.tag == 1 {
            // open twitter
            if let url = URL(string: appDelegate?.getApplicationSettingData().twitterLink ?? "") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            // open Website
            if let url = URL(string: "https://si-kw.com/") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
       
    }
    @IBAction func clickedInstagram(_ sender: Any) {
        if let url = URL(string: appDelegate?.getApplicationSettingData().instagramLink ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func clickedHome(_ sender: Any) {
        
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
        let navigation = controller.rootViewController as! UINavigationController
        let ContactVC = mainStoryboard.instantiateViewController(withIdentifier: "NewHomeVC") as! NewHomeVC
        navigation.viewControllers = [ContactVC]
        if Language.shared.isArabic {
            self.sideMenuController?.hideRightViewAnimated(sender: self)
        }
        else
        {
            self.sideMenuController?.hideLeftViewAnimated(sender: self)
        }
    }
    
    @IBAction func clickedInbox(_ sender: Any) {
        
        if let isUserLogin = appDelegate?.getIsUserLogin()
        {
            if isUserLogin == true
            {
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
                let navigation = controller.rootViewController as! UINavigationController
                let ContactVC = InboxViewController()
                navigation.viewControllers = [ContactVC]
                if Language.shared.isArabic {
                    self.sideMenuController?.hideRightViewAnimated(sender: self)
                }
                else
                {
                    self.sideMenuController?.hideLeftViewAnimated(sender: self)
                }
            }
            else
            {
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
                let navigation = controller.rootViewController as! UINavigationController
                let OrderHistoryVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                navigation.viewControllers = [OrderHistoryVC]
                if Language.shared.isArabic {
                    self.sideMenuController?.hideRightViewAnimated(sender: self)
                }
                else
                {
                    self.sideMenuController?.hideLeftViewAnimated(sender: self)
                }
            }
        }
        else
        {
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = appDelegate?.window?.rootViewController as! LGSideMenuController
            let navigation = controller.rootViewController as! UINavigationController
            let OrderHistoryVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigation.viewControllers = [OrderHistoryVC]
            if Language.shared.isArabic {
                self.sideMenuController?.hideRightViewAnimated(sender: self)
            }
            else
            {
                self.sideMenuController?.hideLeftViewAnimated(sender: self)
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
                        
                        
                        
                    }
                    else
                    {
                        appDelegate?.strTotalCount = "0"
                        
                        
                        
                        APIClient.sharedInstance.hideIndicator()
                    }
                    
                }
                else
                {
                    appDelegate?.strTotalCount = "0"
                    
                    APIClient.sharedInstance.hideIndicator()
                    
                    if message?.contains("Unauthenticated.") == true
                    {
                        appDelegate?.strTotalCount = "0"
                        
                        appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
                        appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
                        appDelegate?.saveCmsAdverd(dic: TBCmsAdverdResult())
                        appDelegate?.saveIsUserLogin(dic: false)
                    }
                }
            }
            else
            {
                appDelegate?.strTotalCount = "0"
                
                
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    func callProfileDetailAPI()
    {
        
        let param = ["governorate_id":"\(appDelegate?.dicCurrentLoginUser.id ?? 0)"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(GET_PROFILE, parameters: param) { response, error, statusCode in
            
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
                        if let dic = response?.value(forKey: "result") as? NSDictionary
                        {
                            let dicData = TBLoginUserResult(fromDictionary: dic)
                           
                            appDelegate?.saveCuurentUserData(dic: dicData)
                            appDelegate?.dicCurrentLoginUser = dicData
                            
                            if appDelegate?.dicCurrentLoginUser.role == "wholesaler" {
                                
                                self.viewComm.isHidden = false
                                
                                if appDelegate?.dicCurrentLoginUser.is_show_credit == 1 {
                                    self.viewCredits.isHidden = false
                                }
                                else {
                                    self.viewCredits.isHidden = true
                                }
                                
                            }
                            else
                            {
                                self.viewComm.isHidden = true
                                self.viewCredits.isHidden = true
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
                    if message?.contains("Unauthenticated.") == true
                    {
                        appDelegate?.strTotalCount = "0"
                        
                        appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
                        appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
                        
                        appDelegate?.saveIsUserLogin(dic: false)
                    }
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
