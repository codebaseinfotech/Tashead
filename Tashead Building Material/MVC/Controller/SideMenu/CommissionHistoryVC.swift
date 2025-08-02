//
//  CommissionHistoryVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 06/05/24.
//

import UIKit

class CommissionHistoryVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var viewCart: UIView!
    @IBOutlet weak var lblCartCount: UILabel!
    
    @IBOutlet weak var lblTotalCommission: UILabel!
    
    @IBOutlet weak var lblTComm: UILabel!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var lblTotalPaid: UILabel!
    @IBOutlet weak var lblAvailableCommission: UILabel!
    
    
    var arrCommissionList: [TBCommissionUserOrderedDiscount] = [TBCommissionUserOrderedDiscount]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTComm.text = "COMMISSION HISTORY".localizeString(string: Language.shared.currentAppLang)

        tblView.delegate = self
        tblView.dataSource = self
        
        if Language.shared.isArabic {
            imgBack.image = UIImage(named: "Back_Ar")
        }
        else
        {
            imgBack.image = UIImage(named: "Back")
        }
        
        callComminsonAPI(isShowIndicator: true)
        callGetCartAPI()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        appDelegate?.setUpHome()    
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
    
    
    func callComminsonAPI(isShowIndicator: Bool)
    {
        if isShowIndicator == true{
            APIClient.sharedInstance.showIndicator()
        }
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(COMMISSION_LIST, parameters: param) { response, error, statusCode in
            
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
                        if let dic_result = response?.value(forKey: "result") as? NSDictionary
                        {
                            let total_commission_amount = dic_result.value(forKey: "total_commission_amount") as? Float
                            let total_paid_commission_amount = dic_result.value(forKey: "total_paid_commission_amount") as? Float
                            let total_unpaid_commission_amount = dic_result.value(forKey: "total_unpaid_commission_amount") as? Float
                            
                            self.lblTotalCommission.text = "Total Allowed Commission: \(total_commission_amount ?? 0.0) KD"
                            self.lblTotalPaid.text = "Total Paid:" + " " + "\(total_paid_commission_amount ?? 0.0)" + " KD"
                            self.lblAvailableCommission.text = "Available Commission:" + " " + "\(total_unpaid_commission_amount ?? 0.0)" + " KD"
                            
                            if let arr_user_ordered_discounts = dic_result.value(forKey: "user_ordered_discounts") as? NSArray
                            {
                                for obj in arr_user_ordered_discounts
                                {
                                    let dicData = TBCommissionUserOrderedDiscount(fromDictionary: obj as! NSDictionary)
                                    self.arrCommissionList.append(dicData)
                                }
                            }
                            
                        }
                        self.tblView.reloadData()
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
                            self.viewCart.isHidden = true
                        }
                        else
                        {
                            self.viewCart.isHidden = true
                        }
                        
                        self.lblCartCount.text = "\(arrCart.count)"
                    }
                    else
                    {
                        appDelegate?.strTotalCount = "0"
                        self.lblCartCount.text = "0"
                        
                        if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCart.isHidden = true
                        }
                        else
                        {
                            self.viewCart.isHidden = true
                        }
                        
                        APIClient.sharedInstance.hideIndicator()
                    }
                    
                }
                else
                {
                    if appDelegate?.strTotalCount == "0"
                    {
                        self.viewCart.isHidden = true
                    }
                    else
                    {
                        self.viewCart.isHidden = true
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
  

}

extension CommissionHistoryVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCommissionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "MyOrderCell") as! MyOrderCell
        
        let dicData = arrCommissionList[indexPath.row]
        
        cell.lblOrderId.text = "Order ID: \(dicData.orderId ?? 0)"
        
        cell.lblPrice.text = "\(dicData.commissionAmount ?? 0.0) KD"
        
        let bidAccepted = dicData.createdAt ?? ""
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date1 = formatter.date(from: bidAccepted)
        let Dform = DateFormatter()
        Dform.dateFormat = "dd MMM yyyy h:mm"
        let strDate = Dform.string(from: date1!)
        
        cell.lblDate.text = strDate
        
        if dicData.status == 0 {
            
            cell.viiewStatuss.backgroundColor = UIColor(hexString: "#FFE0E7")
            cell.lblStatus.textColor = UIColor(hexString: "#E66A86")
            cell.lblStatus.text = "Unpaid"
        } else {
            
            cell.viiewStatuss.backgroundColor = UIColor(hexString: "#FFE0E7")
            cell.lblStatus.textColor = UIColor(hexString: "#93BD98")
            cell.lblStatus.text = "Paid"
        }
        
        
        return cell
    }
    
    
}
