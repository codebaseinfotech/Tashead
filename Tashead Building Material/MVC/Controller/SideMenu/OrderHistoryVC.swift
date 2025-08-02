//
//  OrderHistoryVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 02/06/23.
//

import UIKit
import LGSideMenuController

class OrderHistoryVC: UIViewController {
    
    @IBOutlet weak var imgCart: UIImageView!
    
    @IBOutlet weak var viewCountItem: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblCartCount: UILabel!
    
    @IBOutlet weak var lblTOrderHistory: UILabel!
    
    
    var arrOrderList: [TBOrderListResult] = [TBOrderListResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTOrderHistory.text = "ORDER HISTORY".localizeString(string: Language.shared.currentAppLang)
        
        tblView.delegate = self
        tblView.dataSource = self
        
        callOrderListAPI()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        lblCartCount.text = appDelegate?.strTotalCount ?? ""
        
        if appDelegate?.strTotalCount == "0"
        {
            self.viewCountItem.isHidden = true
        }
        else
        {
            self.viewCountItem.isHidden = true
        }
        
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
    
    func callOrderListAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(GET_ORDER, parameters: param) { response, error, statusCode in
            
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
                        self.arrOrderList.removeAll()
                        if let arrData = response?.value(forKey: "result") as? NSArray
                        {
                            for obj in arrData
                            {
                                let dicData = TBOrderListResult(fromDictionary: obj as! NSDictionary)
                                self.arrOrderList.append(dicData)
                            }
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

extension OrderHistoryVC: UITableViewDelegate, UITableViewDataSource
{
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return 2
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOrderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "PaidCell") as! PaidCell
        
        let dicData = arrOrderList[indexPath.row]
        
        cell.lblName.text = dicData.productName ?? ""
        
        if Language.shared.isArabic {
            cell.lblName.textAlignment = .right
        } else {
            cell.lblName.textAlignment = .left
        }
        
        cell.lblID.text = "\("Order ID:".localizeString(string: Language.shared.currentAppLang) ) \(dicData.orderId ?? 0)"
        cell.lblTPaid.text = "Paid".localizeString(string: Language.shared.currentAppLang)
        
        cell.btnDetail.setTitle("Details".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        cell.lblDate.text = utcToLocal(dateStr: dicData.createdDate ?? "")
        
        return cell
    }
    
    func utcToLocal(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "GMT+3")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dicData = arrOrderList[indexPath.row]
        
        let mainS = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "OrderDetailVC") as! OrderDetailVC
        vc.strId = dicData.orderId ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

class PaidCell: UITableViewCell
{
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var btnDetail: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTPaid: UILabel!
    
}

class NotPaidCell: UITableViewCell
{
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnResendLink: UIButton!
    @IBOutlet weak var btnDetail: UIButton!
    @IBOutlet weak var imgWeight: NSLayoutConstraint!
    @IBOutlet weak var imgCheck: UIImageView!
    @IBOutlet weak var lblTNotPaid: UILabel!
    
}
