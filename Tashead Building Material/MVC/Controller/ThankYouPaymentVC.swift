//
//  ThankYouPaymentVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 27/07/24.
//

import UIKit

class ThankYouPaymentVC: UIViewController {
    
    
    @IBOutlet weak var viewFail: UIView!
    @IBOutlet weak var lblFail: UILabel!
    
    
    @IBOutlet weak var viewLineSuc: UIView!
    
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var lblPaymentSuccess: UILabel!
    
    @IBOutlet weak var lblOrderNumber: UILabel!
    @IBOutlet weak var lblOrderNumberData: UILabel!
    
    @IBOutlet weak var lblTraID: UILabel!
    @IBOutlet weak var lblTraIDData: UILabel!

    @IBOutlet weak var lblTraDate: UILabel!
    @IBOutlet weak var lblTraDateData: UILabel!

    @IBOutlet weak var lblOrderTotal: UILabel!
    @IBOutlet weak var lblOrderTotalData: UILabel!

    @IBOutlet weak var btnShopping: UIButton!

    var dicData: [String: Any]?
    
    var isSuccess = false
    
    var isFromCredit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isSuccess == true
        {
            imgBack.isHidden = false
            
            
            viewFail.isHidden = true
            lblFail.isHidden = true

            viewLineSuc.isHidden = false
            btnShopping.isHidden = false
            lblOrderNumber.isHidden = false
            lblTraID.isHidden = false
            lblTraDate.isHidden = false
            lblOrderTotal.isHidden = false
            lblPaymentSuccess.isHidden = false

            lblOrderNumberData.isHidden = false
            lblTraIDData.isHidden = false
            lblOrderTotalData.isHidden = false
            lblTraDateData.isHidden = false

            
            
            if isFromCredit == true {
                lblOrderNumber.text = ""
                btnShopping.setTitle("Continue".localizeString(string: Language.shared.currentAppLang), for: .normal)
              }
            else {
                lblOrderNumber.text = "Order Number".localizeString(string: Language.shared.currentAppLang)
                btnShopping.setTitle("Continue Shopping".localizeString(string: Language.shared.currentAppLang), for: .normal)
              }
            
            lblTraID.text = "Transaction ID".localizeString(string: Language.shared.currentAppLang)
            lblTraDate.text = "Transaction Date".localizeString(string: Language.shared.currentAppLang)
            lblOrderTotal.text = "Total".localizeString(string: Language.shared.currentAppLang)
            
            lblPaymentSuccess.text = "Payment Approved".localizeString(string: Language.shared.currentAppLang)
            
            lblOrderNumberData.text = "\((dicData?["order_id"] as? String) ?? "")"
            lblTraIDData.text = "\((dicData?["tranid"] as? String) ?? "")"
            lblOrderTotalData.text = "\((dicData?["amount"] as? String) ?? "") KD"
            
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy"
            self.lblTraDateData.text = dateFormatter.string(from: currentDate)
        }
        else
        {
            imgBack.isHidden = true

            viewFail.isHidden = false
            lblFail.isHidden = false
            btnShopping.isHidden = false
            
            viewLineSuc.isHidden = true
 
            lblPaymentSuccess.isHidden = true
            
            lblOrderNumber.isHidden = true
            lblTraID.isHidden = true
            lblTraDate.isHidden = true
            lblOrderTotal.isHidden = true

            
            lblOrderNumberData.isHidden = true
            lblTraIDData.isHidden = true
            lblOrderTotalData.isHidden = true
            lblTraDateData.isHidden = true
 
            
            lblFail.text = "Transfer has been declined".localizeString(string: Language.shared.currentAppLang)
            btnShopping.setTitle("Go back to checkout".localizeString(string: Language.shared.currentAppLang), for: .normal)
         }
 
 
        // Do any additional setup after loading thetranidz view.
    }
 
    @IBAction func clickedShoppomg(_ sender: Any) {
        
        if isSuccess == true
        {
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
                
                if isFromCredit == true {
                    let controllers = self.navigationController?.viewControllers
                    for vc in controllers! {
                        if vc is CreditHistoryVC {
                            _ = self.navigationController?.popToViewController(vc as! CreditHistoryVC, animated: true)
                        }
                    }
                }
                else {
                    appDelegate?.setUpHome()
                }
               
            }
            
        }
        else
        {
            
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
                
                if isFromCredit == true {
                    let controllers = self.navigationController?.viewControllers
                    for vc in controllers! {
                        if vc is CreditHistoryVC {
                            _ = self.navigationController?.popToViewController(vc as! CreditHistoryVC, animated: true)
                        }
                    }
                }
                else {
                    let controllers = self.navigationController?.viewControllers
                    for vc in controllers! {
                        if vc is PaymentVC {
                            _ = self.navigationController?.popToViewController(vc as! PaymentVC, animated: true)
                        }
                    }
                }
                
                
            }
        }

    }
    
}
