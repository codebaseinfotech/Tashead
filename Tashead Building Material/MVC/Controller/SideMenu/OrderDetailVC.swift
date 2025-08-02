//
//  OrderDetailVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 01/01/24.
//

import UIKit
import LGSideMenuController
import MarqueeLabel
import SDWebImage

class OrderDetailVC: UIViewController {

    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblOrderID: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var lblSTotal: UILabel!
    @IBOutlet weak var lblDCharge: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblPaymentMethod: UILabel!
    
    @IBOutlet weak var lblTSub: UILabel!
    @IBOutlet weak var lblTDC: UILabel!
    @IBOutlet weak var lblTDiscount: UILabel!
    @IBOutlet weak var lblTTotal: UILabel!
    @IBOutlet weak var lblTPayment: UILabel!
    
    var dicOrderDetail = TBOrderDetailResult()
    
    var strId = 0
    
    var isAPICall = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTSub.text = "Subtotal:".localizeString(string: Language.shared.currentAppLang)
        lblTDC.text = "Delivery Charge:".localizeString(string: Language.shared.currentAppLang)
        lblTDiscount.text = "Discount/Promo:".localizeString(string: Language.shared.currentAppLang)
        lblTTotal.text = "Total:".localizeString(string: Language.shared.currentAppLang)
        lblTPayment.text = "Payment Method".localizeString(string: Language.shared.currentAppLang)
        
        tblView.delegate = self
        tblView.dataSource = self
        
        callOrderListAPI(id: strId)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedSideMenu(_ sender: Any) {
        if Language.shared.isArabic {
            self.sideMenuController?.showRightView(animated: true, completion: nil)
        }
        else
        {
            self.sideMenuController?.showLeftView(animated: true, completion: nil)
        }
    }
    @IBAction func clickedBacl(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickedCart(_ sender: Any) {
    }
    
    func callOrderListAPI(id: Int)
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(ORDER_DETAILS + "\(id)", parameters: param) { response, error, statusCode in
            
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
                            let dicData = TBOrderDetailResult(fromDictionary: dic)
                            self.dicOrderDetail = dicData
                            
                            self.lblSTotal.text = "\(self.dicOrderDetail.total.cartSubTotal ?? "") KD"
                            self.lblDCharge.text = "\(self.dicOrderDetail.total.cartDeliveryCharge ?? "") KD"
                            self.lblDiscount.text = "0.00 KD"
                            
                            self.lblTotal.text = "\(self.dicOrderDetail.total.cartTotal ?? "") KD"
                            
                            self.lblOrderID.text = "\("Order ID:".localizeString(string: Language.shared.currentAppLang)) \(self.dicOrderDetail.orderId ?? 0)"
                            
                            self.lblDate.text =  self.utcToLocal(dateStr: self.dicOrderDetail.order_date ?? "")
                            
                        }
                        
                        self.isAPICall = true
                        
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
    
}

extension OrderDetailVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isAPICall == true{
            return self.dicOrderDetail.orderItems.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "OrderHistoryCell") as! OrderHistoryCell
        
        let dicData = self.dicOrderDetail.orderItems[indexPath.row]
        
        if dicData.is_supplier_detail_show == 0 {
            cell.lblsuu.isHidden = true
            cell.viewSuu.isHidden = true
        }
        else
        {
            cell.lblsuu.isHidden = false
            cell.viewSuu.isHidden = false
        }
        
        cell.lblName.text = dicData.productName ?? ""
        
        cell.lblSupier.text = dicData.supplierName ?? ""
        
        cell.lblWeight.text = "\(dicData.weight ?? 0) \(dicData.weight_type ?? "")"
        
        cell.lblUnit.text = dicData.unitType ?? ""

        cell.lblPrice.text = "\(dicData.total ?? "") KD"
 
        cell.lblQty.text = "\(dicData.quantity ?? 0)"
        
        var media_link_url = dicData.image ?? ""
        media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        cell.imgPic.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

class OrderHistoryCell: UITableViewCell
{
    @IBOutlet weak var imgPic: UIImageView!
    @IBOutlet weak var lblName: MarqueeLabel!
    @IBOutlet weak var lblWeight: MarqueeLabel!
    @IBOutlet weak var lblSupier: MarqueeLabel!
    @IBOutlet weak var lblUnit: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblTUnit: UILabel!
    @IBOutlet weak var lblTQty: UILabel!
    @IBOutlet weak var lblTWeight: UILabel!
    
    @IBOutlet weak var viewSuu: UIView!
    
    @IBOutlet weak var lblsuu: UILabel!
    
}
