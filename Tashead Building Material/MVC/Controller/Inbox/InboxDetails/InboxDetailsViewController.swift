//
//  InboxDetailsViewController.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 11/07/25.
//

import UIKit

class InboxDetailsViewController: UIViewController {

    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgCart: UIImageView!
    @IBOutlet weak var viewCartCount: UIView!
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var lblTitleInbox: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txtMessage: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgBack.image = Language.shared.isArabic ? UIImage(named: "Back_Ar") : UIImage(named: "Back")
            
        lblTitleInbox.text = "Inbox".localizeString(string: Language.shared.currentAppLang)
        callGetCartAPI()


        // Do any additional setup after loading the view.
    }

    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickedCart(_ sender: Any) {
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
                        var objCart = TBCartListResult()

                        if let dicResult = response?.value(forKey: "result") as? NSDictionary
                        {
                            
                            objCart = TBCartListResult(fromDictionary: dicResult)
                            
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
                            self.viewCartCount.isHidden = true
                        }
                        else
                        {
                            self.viewCartCount.isHidden = false
                        }
                        
                        self.lblCartCount.text = "\(arrCart.count)"
                    }
                    else
                    {
                        appDelegate?.strTotalCount = "0"
                        self.lblCartCount.text = "0"
                        
                        if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCartCount.isHidden = true
                        }
                        else
                        {
                            self.viewCartCount.isHidden = false
                        }
                        
                        APIClient.sharedInstance.hideIndicator()
                    }
                    
                }
                else
                {
                    if appDelegate?.strTotalCount == "0"
                    {
                        self.viewCartCount.isHidden = true
                    }
                    else
                    {
                        self.viewCartCount.isHidden = false
                    }
                    
                    self.lblCartCount.text = "0"
                    
                    if message?.contains("Unauthenticated.") == true
                    {
                        appDelegate?.strTotalCount = "0"
                        
                        appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
                        appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
                        appDelegate?.saveCmsAdverd(dic: TBCmsAdverdResult())
                        var arrAddressList : [TBAddressResult] = [TBAddressResult]()
                        appDelegate?.saveUserAllAddress(dic: arrAddressList)
                        appDelegate?.saveIsUserLogin(dic: false)
                    }
                    
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
