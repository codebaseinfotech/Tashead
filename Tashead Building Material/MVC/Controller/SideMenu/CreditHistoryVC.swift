//
//  CreditHistoryVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 04/07/25.
//

import UIKit

class CreditHistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var scrollView_: UIScrollView!
    
    @IBOutlet weak var viewCurrentBalaHide: UIView!
    @IBOutlet weak var viewDueAmountHide: UIView!
    @IBOutlet weak var viewOtherHide: UIView!
    
    @IBOutlet weak var viewPayNowHide: UIView!
    
    @IBOutlet weak var lblCurrentBalan: UILabel!
    @IBOutlet weak var lblDueAmount_: UILabel!
    @IBOutlet weak var lblOtherAmount_: UILabel!
    
    @IBOutlet weak var lblNodata: UILabel!
    
    
    @IBOutlet weak var viewPaymentSub: UIView!
    @IBOutlet weak var viewPaymentSectionSub: UIView!
    @IBOutlet weak var viewPayNowHeifhtCont: NSLayoutConstraint! //90
    
    
    @IBOutlet weak var lblTotalCredit: UILabel!
    @IBOutlet weak var lblUsedCredit: UILabel!
    @IBOutlet weak var lblDueAmount: UILabel!
    
    
    @IBOutlet weak var lblPayTotal: UILabel!
    @IBOutlet weak var lblPayDueAmount: UILabel!
    
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewPayDue: UIView!
    @IBOutlet weak var imgPayDue: UIImageView!
    
    
    @IBOutlet weak var viewCustomAmounta: UIView!
    @IBOutlet weak var txtAmount: UITextField!
    
    
    @IBOutlet weak var viewPay2: UIView!
    @IBOutlet weak var imgPay2: UIImageView!
    
    @IBOutlet weak var viewPther: UIView!
    @IBOutlet weak var imgOther: UIImageView!
    
    @IBOutlet weak var btnPayNow: UIButton!
    @IBOutlet weak var viewCartCount: UIView!
    @IBOutlet weak var lblCartCount: UILabel!
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var lblCreditHistory: UILabel!
    @IBOutlet weak var lblTotalAssignedCredit: UILabel!
    @IBOutlet weak var lblTTotalUsedCredit: UILabel!
    @IBOutlet weak var lblTDueAmount: UILabel!
    
    @IBOutlet weak var lblTitleAvailableBalance: UILabel!
    @IBOutlet weak var lblAvailableBalance: UILabel!
    
    var arrCreditHistory: [TBCreditHistoryResult] = [TBCreditHistoryResult]()
    
    var isHideAmount = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCreditHistory.text = "STATEMENT".localizeString(string: Language.shared.currentAppLang)
        
        lblNodata.text = "No Data Found".localizeString(string: Language.shared.currentAppLang)
        
        lblTotalAssignedCredit.text = "Total Credit:".localizeString(string: Language.shared.currentAppLang)
        
        lblTTotalUsedCredit.text = "Total Used Credit:".localizeString(string: Language.shared.currentAppLang)
        lblTDueAmount.text = "Total Due Amount:".localizeString(string: Language.shared.currentAppLang)
        
        lblCurrentBalan.text = "Current balance".localizeString(string: Language.shared.currentAppLang)
        lblDueAmount_.text = "Due amount".localizeString(string: Language.shared.currentAppLang)
        lblOtherAmount_.text = "Other amount".localizeString(string: Language.shared.currentAppLang)
        lblTitleAvailableBalance.text = "Available Balance:".localizeString(string: Language.shared.currentAppLang)
        
        
        btnPayNow.setTitle("Pay now".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        imgBack.image = Language.shared.isArabic ? UIImage(named: "Back_Ar") : UIImage(named: "Back")
        
        txtAmount.textAlignment = Language.shared.isArabic ? NSTextAlignment.right : NSTextAlignment.left

        
        //        viewCustomAmounta.isHidden = true
        imgPayDue.isHidden = false
        imgPay2.isHidden = true
        imgOther.isHidden = true
        
        self.txtAmount.delegate = self
        self.txtAmount.addTarget(self, action: #selector(searchWorkersAsPerTextSearch(_ :)), for: .editingChanged)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callCreidtHistoryAPI()
        
        callGetWalletAPI()
        callGetCartAPI()
        
        txtAmount.text = ""
        //        viewCustomAmounta.isHidden = true
        imgPayDue.isHidden = false
        imgPay2.isHidden = true
        imgOther.isHidden = true
        
        btnPayNow.backgroundColor = UIColor(red: 247/255, green: 196/255, blue: 145/255, alpha: 1)
        btnPayNow.setTitleColor(UIColor.black, for: .normal)
    }
    
    @objc func searchWorkersAsPerTextSearch(_ textfield:UITextField) {
        
        if textfield.text == ""
        {
            self.setUpHideToast()
            btnPayNow.backgroundColor = UIColor(red: 224/255, green: 227/255, blue: 224/255, alpha: 1)
            btnPayNow.setTitleColor(UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1), for: .normal)
        }
        else
        {
            
            imgPayDue.isHidden = true
            imgPay2.isHidden = true
            imgOther.isHidden = true
            
//            if (Double(self.lblUsedCredit.text?.replacingOccurrences(of: " KD", with: "") ?? "") ?? 0.0) >= (Double(textfield.text ?? "") ?? 0.0)
//            {
                self.setUpHideToast()
                btnPayNow.backgroundColor = UIColor(red: 247/255, green: 196/255, blue: 145/255, alpha: 1)
                btnPayNow.setTitleColor(UIColor.black, for: .normal)
//            }
//            else {
//                self.setUpMakeToast(msg: "Enter a valid custom amount up to \(self.lblUsedCredit.text ?? "")")
//                btnPayNow.backgroundColor = UIColor(red: 224/255, green: 227/255, blue: 224/255, alpha: 1)
//                btnPayNow.setTitleColor(UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1), for: .normal)
//            }
        }
    }
    
    @IBAction func clickedPayTotal(_ sender: Any) {
        
        txtAmount.text = ""
        //        viewCustomAmounta.isHidden = true
        imgPayDue.isHidden = false
        imgPay2.isHidden = true
        imgOther.isHidden = true
        
        if lblPayTotal.text == "0.000 KD" {
            btnPayNow.backgroundColor = UIColor(red: 224/255, green: 227/255, blue: 224/255, alpha: 1)
            btnPayNow.setTitleColor(UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1), for: .normal)
        }
        else {
            btnPayNow.backgroundColor = UIColor(red: 247/255, green: 196/255, blue: 145/255, alpha: 1)
            btnPayNow.setTitleColor(UIColor.black, for: .normal)
        }
        
    }
    
    @IBAction func clickedPayDue(_ sender: Any) {
        
        txtAmount.text = ""
        //        viewCustomAmounta.isHidden = true
        imgPayDue.isHidden = true
        imgPay2.isHidden = false
        imgOther.isHidden = true
        
        if lblPayDueAmount.text == "0.000 KD" {
            btnPayNow.backgroundColor = UIColor(red: 224/255, green: 227/255, blue: 224/255, alpha: 1)
            btnPayNow.setTitleColor(UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1), for: .normal)
            
        }
        else {
            btnPayNow.backgroundColor = UIColor(red: 247/255, green: 196/255, blue: 145/255, alpha: 1)
            btnPayNow.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    @IBAction func clickedOther(_ sender: Any) {
        imgPayDue.isHidden = true
        imgPay2.isHidden = true
        imgOther.isHidden = false
        //        viewCustomAmounta.isHidden = false
        btnPayNow.backgroundColor = UIColor(red: 224/255, green: 227/255, blue: 224/255, alpha: 1)
        btnPayNow.setTitleColor(UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1), for: .normal)
    }
    
    @IBAction func clickedPayNow(_ sender: Any) {
        
        if self.btnPayNow.backgroundColor == UIColor(red: 247/255, green: 196/255, blue: 145/255, alpha: 1) {
            callCreditPayCreditBill()
        }
        
        
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        appDelegate?.setUpHome()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCreditHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "CreditHistoryCell") as! CreditHistoryCell
        
        let dicData = arrCreditHistory[indexPath.row]
        
        if indexPath.row == 0 {
            cell.viewTopLine.isHidden = false
        }
        else {
            cell.viewTopLine.isHidden = true
        }
        
        if dicData.orderId != 0
        {
            cell.imgStatus.image = UIImage(named: "Group 61214")
            
            let OrderID = "Order ID:".localizeString(string: Language.shared.currentAppLang)
            cell.lblID.text = OrderID + " \(dicData.orderId ?? 0)"
        }
        else {
            
            cell.imgStatus.image = UIImage(named: "Group 61215")
            
            let OrderID = "Payment ID".localizeString(string: Language.shared.currentAppLang)
            cell.lblID.text = OrderID + ":" + " \(dicData.payment_id ?? "")"
        }
        
        cell.lblAmount.text = "\(dicData.amount ?? "") KD"
        
        let inputDateStr = dicData.createdAt ?? ""
        
        // 1. Create and configure the input formatter
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss a"
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
        // 2. Convert string to Date
        if let date = inputFormatter.date(from: inputDateStr) {
            
            // 3. Create and configure the output formatter
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMM yyyy HH:mm"
            outputFormatter.timeZone = TimeZone.current // convert to local time
            //            outputFormatter.timeZone = TimeZone(secondsFromGMT: 3 * 3600) // GMT+3 manually
            
            // 4. Convert Date to formatted string
            let outputDateStr = outputFormatter.string(from: date)
            cell.lblDate.text = outputDateStr
            print(outputDateStr) // Output: "05 Jul 2025 11:26"
            
        } else {
            print("Invalid date format")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dicData = arrCreditHistory[indexPath.row]
        
        if dicData.orderId != 0
        {
            if let url = URL(string: dicData.invoice_url ?? "") {
                openPDFInSafari(pdfURL: url)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func openPDFInSafari(pdfURL: URL) {
        if UIApplication.shared.canOpenURL(pdfURL) {
            UIApplication.shared.open(pdfURL, options: [:], completionHandler: nil)
        } else {
            print("Cannot open PDF URL")
        }
    }
    
    func callCreditPayCreditBill()
    {
        APIClient.sharedInstance.showIndicator()
        
        var amount = ""
        
        if imgPayDue.isHidden == false
        {
            amount = self.lblPayTotal.text?.replacingOccurrences(of: " KD", with: "") ?? "0"
        }
        else if imgPay2.isHidden == false
        {
            amount = self.lblPayDueAmount.text?.replacingOccurrences(of: " KD", with: "") ?? "0"
        }
        else
        {
            amount = self.txtAmount.text ?? ""
        }
        
        let param = ["amount":amount]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(CREDIT_PAY_CREDIT_BILL, parameters: param) { response, error, statusCode in
            
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
                        let payment_url = response?.value(forKey: "result") as? String
                        
                        let mainS = UIStoryboard(name: "Home", bundle: nil)
                        let vc = mainS.instantiateViewController(withIdentifier: "WebPaymentVC") as! WebPaymentVC
                        vc.strWebPaymentURL = payment_url ?? ""
                        vc.isFromCredit = true
                        self.navigationController?.pushViewController(vc, animated: false)
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
                    } else {
                        self.setUpMakeToast(msg: message ?? "")
                    }
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    func callCreidtHistoryAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(CREDIT_HISTROY, parameters: param) { response, error, statusCode in
            
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
                        self.arrCreditHistory.removeAll()
                        if let arrData = response?.value(forKey: "result") as? NSArray
                        {
                            for obj in arrData
                            {
                                let dicData = TBCreditHistoryResult(fromDictionary: obj as! NSDictionary)
                                
                                self.arrCreditHistory.append(dicData)
                            }
                            
                            self.tblViewHeight.constant = CGFloat(self.arrCreditHistory.count) * 85.0
                        }
                        
                        self.tblView.reloadData()
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
                    } else {
                        self.setUpMakeToast(msg: message ?? "")
                    }
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    func callGetWalletAPI()
    {
        // APIClient.sharedInstance.showIndicator()
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(WALLET, parameters: param) { response, error, statusCode in
            
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
                        if let result = response?.value(forKey: "result") as? NSDictionary {
                            let user_wallet_amount = result.value(forKey: "user_credit_amount") as? String ?? "0"
                            let used_credit = result.value(forKey: "used_credit") as? String ?? "0"
                            
                            let due_amount = result.value(forKey: "due_amount") as? String ?? "0"
                            let fixed_credit = result.value(forKey: "fixed_credit") as? String ?? "0"
                            
                            self.lblTotalCredit.text = "\(fixed_credit) KD"
                            self.lblUsedCredit.text = "\(used_credit) KD"
                            self.lblDueAmount.text = "\(due_amount) KD"
                            
                            self.lblAvailableBalance.text = "\(user_wallet_amount) KD"
                            
                            self.lblPayTotal.text = "\(used_credit) KD"
                            self.lblPayDueAmount.text = "\(due_amount) KD"
                            
                            if (Double(fixed_credit) ?? 0.0) == 0
                            {
                                self.scrollView_.isHidden = true
                            } else {
                                self.scrollView_.isHidden = false
                            }
                                
                            
                            if (Double(due_amount) ?? 0.0) > 0
                            {
                                self.viewDueAmountHide.isUserInteractionEnabled = true
                              
                            }
                            else {
                                self.viewDueAmountHide.isUserInteractionEnabled = false
                                
                                self.imgPayDue.isHidden = true
                            }
                            
                            
                            if (Double(used_credit) ?? 0.0) > 0
                            {
                                
                                self.viewCurrentBalaHide.isUserInteractionEnabled = true

                                self.btnPayNow.backgroundColor = UIColor(red: 247/255, green: 196/255, blue: 145/255, alpha: 1)
                                self.btnPayNow.setTitleColor(UIColor.black, for: .normal)
                            }
                            else {
                                
                                self.imgPay2.isHidden = true
                                
                                self.viewCurrentBalaHide.isUserInteractionEnabled = false
                                
                                self.btnPayNow.backgroundColor = UIColor(red: 224/255, green: 227/255, blue: 224/255, alpha: 1)
                                self.btnPayNow.setTitleColor(UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1), for: .normal)
                            }
                            
//                            if self.viewDueAmountHide.isUserInteractionEnabled == false && self.viewCurrentBalaHide.isUserInteractionEnabled == false
//                            {
//                                self.txtAmount.isUserInteractionEnabled = false
//                                self.viewOtherHide.isUserInteractionEnabled = false
//                            }
//                            else {
//                                self.txtAmount.isUserInteractionEnabled = true
//                                self.viewOtherHide.isUserInteractionEnabled = true
//                            }
                            
                            
                            if (Double(fixed_credit) ?? 0.0) > 0
                            {
                                
                                self.viewCurrentBalaHide.isHidden = false
                                self.viewDueAmountHide.isHidden = false
                                
                                self.viewPayNowHide.isHidden = false
                            }
                            else
                            {
                                self.viewCurrentBalaHide.isHidden = true
                                self.viewDueAmountHide.isHidden = true
                                
                                self.viewPayNowHide.isHidden = true
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
                            self.viewCartCount.isHidden = true
                        }
                        else
                        {
                            self.viewCartCount.isHidden = true
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
                            self.viewCartCount.isHidden = true
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
                        self.viewCartCount.isHidden = true
                    }
                    
                    self.lblCartCount.text = "0"
                    
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
                self.lblCartCount.text = "0"
                APIClient.sharedInstance.hideIndicator()
            }
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
    
    
}


class CreditHistoryCell: UITableViewCell
{
    
    @IBOutlet weak var viewTopLine: UIView!
    
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var lblID: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
}
