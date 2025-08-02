//
//  MyCartVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 05/06/23.
//

protocol CartDeleteDelegate
{
    func onCartDeleteReady(isDelete: Bool)
}

import UIKit
import LGSideMenuController
import SDWebImage
import MarqueeLabel

class MyCartVC: UIViewController,CartDeleteDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imgCart: UIImageView!
    
    
    @IBOutlet weak var viewCountItem: UIView!
    
    @IBOutlet weak var lblNoData: UILabel!
    
    
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblSTotal: UILabel!
    @IBOutlet weak var lblDCharge: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var txtNotes: UITextView!
    
    @IBOutlet weak var lblMyCart: UILabel!
    @IBOutlet weak var lblTSubTotal: UILabel!
    @IBOutlet weak var lblTDc: UILabel!
    @IBOutlet weak var lblTTotal: UILabel!
    @IBOutlet weak var lblTGeneralNot: UILabel!
    
    @IBOutlet weak var btnText: UIButton!
    @IBOutlet weak var btnTContinue: UIButton!
    @IBOutlet weak var txtPrmoCode: UITextField!
    
    @IBOutlet weak var viewMain2: UIStackView! {
        didSet {
            viewMain2.isHidden = appDelegate?.delivery_slot_allowed == 1 ? false : true
        }
    }
    @IBOutlet weak var viewLine2: UIView! {
        didSet {
            viewLine2.isHidden = appDelegate?.delivery_slot_allowed == 1 ? false : true
        }
    }
    @IBOutlet weak var lbl3: UILabel! {
        didSet {
            lbl3.text = appDelegate?.delivery_slot_allowed == 1 ? "3" : "2"
        }
    }
    
    var arrCart = TBCartListResult()
    
    var selectIndex = -1
    
    var isAPIDone = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblMyCart.text = "CHECKOUT".localizeString(string: Language.shared.currentAppLang)
        lblTSubTotal.text = "Subtotal:".localizeString(string: Language.shared.currentAppLang)
        lblTDc.text = "Delivery Charge:".localizeString(string: Language.shared.currentAppLang)
        lblTTotal.text = "Total:".localizeString(string: Language.shared.currentAppLang)
        lblTGeneralNot.text = "General notes".localizeString(string: Language.shared.currentAppLang)
        
        lblNoData.text = "Shopping Cart is Empty".localizeString(string: Language.shared.currentAppLang)

        btnText.setTitle("Next".localizeString(string: Language.shared.currentAppLang), for: .normal)
        btnTContinue.setTitle("Add Item".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        tblView.delegate = self
        tblView.dataSource = self
        
        txtNotes.delegate = self
        txtNotes.placeholder = "Notes".localizeString(string: Language.shared.currentAppLang)
        
        if Language.shared.isArabic {
            txtNotes.textAlignment = .right
            txtNotes.placeholderTextView.textAlignment = .right
        } else {
            txtNotes.textAlignment = .left
            txtNotes.placeholderTextView.textAlignment = .left
        }

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        callApplicationSettingAPI()
        
        callGetCartAPI(isShowIndicator: true)
        
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
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func clickedCart(_ sender: Any) {
//        let mainS = UIStoryboard(name: "Home", bundle: nil)
//        let vc = mainS.instantiateViewController(withIdentifier: "MyCartVC") as! MyCartVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func clickedContinueShopping(_ sender: Any) {
//        self.navigationController?.popViewController(animated: false)
        appDelegate?.setUpHome()
    }
    @IBAction func clickedNext(_ sender: Any) {
        
        //        if appDelegate?.getUserAllAddress().count == 1
        //        {
        
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let home: PaymentVC = mainStoryboard.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
        home.objCart = self.arrCart
        self.navigationController?.pushViewController(home, animated: false)
        
        
        //            let homeNavigation = UINavigationController(rootViewController: home)
        //            let leftViewController: SideMenuVC = mainStoryboard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        //            let controller = LGSideMenuController.init(rootViewController: homeNavigation, leftViewController: leftViewController, rightViewController: nil)
//            controller.leftViewWidth = home.view.frame.size.width - 70
//            homeNavigation.navigationBar.isHidden = true
//            appDelegate?.window?.rootViewController = controller
//            appDelegate?.window?.makeKeyAndVisible()
//        }
//        else
//        {
//            let mainS = UIStoryboard(name: "Home", bundle: nil)
//            let vc = mainS.instantiateViewController(withIdentifier: "AddressVC") as! AddressVC
//            vc.isGotoPayment = true
//            vc.isAddProfileAddress = false
//            vc.isUpdateProfile = false
//            vc.objCart = self.arrCart
//            let homeNavigation = UINavigationController(rootViewController: vc)
//            homeNavigation.navigationBar.isHidden = true
//            homeNavigation.modalPresentationStyle = .overFullScreen
//            self.present(homeNavigation, animated: false)
//        }
        
    }
    
    @IBAction func clickedEdit(_ sender: Any) {
    }
    
    @IBAction func clickedRedeemPromocode(_ sender: Any) {
        if self.txtPrmoCode.text == ""
        {
            self.setUpMakeToast(msg: "Please enter promo code".localizeString(string: Language.shared.currentAppLang))
        }
        else
        {
            callApplyCodeAPI(promocode: self.txtPrmoCode.text ?? "")
        }
    }
    
    func callApplyCodeAPI(promocode: String)
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["promocode":promocode,"cart_id":"\(self.arrCart.cartId ?? 0)"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(PROMOCODE_APPLY, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
               
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200
                {
                    if status == 1
                    {
//                        self.txtPromoCode.text = promocode
//                        self.txtPromoCode.isUserInteractionEnabled = false
//                        self.txtPromoCode.alpha = 0.6
                      //  self.btnApplyRemove.setTitle("Remove".localizeString(string: Language.shared.currentAppLang), for: .normal)
                        
                        self.callGetCartAPI(isShowIndicator: false)
                        
                        self.setUpMakeToast(msg: message ?? "")
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                        self.setUpMakeToast(msg: message ?? "")
                     }
                }
                else
                {
                    APIClient.sharedInstance.hideIndicator()
                    self.setUpMakeToast(msg: message ?? "")
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
         }
    }
    
    func callGetCartAPI(isShowIndicator: Bool)
    {
        if isShowIndicator == true{
            APIClient.sharedInstance.showIndicator()
        }
        
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
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        if let dicResult = response?.value(forKey: "result") as? NSDictionary
                        {
                            let dicData = TBCartListResult(fromDictionary: dicResult as! NSDictionary)
                            self.arrCart = dicData
                        }
                        
                        self.lblSTotal.text = "\(self.arrCart.total.cartSubTotal ?? "") \(self.arrCart.currency.uppercased() ?? "")"
                        self.lblDCharge.text = "\(self.arrCart.total.cartDeliveryCharge ?? "") \(self.arrCart.currency.uppercased() ?? "")"
                        
                        self.lblTotal.text = "\(self.arrCart.total.cartTotal ?? "") \(self.arrCart.currency.uppercased() ?? "")"
                        
                        self.isAPIDone = true
                        self.lblCartCount.text = "\(self.arrCart.cartItems.count)"
                        appDelegate?.strTotalCount = "\(self.arrCart.cartItems.count)"
                        self.tblView.reloadData()
                        
                        self.lblNoData.isHidden = true
                        self.tblView.isHidden = false
                        
                        if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCountItem.isHidden = true
                        }
                        else
                        {
                            self.viewCountItem.isHidden = true
                        }
                    }
                    else
                    {
                        self.lblNoData.isHidden = false
                        self.tblView.isHidden = true
                       
                        self.isAPIDone = false
                        self.lblCartCount.text = "0"
                        appDelegate?.strTotalCount = "0"
                        
                        if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCountItem.isHidden = true
                        }
                        else
                        {
                            self.viewCountItem.isHidden = true
                        }
                     
                        self.tblView.reloadData()
                        APIClient.sharedInstance.hideIndicator()
                    }
                    
                }
                else
                {
                    self.lblNoData.isHidden = false
                    self.tblView.isHidden = true
                    
                    self.isAPIDone = false
                    self.lblCartCount.text = "0"
                    appDelegate?.strTotalCount = "0"

                    self.tblView.reloadData()
                    
                    if appDelegate?.strTotalCount == "0"
                    {
                        self.viewCountItem.isHidden = true
                    }
                    else
                    {
                        self.viewCountItem.isHidden = true
                    }
                    
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
                self.lblNoData.isHidden = false
                self.tblView.isHidden = true

                self.tblView.reloadData()
                
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    func callEdittoCartAPI(qty: Int,pro_Id: Int)
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["cart_item_id":"\(pro_Id)","quantity":"\(qty)","device_token":"12323213"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(EDIT_CART, parameters: param) { response, error, statusCode in
            
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
                        //self.setUpMakeToast(msg: message ?? "")
                        self.callGetCartAPI(isShowIndicator: false)
                    }
                    else
                    {
                        self.setUpMakeToast(msg: message ?? "")
                        self.callGetCartAPI(isShowIndicator: false)
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
    
    func callDeleteCartAPI(pro_Id: Int)
    {
        
        let param = ["cart_item_id":"\(pro_Id)"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(DELETE_CART, parameters: param) { response, error, statusCode in
            
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
                       // self.setUpMakeToast(msg: message ?? "")
                        self.callGetCartAPI(isShowIndicator: false)
                    }
                    else
                    {
                        self.setUpMakeToast(msg: message ?? "")
                        self.callGetCartAPI(isShowIndicator: false)
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
    
    func callApplicationSettingAPI()
        {
            
            let param = ["":""]
            
            print(param)
            
            APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderPost(APPLICATION_SETTINGS, parameters: param) { response, error, statusCode in
                
                print("STATUS CODE \(String(describing: statusCode))")
                print("RESPONSE \(String(describing: response))")
                
                if error == nil
                {
                    
                    let status = response?.value(forKey: "status") as? Int
                    let message = response?.value(forKey: "message") as? String
                    
                    if statusCode == 200
                    {
                        if status == 1
                        {
                            if let dicResult = response?.value(forKey: "result") as? NSDictionary
                            {
                                let dicData = TBApplicationSettingsResult(fromDictionary: dicResult)
                                appDelegate?.saveApplicationSettingData(dic: dicData)
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

// MARK: - tblView Delegate & DataSource
extension MyCartVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isAPIDone == true{
            return arrCart.cartItems.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "CartCell") as! CartCell
        
        let dicData = arrCart.cartItems[indexPath.row]

        if Language.shared.isArabic{
            cell.lblName.textAlignment = .right
            cell.lblSupplier.textAlignment = .right
        } else {
            cell.lblName.textAlignment = .left
            cell.lblSupplier.textAlignment = .left
        }
        
        if tableView.numberOfSections > 0 {
            let lastSection = tableView.numberOfSections - 1
            let lastRow = tableView.numberOfRows(inSection: lastSection) - 1

            if lastRow >= 0 {
                let lastIndexPath = IndexPath(row: lastRow, section: lastSection)
                // Example: Scroll to last row
                cell.viewLine.isHidden = true
            } else {
                cell.viewLine.isHidden = false
            }
        }
        
        cell.lblName.text = dicData.name ?? ""
        
        cell.lblWeight.text = "\(dicData.weight ?? 0) \(dicData.weightType ?? "")"

        cell.lblUnitType.text = dicData.unit ?? ""

        cell.lblCart.text = "\(dicData.quantity ?? 0)"
        cell.txtQty.text = "\(dicData.quantity ?? 0)"

        cell.lblSuu.text = "Supplier:".localizeString(string: Language.shared.currentAppLang)

        cell.lblTWeight.text = "Weight:".localizeString(string: Language.shared.currentAppLang)
        
        cell.lblTUnitType.text = "Unit Type:".localizeString(string: Language.shared.currentAppLang)
        
        let price = (Double(dicData.productNetPrice ?? "") ?? 0.0) * (Double(dicData.quantity ?? 0) ?? 0.0)
        
        let formattedNumber = String(format: "%.3f", price)
        cell.lblPrice.text = "\(formattedNumber) \(self.arrCart.currency.uppercased())"

        if dicData.supplier != ""
        {
            cell.lblSupplier.text = dicData.supplier ?? ""
        }
        else
        {
            cell.lblSupplier.text = "null"
        }
        
        
        if dicData.isSupplierDetailShow == 0
        {
            cell.lblSuu.isHidden = true
            cell.viewSuu.isHidden = true
        }
        else
        {
            cell.lblSuu.isHidden = false
            cell.viewSuu.isHidden = false
        }
        
//        cell.lblName.type = .continuous
//        cell.lblName.speed = .duration(12)
//        cell.lblName.trailingBuffer = 10
//        cell.lblName.setNeedsLayout()
// 
//        cell.lblSupplier.type = .continuous
//        cell.lblSupplier.speed = .duration(12)
//        cell.lblSupplier.trailingBuffer = 10
//        cell.lblSupplier.setNeedsLayout()
//
//        cell.lblWeight.type = .continuous
//        cell.lblWeight.speed = .duration(12)
//        cell.lblWeight.trailingBuffer = 10
//        cell.lblWeight.setNeedsLayout()

        if dicData.images.count > 0
        {
            var media_link_url = dicData.images[0].image ?? ""
            media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            cell.imgPic.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
        }

        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(clickedDeleteCart(_ :)), for: .touchUpInside)

        cell.btnAdd.tag = indexPath.row
        cell.btnAdd.addTarget(self, action: #selector(clickedAddQty(_:)), for: .touchUpInside)

        cell.btnRemove.tag = indexPath.row
        cell.btnRemove.addTarget(self, action: #selector(clickedRemoveQty(_:)), for: .touchUpInside)
        
        cell.txtQty.tag = indexPath.row
        cell.txtQty.delegate = self
        cell.txtQty.addTarget(self, action: #selector(searchWorkersAsPerText(_:)), for: .editingChanged)
        
        return cell
    }
    
    @objc func searchWorkersAsPerText(_ textfield:UITextField) {
        
        let dicData = arrCart
        
        let indexPath = NSIndexPath(row: textfield.tag, section: 0)
        
        let cell = self.tblView.cellForRow(at: indexPath as IndexPath) as! CartCell
        
        let objQty = Int(dicData.cartItems[textfield.tag].quantity ?? 0)
        
        let minus_quantity = dicData.cartItems[textfield.tag].minusQuantity ?? 0
        
        let factoryProduct = dicData.cartItems[textfield.tag].factoryProduct ?? 0

        
        var objQty12 = Int(cell.txtQty.text ?? "") ?? 0
        
        let objMul = Double(dicData.cartItems[textfield.tag].price ?? "")! * Double(objQty12)
        
        let formattedNumber = String(format: "%.3f", objMul)
        cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
        
        if factoryProduct == 1
        {
            let dicData = arrCart.cartItems[textfield.tag]
            
            callEdittoCartAPI(qty: objQty12, pro_Id: dicData.cartItemId ?? 0)

        }
        else
        {
            if Double(objQty) < (Double(textfield.text ?? "") ?? 0.0) {
                
                self.setUpMakeToast(msg: "You can add only \(objQty) product(s).")
                
                if objQty == 0 && minus_quantity == 0 {
                    cell.txtQty.text = "0"
                } else {
                   cell.txtQty.text = String(objQty)
                }
                
                let objMul = Double(dicData.cartItems[textfield.tag].price ?? "")! * Double(objQty)
                
                let formattedNumber = String(format: "%.3f", objMul)
                cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
            } else {
                let dicData = arrCart.cartItems[textfield.tag]
                
                callEdittoCartAPI(qty: objQty12, pro_Id: dicData.cartItemId ?? 0)

            }
        }
       
        // Handle when text field editing ends
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func clickedDeleteCart(_ sender: UIButton)
    {
        selectIndex = sender.tag
        
        
        let mainS =  UIStoryboard(name: "Home", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
        vc.cartDeleteDelegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.isRemoveCart = true
        self.present(vc, animated: false)
    }
    
    func onCartDeleteReady(isDelete: Bool) {
        
        if arrCart.cartItems.count > 0
        {
            let dicData = arrCart.cartItems[selectIndex]
            callDeleteCartAPI(pro_Id: dicData.cartItemId ?? 0)

        }
        
    }
    
    
    @objc func clickedAddQty(_  sender: UIButton)
    {
        let dicData = arrCart.cartItems[sender.tag]
        
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        
        let cell = self.tblView.cellForRow(at: indexPath as IndexPath) as! CartCell
        
        var objQty = Int(cell.lblCart.text ?? "") ?? 0
        
        let factoryProduct = dicData.factoryProduct ?? 0
 
        if factoryProduct == 1
        {
            objQty = objQty + 1
            
            cell.lblCart.text = "\(objQty)"
            
            let dicData = arrCart.cartItems[sender.tag]
            
            callEdittoCartAPI(qty: objQty, pro_Id: dicData.cartItemId ?? 0)
        }
        else {
            if dicData.maxQuantity != objQty
            {
                objQty = objQty + 1
                
                cell.lblCart.text = "\(objQty)"
                
                let dicData = arrCart.cartItems[sender.tag]
                
                callEdittoCartAPI(qty: objQty, pro_Id: dicData.cartItemId ?? 0)
            }
        }
 
    }
    
    @objc func clickedRemoveQty(_  sender: UIButton)
    {
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        
        let cell = self.tblView.cellForRow(at: indexPath as IndexPath) as! CartCell
        
        var objQty = Int(cell.lblCart.text ?? "") ?? 0
        
        if objQty != 1
        {
            objQty = objQty - 1
            
            cell.lblCart.text = "\(objQty)"
        }
        
        let dicData = arrCart.cartItems[sender.tag]
        
        callEdittoCartAPI(qty: objQty, pro_Id: dicData.cartItemId ?? 0)
    }
    
}

class CartCell: UITableViewCell
{
    @IBOutlet weak var imgPic: UIImageView!
    @IBOutlet weak var lblName: MarqueeLabel!
    @IBOutlet weak var lblWeight: MarqueeLabel!
    @IBOutlet weak var lblUnitType: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var lblCart: UILabel!
    @IBOutlet weak var lblSupplier: MarqueeLabel!
    @IBOutlet weak var btnDelete: UIButton!
    
    @IBOutlet weak var lblSuu: UILabel!
    
    @IBOutlet weak var viewSuu: UIView!
    
    @IBOutlet weak var lblTWeight: UILabel!
    @IBOutlet weak var lblTUnitType: UILabel!
    
    @IBOutlet weak var txtQty: UITextField!
    @IBOutlet weak var viewLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lblName.type = .continuous
        self.lblName.speed = .duration(15)
        self.lblName.trailingBuffer = 10
        self.lblName.setNeedsLayout()
 
        self.lblSupplier.type = .continuous
        self.lblSupplier.speed = .duration(15)
        self.lblSupplier.trailingBuffer = 10
        self.lblSupplier.setNeedsLayout()

        self.lblWeight.type = .continuous
        self.lblWeight.speed = .duration(15)
        self.lblWeight.trailingBuffer = 10
        self.lblWeight.setNeedsLayout()
        
    }
}
