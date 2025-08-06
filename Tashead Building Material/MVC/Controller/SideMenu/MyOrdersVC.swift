//
//  MyOrdersVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 02/05/24.
//

import UIKit

class MyOrdersVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var viewTop: UIView!
    
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var viewCountItem: UIView!
    @IBOutlet weak var lblCartCount: UILabel!
    
    var arrOrderList: [TBOrderListResult] = [TBOrderListResult]()
    
    var strOrderID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewTop.clipsToBounds = true
        viewTop.layer.cornerRadius = 15
        viewTop.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        
        
        tblView.delegate = self
        tblView.dataSource = self
        
        lblTitle.text = "YOUR ORDERS".localizeString(string: Language.shared.currentAppLang)
        
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
        
    }
    
    @IBAction func clickedCancel(_ sender: Any) {
        
        txtMobileNumber.text = ""
        
        self.mainView.isHidden = true
    }
    
    @IBAction func clickedSend(_ sender: Any) {
        
        if txtMobileNumber.text == ""
        {
            self.setUpMakeToast(msg: "Please enter mobile number".localizeString(string: Language.shared.currentAppLang))
        }
        else if (txtMobileNumber.text?.count ?? 0) != 8
        {
            self.setUpMakeToast(msg: "Please enter valid mobile number".localizeString(string: Language.shared.currentAppLang))
        }
        else
        {
            self.mainView.isHidden = true
            callOrderDoPaymentChangeMobileAPI(orderID: "\(self.strOrderID)")
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
    
    func callOrderDoPaymentAPI(orderID: String)
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["order_id":orderID]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(REND_ORDER_DO_PAYMENT, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                self.strOrderID = ""
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        APIClient.sharedInstance.hideIndicator()
                        
                        self.mainView.isHidden = true
                        
                        let mainS =  UIStoryboard(name: "Home", bundle: nil)
                        let vc = mainS.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
                        vc.strTitle = "Payment link sent successfully."
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: false)
                    }
                    else
                    {
                        self.mainView.isHidden = true
                        self.setUpMakeToast(msg: message ?? "")
                        APIClient.sharedInstance.hideIndicator()
                    }
                    
                }
                else
                {
                    self.mainView.isHidden = true
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
                self.mainView.isHidden = true
                self.strOrderID = ""
                
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    func callOrderDoPaymentChangeMobileAPI(orderID: String)
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["order_id":orderID,"country_code":"965","mobile_number":self.txtMobileNumber.text ?? ""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(REND_ORDER_DO_PAYMENT, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                self.strOrderID = ""
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        APIClient.sharedInstance.hideIndicator()
                        
                        self.mainView.isHidden = true
                        
                        self.txtMobileNumber.text = ""
                        
                        let mainS =  UIStoryboard(name: "Home", bundle: nil)
                        let vc = mainS.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
                        vc.strTitle = "Payment link sent successfully."
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: false)
                    }
                    else
                    {
                        self.txtMobileNumber.text = ""
                        
                        self.mainView.isHidden = true
                        self.setUpMakeToast(msg: message ?? "")
                        APIClient.sharedInstance.hideIndicator()
                    }
                    
                }
                else
                {
                    self.txtMobileNumber.text = ""
                    
                    self.mainView.isHidden = true
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
                self.txtMobileNumber.text = ""
                
                self.mainView.isHidden = true
                self.strOrderID = ""
                
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
}

extension MyOrdersVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOrderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "MyOrderCell") as! MyOrderCell
        
        let dicData = arrOrderList[indexPath.row]
        
        
        if dicData.isPaid == 0
        {
            cell.viewPaymentPending.isHidden = false
            cell.viewNew.isHidden = true
            
            if dicData.send_invoice_to == ""
            {
                cell.viewResend.isHidden = true
                cell.viewShareLink.isHidden = true
                cell.viewChangeNumber.isHidden = true
            }
            else
            {
                cell.viewResend.isHidden = false
                cell.viewShareLink.isHidden = false
                cell.viewChangeNumber.isHidden = false
            }
            
        }
        else
        {
            cell.viewPaymentPending.isHidden = true
            cell.viewResend.isHidden = true
            cell.viewShareLink.isHidden = true
            cell.viewChangeNumber.isHidden = true
            
            cell.viewNew.isHidden = false
            
            cell.lblNew.text = dicData.order_status_text.localizeString(string: Language.shared.currentAppLang)
            
            if dicData.order_status_text == "New" {
                cell.viewNew.backgroundColor = UIColor(hexString: "#e2e8f0")
                cell.lblNew.textColor = UIColor(hexString: "#9da8b8")
            } else if dicData.order_status_text == "Delivered" {
                cell.viewNew.backgroundColor = UIColor(hexString: "#e7f8e7")
                cell.lblNew.textColor = UIColor(hexString: "#8fd28f")

            } else if dicData.order_status_text == "Out for Delivery" {
                cell.viewNew.backgroundColor = UIColor(hexString: "#e6e9ff")
                cell.lblNew.textColor = UIColor(hexString: "#7f8afc")

            } else if dicData.order_status_text == "Cancelled" {
                cell.viewNew.backgroundColor = UIColor(hexString: "#fde4ea")
                cell.lblNew.textColor = UIColor(hexString: "#f46d8e")

            } else if dicData.order_status_text == "Confirm" {
                cell.viewNew.backgroundColor = UIColor(hexString: "#FFEED7")
                cell.lblNew.textColor = .orange
            }
        }
        
        cell.lblOrderId.text = "\("Order ID:".localizeString(string: Language.shared.currentAppLang) ) \(dicData.orderId ?? 0)"
        
        cell.btnDetails.setTitle("View Details".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        cell.lblDate.text = utcToLocal(dateStr: dicData.createdDate ?? "")
        
        cell.lblPrice.text = "\(dicData.order_total ?? "") KD"
        
        
        cell.lblResendlink.text = "Reset Link".localizeString(string: Language.shared.currentAppLang)
        cell.lblShareLink.text = "Share Link".localizeString(string: Language.shared.currentAppLang)
        cell.lblChangeNumber.text = "Change Number".localizeString(string: Language.shared.currentAppLang)
        cell.lblPaymentPending.text = "Payment Pending".localizeString(string: Language.shared.currentAppLang)
//        cell.lblNew.text = "New".localizeString(string: Language.shared.currentAppLang)
        

        cell.btnDetails.tag = indexPath.row
        cell.btnDetails.addTarget(self, action: #selector(clickedViewDetails(_:)), for: .touchUpInside)
        
        cell.btnResendPay.tag = indexPath.row
        cell.btnResendPay.addTarget(self, action: #selector(clickedRePayment(_:)), for: .touchUpInside)
        
        cell.btnChangeNumber.tag = indexPath.row
        cell.btnChangeNumber.addTarget(self, action: #selector(clickedChangeMobile(_:)), for: .touchUpInside)
        
        cell.tapShareLink = { index in
            
            self.callGetPaymentLink(orderID: "\(dicData.orderId ?? 0)")
         
        }
        
        return cell
    }
    
    @objc func clickedRePayment(_ sender: UIButton)
    {
        let dicData = arrOrderList[sender.tag]
        
        callOrderDoPaymentAPI(orderID: "\(dicData.orderId ?? 0)")
    }
    
    @objc func clickedChangeMobile(_ sender: UIButton)
    {
        let dicData = arrOrderList[sender.tag]
        
        self.txtMobileNumber.text = dicData.send_invoice_to ?? ""
        
        self.strOrderID = "\(dicData.orderId ?? 0)"
        
        self.mainView.isHidden = false
    }
    
    @objc func clickedViewDetails(_ sender: UIButton)
    {
        let dicData = arrOrderList[sender.tag]
        
        if let url = URL(string: dicData.invoice_url ?? "") {
            openPDFInSafari(pdfURL: url)
        }
        
        //        let mainS = UIStoryboard(name: "Home", bundle: nil)
        //        let vc = mainS.instantiateViewController(withIdentifier: "OrderDetailVC") as! OrderDetailVC
        //        vc.strId = dicData.orderId ?? 0
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openPDFInSafari(pdfURL: URL) {
        if UIApplication.shared.canOpenURL(pdfURL) {
            UIApplication.shared.open(pdfURL, options: [:], completionHandler: nil)
        } else {
            print("Cannot open PDF URL")
        }
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
    
    func callGetPaymentLink(orderID: String)
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["order_id":orderID]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(ORDER_GET_PAYMENT_LINK, parameters: param) { response, error, statusCode in
            
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
                        if let strResult = response?.value(forKey: "result") as? String
                        {
                            let textToShare = strResult
                            let items: [Any] = [textToShare]
                            let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
                            activityVC.popoverPresentationController?.sourceView = self.view
                            self.present(activityVC, animated: true, completion: nil)
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

class MyOrderCell: UITableViewCell
{
    
    @IBOutlet weak var viewPaymentPending: UIView!
    @IBOutlet weak var lblPaymentPending: UILabel!
    
    
    @IBOutlet weak var viewResend: UIView!
    @IBOutlet weak var btnResendPay: UIButton!
    @IBOutlet weak var lblResendlink: UILabel!
    
    
    @IBOutlet weak var viewChangeNumber: UIView!
    @IBOutlet weak var btnChangeNumber: UIButton!
    @IBOutlet weak var lblChangeNumber: UILabel!
    
    @IBOutlet weak var viewNew: UIView!
    @IBOutlet weak var lblNew: UILabel!
    
    @IBOutlet weak var btnShareLink: UIButton!
    
    @IBOutlet weak var lblShareLink: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var btnDetails: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var viiewStatuss: UIView!
    @IBOutlet weak var lblStatus: UILabel!
    
    
    @IBOutlet weak var viewShareLink: UIView!
    
    var tapShareLink: ((Int)->Void)?
    
    @IBAction func clickedShareLink(_ sender: UIButton) {
        tapShareLink?(sender.tag)
    }
    
}
