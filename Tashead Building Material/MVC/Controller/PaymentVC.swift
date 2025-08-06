//
//  PaymentVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 05/06/23.
//

import UIKit
import LGSideMenuController
import DropDown
import ADCountryPicker
import GoogleMaps
import PassKit

class PaymentVC: UIViewController, onUpdateAddress, UITableViewDelegate, UITableViewDataSource, GMSMapViewDelegate, CLLocationManagerDelegate, PKPaymentAuthorizationViewControllerDelegate {
    
    @IBOutlet weak var stackHifd: UIStackView!
    
    @IBOutlet weak var lblKnetAr: UILabel!
    
    @IBOutlet weak var promobottomCont: NSLayoutConstraint! //11
    @IBOutlet weak var lblPromoCodeDisc: UILabel!
    @IBOutlet weak var lblPromoPrice: UILabel!
    
    
    @IBOutlet weak var lblTopContMEss: NSLayoutConstraint! //20
    
    @IBOutlet weak var btnTopRemoveCont: NSLayoutConstraint! //20
    @IBOutlet weak var btnRemoveHieght: NSLayoutConstraint! //40
    
    @IBOutlet weak var btnRemoveBottomcomt: NSLayoutConstraint! //14
    
    @IBOutlet weak var btnApplyRemove: UIButton!
    
    @IBOutlet weak var lblEpressMesg: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var viewEpressDe: UIView!
    @IBOutlet weak var viewDEpressHieghtCont: NSLayoutConstraint!
 
    
    @IBOutlet weak var mapView: GMSMapView!
    
    
    @IBOutlet weak var tblVie: UITableView!
    @IBOutlet weak var mainView_: UIView!
    
    @IBOutlet weak var linkBottomcont: NSLayoutConstraint!
    
    @IBOutlet weak var viewProBottom: NSLayoutConstraint!
    
    @IBOutlet weak var viewPromoHi: NSLayoutConstraint!
    @IBOutlet weak var viewPromoCode: UIView!
    
    @IBOutlet weak var lblCode: UILabel!
    
    @IBOutlet weak var viewCountItem: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var viewMainSendLink: UIView!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtPromoCode: UITextField!
    
    // Select Payment
    
    @IBOutlet weak var imgCOd: UIImageView!
    @IBOutlet weak var imgKnet: UIImageView!
    //  @IBOutlet weak var imgVisa: UIImageView!
    @IBOutlet weak var imgApplePay: UIImageView!
    @IBOutlet weak var imgSendLink: UIImageView!
    
    @IBOutlet weak var lblTMyCart: UILabel!
    @IBOutlet weak var lblTPayWith: UILabel!
    @IBOutlet weak var lblTKey: UILabel!
    @IBOutlet weak var lblTVisa: UILabel!
    @IBOutlet weak var lblTAppl: UILabel!
    @IBOutlet weak var lblTCod: UILabel!
    @IBOutlet weak var lblTSendLink: UILabel!
    @IBOutlet weak var lbltPromoCode: UILabel!
    
    @IBOutlet weak var btnTEditAddress: UIButton!
    @IBOutlet weak var btnTNxt: UIButton!
    @IBOutlet weak var btnTCounrinue: UIButton!
    
    @IBOutlet weak var lblTSubTotal: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblTDeliveyCharge: UILabel!
    @IBOutlet weak var lblDCharge: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblTTotal: UILabel!
    
    @IBOutlet weak var viewMainPayWith: UIView!
    @IBOutlet weak var viewMainKnet: UIView!
    @IBOutlet weak var viewApplePay: UIView!
    @IBOutlet weak var viewCOD: UIView!
    
    @IBOutlet weak var heightTblViewTop: NSLayoutConstraint!
    @IBOutlet weak var heightTblViewBottom: NSLayoutConstraint!
    
    @IBOutlet weak var stackViewMainCredit: UIStackView!
    @IBOutlet weak var heightMainCredit: NSLayoutConstraint!
    
    @IBOutlet weak var lblTUseCredit: UILabel!
    @IBOutlet weak var lblTBalanceUC: UILabel!
    @IBOutlet weak var lblBalanceUC: UILabel!
    
    @IBOutlet weak var lblTYesUC: UILabel!
    @IBOutlet weak var lblTNoUC: UILabel!
    
    @IBOutlet weak var viewMainYes: UIView!
    @IBOutlet weak var viewMainNo: UIView!
    
    @IBOutlet weak var viewLineExpress: UIView!
    @IBOutlet weak var viewLineCredit: UIView!
    @IBOutlet weak var viewMainCredit: UIView!
    @IBOutlet weak var heightViewCrdit: NSLayoutConstraint!
    
    @IBOutlet weak var switchExpressDelivery: UISwitch! {
        didSet {
            switchExpressDelivery.transform = CGAffineTransform(scaleX: 0.75, y: 0.75) // 1.5x taller
        }
    }
    @IBOutlet weak var lblTitleExpressDelivery: UILabel! {
        didSet {
            lblTitleExpressDelivery.text = "Express Delivery".localizeString(string: Language.shared.currentAppLang)
        }
    }
    @IBOutlet weak var viewMainSelectTime: UIView! {
        didSet {
            viewMainSelectTime.isHidden = appDelegate?.delivery_slot_allowed == 1 ? false : true
        }
    }
    @IBOutlet weak var lblTitleOrder: UILabel! {
        didSet {
            
            let dateString = AppManager.shared.delivery_date
            let time = AppManager.shared.booked_slot_time.replacingOccurrences(of: " To ", with: " - ")
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            if let date = formatter.date(from: dateString) {
                formatter.dateFormat = "dd MMMM yyyy"
                let formattedDate = formatter.string(from: date)
                print(formattedDate)  // Output: 29 July 2025
               
                var setTitle = ""
                if Language.shared.isArabic {
                    setTitle = "سيتم توصيل طلبك يوم \n\(formattedDate) مابين \n\(time)"
                } else {
                    setTitle = "Your order will be delivered on \n\(formattedDate) between  \n\(time)."
                }
                
                lblTitleOrder.text = setTitle
            }
        }
    }
    @IBOutlet weak var view3Main: UIStackView! {
        didSet {
            view3Main.isHidden = appDelegate?.delivery_slot_allowed == 1 ? false : true
        }
    }
    @IBOutlet weak var viewLine3: UIView! {
        didSet {
            viewLine3.isHidden = appDelegate?.delivery_slot_allowed == 1 ? false : true
        }
    }
    @IBOutlet weak var btnChangeTime: UIButton! {
        didSet {
            btnChangeTime.setTitle("Change".localizeString(string: Language.shared.currentAppLang), for: .normal)
        }
    }
    @IBOutlet weak var viewLineTime: UIView! {
        didSet {
            viewLineTime.isHidden = appDelegate?.delivery_slot_allowed == 1 ? true : true
        }
    }
    @IBOutlet weak var viewMainExpressOn: UIView!
    @IBOutlet weak var lblYourOrder: UILabel!
    
    @IBOutlet weak var viewMainCommission: UIView!
    @IBOutlet weak var lblTUseCommission: UILabel! {
        didSet {
            lblTUseCommission.text = "Use Commission?".localizeString(string: Language.shared.currentAppLang)
        }
    }
    @IBOutlet weak var lblTAvailable: UILabel! {
        didSet {
            lblTAvailable.text = "Available :".localizeString(string: Language.shared.currentAppLang)
        }
    }
    @IBOutlet weak var lblCommissonAmount: UILabel!
    @IBOutlet weak var lbltYesCommission: UILabel! {
        didSet {
            lbltYesCommission.text = "Yes".localizeString(string: Language.shared.currentAppLang)
        }
    }
    @IBOutlet weak var lblTNoCommission: UILabel! {
        didSet {
            lblTNoCommission.text = "No".localizeString(string: Language.shared.currentAppLang)
        }
    }
    @IBOutlet weak var viewYesCommission: UIView!
    @IBOutlet weak var viewNoCommission: UIView!
    @IBOutlet weak var stackViewCommision: UIStackView!
    @IBOutlet weak var heightCommission: NSLayoutConstraint!
    
    @IBOutlet weak var viewMainLoyaltyPoints: UIView!
    @IBOutlet weak var viewYesLoyalty: UIView!
    @IBOutlet weak var viewNoLoyalty: UIView!
    
    @IBOutlet weak var lblYesLoyalty: UILabel! {
        didSet {
            lblYesLoyalty.text = "Yes".localizeString(string: Language.shared.currentAppLang)
        }
    }
    @IBOutlet weak var lblNoLoyalty: UILabel! {
        didSet {
            lblNoLoyalty.text = "No".localizeString(string: Language.shared.currentAppLang)
        }
    }
    
    @IBOutlet weak var stackViewLaoyatyList: UIStackView!
//    @IBOutlet weak var collectionViewLoayltyPoint: UICollectionView! {
//        didSet {
//            collectionViewLoayltyPoint.delegate = self
//            collectionViewLoayltyPoint.dataSource = self
//        }
//    }
    @IBOutlet weak var lblSelectLoayltyPoin: UILabel!
//    @IBOutlet weak var heightCollectionLayalty: NSLayoutConstraint!
    
    @IBOutlet weak var tblViewLoyaltyCoupons: UITableView! {
        didSet {
            if #available(iOS 15.0, *) {
                tblViewLoyaltyCoupons.sectionHeaderTopPadding = 0
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    @IBOutlet weak var lblAvailableLoyaltyPoint: UILabel!
    
    
    var arrFactoryProduct: [TBCartListCartItem] = [TBCartListCartItem]()
    var arrNonFactoryProduct: [TBCartListCartItem] = [TBCartListCartItem]()
    
    var objCart = TBCartListResult()
    
    var arrAddressList : [TBAddressResult] = [TBAddressResult]()
    
    var dicLoyaltyCoupons = TBLoyaltyCouponsResult()
    
    var payment_method = ""
    
    var dropDown = DropDown()
    var arrCountryCode = ["+965","+91"]
    
    var locationManager = CLLocationManager()
    var objLat = ""
    var objLon = ""
    
    var is_used_credit: Bool = false
    var is_commission_used: Bool = false
    var is_loaylty = false
    
    var isApiCall = false
    var selectedIndex = -1
    
    var walletBalance = ""
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setDropDown()
        
        callComminsonAPI(isShowIndicator: false)

        tblVie.delegate = self
        tblVie.dataSource = self
        tblVie.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        tblViewLoyaltyCoupons.delegate = self
        tblViewLoyaltyCoupons.dataSource = self
        tblViewLoyaltyCoupons.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        tblViewLoyaltyCoupons.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        lblTUseCredit.text = "Use Credit?".localizeString(string: Language.shared.currentAppLang)
        lblTBalanceUC.text = "Available limit:".localizeString(string: Language.shared.currentAppLang)
        lblTYesUC.text = "Yes".localizeString(string: Language.shared.currentAppLang)
        lblTNoUC.text = "No".localizeString(string: Language.shared.currentAppLang)
                
        lblKnetAr.text = "Knet".localizeString(string: Language.shared.currentAppLang)
        
        lblTSubTotal.text = "Subtotal:".localizeString(string: Language.shared.currentAppLang)
        lblTTotal.text = "Total:".localizeString(string: Language.shared.currentAppLang)
        
        lblPromoCodeDisc.text = "Promo Code Discount:".localizeString(string: Language.shared.currentAppLang)
        
        lblTMyCart.text = "CHECKOUT".localizeString(string: Language.shared.currentAppLang)
        //lblDeliverd.text = "Your order will be delivered".localizeString(string: Language.shared.currentAppLang)
        lblTPayWith.text = "Pay with".localizeString(string: Language.shared.currentAppLang)
        lblTKey.text = "You will be forwarded to KNET to complete this transaction.".localizeString(string: Language.shared.currentAppLang)
        //   lblTVisa.text = "Visa / Mastercard".localizeString(string: Language.shared.currentAppLang)
        lblTAppl.text = "Apple pay".localizeString(string: Language.shared.currentAppLang)
        lblTCod.text = "Cash on Deliverey".localizeString(string: Language.shared.currentAppLang)
        lblTSendLink.text = "Send a link".localizeString(string: Language.shared.currentAppLang)
        lbltPromoCode.text = "Promo code".localizeString(string: Language.shared.currentAppLang)
        
        txtMobileNo.placeholder = "Mobile Number".localizeString(string: Language.shared.currentAppLang)
        txtPromoCode.placeholder = "Promo code".localizeString(string: Language.shared.currentAppLang)
        
        btnTEditAddress.setTitle("Change".localizeString(string: Language.shared.currentAppLang), for: .normal)
        btnTNxt.setTitle("Pay now".localizeString(string: Language.shared.currentAppLang), for: .normal)
        btnTCounrinue.setTitle("Continue Shopping".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        if Language.shared.currentAppLang == "en" {
            lblAddress.textAlignment = .left
        }
        else {
            lblAddress.textAlignment = .right
        }
        
        imgKnet.image = UIImage(named: "ic_UnCheckbox")
        //  imgVisa.image = UIImage(named: "ic_UnCheckbox")
        imgApplePay.image = UIImage(named: "ic_UnCheckbox")
        imgSendLink.image = UIImage(named: "ic_UnCheckbox")
        imgCOd.image = UIImage(named: "ic_UnCheckbox")
        
        DispatchQueue.main.async {
            self.mapView.overrideUserInterfaceStyle = .dark
            self.mapView.delegate = self

            if CLLocationManager.locationServicesEnabled(){
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.distanceFilter = 10
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.startUpdatingLocation()
            }
        }
        
        setupApplePayButton()
        
        if appDelegate?.dicCurrentLoginUser.user_type_text == "wholesaler" {
            // wallet API calling
            viewMainCredit.isHidden = false
            viewLineCredit.isHidden = false
            heightViewCrdit.constant = 100
            
            viewMainCommission.isHidden = false
            
            callGetWalletAPI()
        } else {
            viewMainCredit.isHidden = true
            viewLineCredit.isHidden = true
            heightViewCrdit.constant = 0
            
            if appDelegate?.getApplicationSettingData().businessrules.is_loyalty_allowed == 1 {
                viewMainCommission.isHidden = true
                viewMainLoyaltyPoints.isHidden = false
                callLoyaltyCouponsAPI()
            } else {
                viewMainCommission.isHidden = true
                viewMainLoyaltyPoints.isHidden = true
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if let newValue = change?[.newKey] as? CGSize,
               let tableView = object as? UITableView {
                
                if tableView === self.tblVie {
                    self.heightTblViewTop.constant = newValue.height
                } else if tableView === self.tblViewLoyaltyCoupons {
                    self.heightTblViewBottom.constant = newValue.height
                }
            }
        }
    }
    
    func setPaymentOption() {
        if let objAddress = self.objCart.address {
            let express_delivery_switch_address = objAddress.area.expressDeliverySwitch
            let knet_switch_address = objAddress.area.knetSwitch
            let apple_pay_address = objAddress.area.applePay
            let cod_switch_address = objAddress.area.codSwitch
            let send_payment_link_address = objAddress.area.sendPaymentLink
            
            let express_delivery_switch = appDelegate?.getApplicationSettingData().businessrules.expressDeliverySwitch
            let knet_switch = appDelegate?.getApplicationSettingData().businessrules.knetSwitch
            let apple_pay = appDelegate?.getApplicationSettingData().businessrules.applePay
            let cod_switch = appDelegate?.getApplicationSettingData().businessrules.codSwitch
            let send_payment_link = appDelegate?.getApplicationSettingData().businessrules.sendPaymentLink
             
            viewEpressDe.isHidden = express_delivery_switch_address == 1 && express_delivery_switch == 1 ? false : true
            viewLineExpress.isHidden = express_delivery_switch_address == 1 && express_delivery_switch == 1 ? false : true
            viewMainKnet.isHidden = knet_switch_address == 1 && knet_switch == 1 ? false : true
            viewApplePay.isHidden = apple_pay_address == 1 && apple_pay == 1 ? false : true
            viewCOD.isHidden = cod_switch_address == 1 && cod_switch == 1 ? false : true
            viewMainSendLink.isHidden = send_payment_link_address == 1 && send_payment_link == 1 ? false : true
        }
    }
    
    func openChooseDelivery() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let vc = ChooseDeliveryAddress()
            vc.modalPresentationStyle = .overFullScreen
            vc.delegateAddress = self
            let navController = UINavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .overFullScreen
            vc.navigationController?.navigationBar.isHidden = true
            self.present(navController, animated: false)
        }
    }
    
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error" + error.description)
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        //        self.objLat = String(marker.position.latitude)
        //        self.objLon = String(marker.position.longitude)
        //    self.perform(#selector(self.updateAddress), with: nil, afterDelay: 1.0)
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        let location = locations.last
//        
//        let camera = GMSCameraPosition.camera(withLatitude: location?.coordinate.latitude ?? 0.0, longitude: location?.coordinate.longitude ?? 0.0, zoom: 10.0)
//        self.mapView?.camera = camera
//        
//        let annotion = GMSMarker()
//        annotion.position = CLLocationCoordinate2D(latitude: location?.coordinate.latitude ?? 0.0, longitude: location?.coordinate.longitude ?? 0.0)
//        annotion.icon = self.imageWithImage(image: UIImage(named: "maps-and-flags")!, scaledToSize: CGSize(width: 30, height: 35))
//        annotion.map = self.mapView
//        
//        //Finally stop updating location otherwise it will come again and again in this delegate
//        self.locationManager.stopUpdatingLocation()
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func updateAddress(isUpdate: Bool, id: Int) {
        
        
        if let objAddress = appDelegate?.getUserSelectedAddress()
        {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                let _ = objAddress.address ?? ""
                let block = objAddress.block ?? ""
                let street = objAddress.street ?? ""
                let _ = objAddress.avenue ?? ""
                let building_number = objAddress.buildingNumber ?? ""
                let _ = objAddress.floor ?? ""
                let _ = objAddress.apartment ?? ""
                
                self.lblName.text = objAddress.areaName ?? ""
                
    //            self.lblAddress.text = "Block \(block),st. \(street),Building \(building_number)"
                
                let Block_lan = "Block".localizeString(string: Language.shared.currentAppLang)
                let Street_lan = "Street".localizeString(string: Language.shared.currentAppLang)
                let Building_lan = "Building".localizeString(string: Language.shared.currentAppLang)
                
                self.lblAddress.text = "\(Block_lan) \(block),\(Street_lan) \(street),\(Building_lan) \(building_number)"
                
                self.lblType.text = objAddress.address ?? ""
                
                let camera = GMSCameraPosition.camera(withLatitude: Double(objAddress.latitude ?? "") ?? 0.0, longitude: Double(objAddress.longitude ?? "") ?? 0.0, zoom: 15.0)
                self.mapView?.camera = camera
                
                let annotion = GMSMarker()
                annotion.position = CLLocationCoordinate2D(latitude: Double(objAddress.latitude ?? "") ?? 0.0, longitude: Double(objAddress.longitude ?? "") ?? 0.0)
                annotion.icon = self.imageWithImage(image: UIImage(named: "maps-and-flags")!, scaledToSize: CGSize(width: 30, height: 35))
                annotion.map = self.mapView
                
                self.callGetCartAPI()
            }
        }
        else
        {
            callGetAddressAPI()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
            
        self.callGetCartAPI()
        
        
        
        if let objAddress = appDelegate?.getUserSelectedAddress()
        {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                let _ = objAddress.address ?? ""
                let block = objAddress.block ?? ""
                let street = objAddress.street ?? ""
                let _ = objAddress.avenue ?? ""
                let building_number = objAddress.buildingNumber ?? ""
                let _ = objAddress.floor ?? ""
                let _ = objAddress.apartment ?? ""
                
                self.lblName.text = objAddress.areaName ?? ""
                
    //            self.lblAddress.text = "Block \(block),st. \(street),Building \(building_number)"
                
                let Block_lan = "Block".localizeString(string: Language.shared.currentAppLang)
                let Street_lan = "Street".localizeString(string: Language.shared.currentAppLang)
                let Building_lan = "Building".localizeString(string: Language.shared.currentAppLang)
                
                self.lblAddress.text = "\(Block_lan) \(block),\(Street_lan) \(street),\(Building_lan) \(building_number)"
                
                self.lblType.text = objAddress.address ?? ""
                
                let camera = GMSCameraPosition.camera(withLatitude: Double(objAddress.latitude ?? "") ?? 0.0, longitude: Double(objAddress.longitude ?? "") ?? 0.0, zoom: 15.0)
                self.mapView?.camera = camera
                
                let annotion = GMSMarker()
                annotion.position = CLLocationCoordinate2D(latitude: Double(objAddress.latitude ?? "") ?? 0.0, longitude: Double(objAddress.longitude ?? "") ?? 0.0)
                annotion.icon = self.imageWithImage(image: UIImage(named: "maps-and-flags")!, scaledToSize: CGSize(width: 30, height: 35))
                annotion.map = self.mapView
            }
            
        }
        else
        {
            callGetAddressAPI()
        }
        
        if Language.shared.isArabic {
            imgBack.image = UIImage(named: "Back_Ar")
        }
        else
        {
            imgBack.image = UIImage(named: "Back")
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if arrNonFactoryProduct.count > 0 && arrFactoryProduct.count > 0
        {
            return 2
        }
        else if arrNonFactoryProduct.count > 0 || arrFactoryProduct.count > 0
        {
            return 1
        }
        else if tableView == tblViewLoyaltyCoupons {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblViewLoyaltyCoupons {
            if isApiCall == true {
                return dicLoyaltyCoupons.coupons.count
            }
            return 0
        } else {
            if arrNonFactoryProduct.count > 0 && arrFactoryProduct.count > 0
            {
                if section == 0
                {
                    return arrNonFactoryProduct.count
                }
                else
                {
                    return arrFactoryProduct.count
                }
            }
            else if arrNonFactoryProduct.count > 0 || arrFactoryProduct.count > 0
            {
                if arrNonFactoryProduct.count > 0
                {
                    return arrNonFactoryProduct.count
                }
                else
                {
                    return arrFactoryProduct.count
                }
            }
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblVie {
            if arrNonFactoryProduct.count > 0 && arrFactoryProduct.count > 0
            {
                if indexPath.section == 0
                {
                    let cell = tblVie.dequeueReusableCell(withIdentifier: "checkOutListCell") as! checkOutListCell
                    
                    let dicProduct = arrNonFactoryProduct[indexPath.row]
                    
                    cell.lblName.text = "\(indexPath.row+1). \(dicProduct.name ?? "")"
                    
                    return cell
                }
                else
                {
                    let cell = tblVie.dequeueReusableCell(withIdentifier: "checkOutListCell") as! checkOutListCell
                    
                    let dicProduct = arrFactoryProduct[indexPath.row]
                    
                    cell.lblName.text = "\(indexPath.row+1). \(dicProduct.name ?? "")"
                    
                    return cell
                    
                }
            }
            else
            {
                if arrNonFactoryProduct.count > 0
                {
                    let cell = tblVie.dequeueReusableCell(withIdentifier: "checkOutListCell") as! checkOutListCell
                    
                    let dicProduct = arrNonFactoryProduct[indexPath.row]
                    
                    cell.lblName.text = "\(indexPath.row+1). \(dicProduct.name ?? "")"
                    
                    return cell
                }
                else
                {
                    let cell = tblVie.dequeueReusableCell(withIdentifier: "checkOutListCell") as! checkOutListCell
                    
                    let dicProduct = arrFactoryProduct[indexPath.row]
                    
                    cell.lblName.text = "\(indexPath.row+1). \(dicProduct.name ?? "")"
                    
                    return cell
                }
            }
            
        } else if tableView == tblViewLoyaltyCoupons {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoayltyCouponCell", for: indexPath) as! LoayltyCouponCell
            
            cell.imgSelect.image = selectedIndex == indexPath.row ? UIImage(named: "ic_Checkbox") : UIImage(named: "ic_UnCheckbox")
            
            if isApiCall == true {
                let dicData = dicLoyaltyCoupons.coupons[indexPath.row]
                cell.lblKD.text = "\(dicData.amount ?? "") KD"
                cell.lblPoint.text = "\(dicData.point ?? 0) Points"
                
                var media_link_url = "\(dicData.image ?? "")"
                media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                cell.imgCoupon.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
            }
            
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblViewLoyaltyCoupons {
            let dicData = dicLoyaltyCoupons.coupons[indexPath.row]
            
            let amount = Double(dicData.amount) ?? 0.0
            let cartTotal = Double(objCart.total.cartTotal) ?? 0.0
            let pointCoupon = Double(dicLoyaltyCoupons.point) ?? 0.0
            let point = Double(dicData.point)
            
            if amount <= cartTotal && pointCoupon >= point {
                selectedIndex = indexPath.row
            }
            
            DispatchQueue.main.async {
                self.tblViewLoyaltyCoupons.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
                self.tblViewLoyaltyCoupons.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView == tblVie {
            let headerView = Bundle.main.loadNibNamed("CheckOutHeaderView", owner: self, options: [:])?.first as! CheckOutHeaderView
            
            // headerView.lblOrder.text = "Your order will be delivered".localizeString(string: Language.shared.currentAppLang)
            
            if arrNonFactoryProduct.count > 0 && arrFactoryProduct.count > 0
            {
                if section == 0
                {
                    headerView.lineView.isHidden = true
                    
                    //  headerView.lblOrder.isHidden = false
                    //                headerView.OrderTopCont.constant = 20
                    //                headerView.OrdeBottomCont.constant = 15
                    headerView.lblName.text = self.objCart.nonFactoryMessage ?? ""
                }
                else
                {
                    headerView.lineView.isHidden = false

                    headerView.lblName.text = self.objCart.factoryMessage ?? ""
                    // headerView.lblOrder.isHidden = true
                    //                headerView.OrderTopCont.constant = 0
                    //                headerView.OrdeBottomCont.constant = 0
                }
            }
            else if arrNonFactoryProduct.count > 0 || arrFactoryProduct.count > 0
            {
                //  headerView.lblOrder.isHidden = false
                //            headerView.OrderTopCont.constant = 20
                //            headerView.OrdeBottomCont.constant = 15
                
                if arrNonFactoryProduct.count > 0
                {
                    headerView.lblName.text = self.objCart.nonFactoryMessage ?? ""
                }
                else
                {
                    headerView.lblName.text = self.objCart.factoryMessage ?? ""
                }
            }
            else
            {
                //  headerView.lblOrder.isHidden = true
                //            headerView.OrderTopCont.constant = 0
                //            headerView.OrdeBottomCont.constant = 0
            }
            
            return headerView
        } else {
            return nil
        }
            
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tblViewLoyaltyCoupons {
            return 0.5
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    
    @IBAction func clickedRemovedDel(_ sender: Any) {
        
        if self.objCart.is_express_delivery == 1
        {
            self.callModifytoCartAPI(is_express_delivery: "0", cart_id: "\(self.objCart.cartId ?? 0)")
        }
        else
        {
            self.callModifytoCartAPI(is_express_delivery: "1", cart_id: "\(self.objCart.cartId ?? 0)")
        }
        
    }
    
    @IBAction func clickedManu(_ sender: Any) {
        if Language.shared.isArabic {
            self.sideMenuController?.showRightView(animated: true, completion: nil)
        }
        else
        {
            self.sideMenuController?.showLeftView(animated: true, completion: nil)
        }
    }
    @IBAction func clickedBack(_ sender: Any) {
        
        callRemoveApplyCodeAPI()
        
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func clickedCode(_ sender: Any) {
        //  dropDown.show()
        
        //        let picker = ADCountryPicker()
        //        // delegate
        //        picker.delegate = self
        //
        //        // Display calling codes
        //        picker.showCallingCodes = true
        //
        //        // or closure
        //        picker.didSelectCountryClosure = { name, code in
        //            _ = picker.navigationController?.popToRootViewController(animated: true)
        //            print(code)
        //        }
        //
        //        //        Use this below code to present the picker
        //
        //        let pickerNavigationController = UINavigationController(rootViewController: picker)
        //        self.present(pickerNavigationController, animated: true, completion: nil)
        
    }
    
    @IBAction func clickedYesUC(_ sender: UIButton) {
        if sender.tag == 1 {
            is_used_credit = true
            
            viewMainYes.backgroundColor = UIColor(hexString: "#F7C491")
            viewMainNo.backgroundColor = .clear
            
            viewMainYes.borderColor = .clear
            viewMainNo.borderColor = UIColor(hexString: "#AEAEB2")
            
            viewCOD.isHidden = true
            viewMainSendLink.isHidden = true
            viewApplePay.isHidden = true

            imgKnet.image = UIImage(named: "ic_UnCheckbox")
            imgApplePay.image = UIImage(named: "ic_UnCheckbox")
            imgSendLink.image = UIImage(named: "ic_UnCheckbox")
            imgCOd.image = UIImage(named: "ic_UnCheckbox")
        } else if sender.tag == 2 {
            is_commission_used = true
            
            viewYesCommission.backgroundColor = UIColor(hexString: "#F7C491")
            viewNoCommission.backgroundColor = .clear
            
            viewYesCommission.borderColor = .clear
            viewNoCommission.borderColor = UIColor(hexString: "#AEAEB2")
            
            /*viewCOD.isHidden = true
            viewMainSendLink.isHidden = true
            viewApplePay.isHidden = true*/

            imgKnet.image = UIImage(named: "ic_UnCheckbox")
            imgApplePay.image = UIImage(named: "ic_UnCheckbox")
            imgSendLink.image = UIImage(named: "ic_UnCheckbox")
            imgCOd.image = UIImage(named: "ic_UnCheckbox")
        } else {
            is_loaylty = true
            viewYesLoyalty.backgroundColor = UIColor(hexString: "#F7C491")
            viewNoLoyalty.backgroundColor = .clear
            
            viewYesLoyalty.borderColor = .clear
            viewNoLoyalty.borderColor = UIColor(hexString: "#AEAEB2")
            
            stackViewLaoyatyList.isHidden = false
            
            viewApplePay.isHidden = true
            viewMainSendLink.isHidden = true
        }
        
    }
    
    @IBAction func clickedNoUC(_ sender: UIButton) {
        if sender.tag == 1 {
            is_used_credit = false
            
            viewMainNo.backgroundColor = UIColor(hexString: "#F7C491")
            viewMainYes.backgroundColor = .clear
            
            viewMainNo.borderColor = .clear
            viewMainYes.borderColor = UIColor(hexString: "#AEAEB2")
            
            setPaymentOption()
        } else if sender.tag == 2 {
            is_commission_used = false
            
            viewNoCommission.backgroundColor = UIColor(hexString: "#F7C491")
            viewYesCommission.backgroundColor = .clear
            
            viewNoCommission.borderColor = .clear
            viewYesCommission.borderColor = UIColor(hexString: "#AEAEB2")
            
//            setPaymentOption()
        } else {
            is_loaylty = false
            
            viewNoLoyalty.backgroundColor = UIColor(hexString: "#F7C491")
            viewYesLoyalty.backgroundColor = .clear
            
            viewNoLoyalty.borderColor = .clear
            viewYesLoyalty.borderColor = UIColor(hexString: "#AEAEB2")
            
            selectedIndex = -1
            tblViewLoyaltyCoupons.reloadData()
            
            stackViewLaoyatyList.isHidden = true
            
            viewApplePay.isHidden = false
            viewMainSendLink.isHidden = false
        }
        
    }
    
    func setDropDown()
    {
        
        dropDown.dataSource = arrCountryCode
        dropDown.anchorView = lblCode
        dropDown.direction = .bottom
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.lblCode.text = item
        }
        
        dropDown.bottomOffset = CGPoint(x: 0, y: lblCode.bounds.height)
        dropDown.topOffset = CGPoint(x: 0, y: -lblCode.bounds.height)
        dropDown.dismissMode = .onTap
        dropDown.textColor = UIColor.black
        dropDown.backgroundColor = UIColor(red: 255/255, green:  255/255, blue:  255/255, alpha: 1)
        dropDown.selectionBackgroundColor = UIColor.clear
        
        dropDown.reloadAllComponents()
    }
    
    @IBAction func clickedCart(_ sender: Any) {
    }
    @IBAction func clickedEditDate(_ sender: Any) {
    }
    @IBAction func clickedEditAddress(_ sender: Any) {
        openChooseDelivery()
        
        /*let mainS = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "AddressVC") as! AddressVC
        vc.isGotoPayment = true
        vc.isAddProfileAddress = false
        vc.isUpdateProfile = false
        vc.objCart = self.objCart
        vc.delegateAddress = self
        let homeNavigation = UINavigationController(rootViewController: vc)
        homeNavigation.navigationBar.isHidden = true
        homeNavigation.modalPresentationStyle = .overFullScreen
        self.present(homeNavigation, animated: false)*/
    }
    
    // Payment Action
    
    @IBAction func clickedKnet(_ sender: Any) {
        
        let walletBalance = Double(walletBalance) ?? 0
        let totalAmount = Double(objCart.total.cartTotal ?? "") ?? 0

        if is_used_credit == true {
            if totalAmount < walletBalance {
                self.setUpMakeToast(msg: "Your credit fully covers your order. Other payment methods are not required.")
            } else {
                mainView_.frame = CGRect(x: 0, y: 0,width: self.view.frame.width, height: 930 - 60 + 160 + 15 + 30)
                tblVie.reloadData()
                
                payment_method = "knet"
                imgKnet.image = UIImage(named: "ic_Checkbox")
                //  imgVisa.image = UIImage(named: "ic_UnCheckbox")
                imgApplePay.image = UIImage(named: "ic_UnCheckbox")
                imgSendLink.image = UIImage(named: "ic_UnCheckbox")
                imgCOd.image = UIImage(named: "ic_UnCheckbox")
                
                linkBottomcont.constant = 0
                
                viewProBottom.constant = 0
                viewPromoHi.constant = 0
                viewPromoCode.isHidden = true
            }
        } else {
            mainView_.frame = CGRect(x: 0, y: 0,width: self.view.frame.width, height: 930 - 60 + 160 + 15 + 30)
            tblVie.reloadData()
            
            payment_method = "knet"
            imgKnet.image = UIImage(named: "ic_Checkbox")
            //  imgVisa.image = UIImage(named: "ic_UnCheckbox")
            imgApplePay.image = UIImage(named: "ic_UnCheckbox")
            imgSendLink.image = UIImage(named: "ic_UnCheckbox")
            imgCOd.image = UIImage(named: "ic_UnCheckbox")
            
            linkBottomcont.constant = 0
            
            viewProBottom.constant = 0
            viewPromoHi.constant = 0
            viewPromoCode.isHidden = true
        }
    }
    @IBAction func clickedVisa(_ sender: Any) {
        //        imgKnet.image = UIImage(named: "ic_UnCheckbox")
        //        imgVisa.image = UIImage(named: "ic_Checkbox")
        //        imgApplePay.image = UIImage(named: "ic_UnCheckbox")
        //        imgSendLink.image = UIImage(named: "ic_UnCheckbox")
        //        imgCOd.image = UIImage(named: "ic_UnCheckbox")
        
    }
    
    @IBAction func clickedCOD(_ sender: Any) {
        
        payment_method = "cod"
        imgKnet.image = UIImage(named: "ic_UnCheckbox")
        //  imgVisa.image = UIImage(named: "ic_UnCheckbox")
        imgApplePay.image = UIImage(named: "ic_UnCheckbox")
        imgSendLink.image = UIImage(named: "ic_UnCheckbox")
        imgCOd.image = UIImage(named: "ic_Checkbox")
        
        linkBottomcont.constant = 0
        
        viewProBottom.constant = 0
        viewPromoHi.constant = 0
        viewPromoCode.isHidden = true
        
        mainView_.frame = CGRect(x: 0, y: 0,width: self.view.frame.width, height: 930 - 60 + 160 + 15 + 40)
        tblVie.reloadData()
        
    }
    
    @IBAction func clickedApplePay(_ sender: Any) {
        let walletBalance = Double(walletBalance) ?? 0
        let totalAmount = Double(objCart.total.cartTotal ?? "") ?? 0

        if is_used_credit == true {
            if totalAmount < walletBalance {
                self.setUpMakeToast(msg: "Your credit fully covers your order. Other payment methods are not required.")
            } else {
                payment_method = "applePay"
                imgKnet.image = UIImage(named: "ic_UnCheckbox")
                imgApplePay.image = UIImage(named: "ic_Checkbox")
                imgSendLink.image = UIImage(named: "ic_UnCheckbox")
                imgCOd.image = UIImage(named: "ic_UnCheckbox")
            }
        } else {
            payment_method = "applePay"
            imgKnet.image = UIImage(named: "ic_UnCheckbox")
            imgApplePay.image = UIImage(named: "ic_Checkbox")
            imgSendLink.image = UIImage(named: "ic_UnCheckbox")
            imgCOd.image = UIImage(named: "ic_UnCheckbox")
        }
//        startApplePayPayment()
    }
    @IBAction func tapSwitchExpress(_ sender: UISwitch) {
        if sender.isOn {
            self.callModifytoCartAPI(is_express_delivery: "1", cart_id: "\(self.objCart.cartId ?? 0)")
        } else {
            self.callModifytoCartAPI(is_express_delivery: "0", cart_id: "\(self.objCart.cartId ?? 0)")
        }
        
    }
    @IBAction func clickedChangeTime(_ sender: Any) {
        let controllers = self.navigationController?.viewControllers
        for vc in controllers! {
            if vc is SelectDeliveryTimeVC {
                _ = self.navigationController?.popToViewController(vc as! SelectDeliveryTimeVC, animated: true)
                
            }
        }
    }
    
    func setupApplePayButton() {
       

//        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentRequest.supportedNetworks) {
//            let applePayButton = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
//            applePayButton.addTarget(self, action: #selector(startApplePayPayment), for: .touchUpInside)
//            // Add the applePayButton to your view
//        }
    }

    @objc func startApplePayPayment() {
        let paymentRequest = PKPaymentRequest()
        paymentRequest.merchantIdentifier = "merchant.com.SI.Tashead"
        paymentRequest.supportedNetworks = [.visa, .masterCard]
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.countryCode = "KW"
        paymentRequest.currencyCode = "KWD"
        paymentRequest.paymentSummaryItems = [
            PKPaymentSummaryItem(label: "Product Name", amount: NSDecimalNumber(string: "1.00"))
        ]
        
        // Configure paymentRequest as above
        let paymentController = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        present(paymentController!, animated: true, completion: nil)
    }
    
    private func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,
                                                didAuthorizePayment payment: PKPayment,
                                                completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
            // Send payment.token.paymentData to your backend server
            // The server should forward the payment to Knet for processing
            processPayment(payment: payment) { success in
                if success {
                    completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
                } else {
                    completion(PKPaymentAuthorizationResult(status: .failure, errors: nil))
                }
            }
        }

        func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
            controller.dismiss(animated: true, completion: nil)
        }
    
    func processPayment(payment: PKPayment, completion: @escaping (Bool) -> Void) {
        // Convert payment token to your required format and send to backend server
        // Backend handles Knet integration
        // Call completion(true) if payment is successful
    }
    
    @IBAction func clickedApply(_ sender: Any) {
        
        if self.txtPromoCode.text == ""
        {
            self.setUpMakeToast(msg: "Please enter promo code".localizeString(string: Language.shared.currentAppLang))
        }
        else
        {
            callApplyCodeAPI(promocode: self.txtPromoCode.text ?? "")
            
        }
    }
    
    func callApplyCodeAPI(promocode: String)
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["promocode":promocode,"cart_id":"\(self.objCart.cartId ?? 0)"]
        
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
                        
                        self.callGetCartAPI()
                        
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
    
    func callRemoveApplyCodeAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["cart_id":"\(self.objCart.cartId ?? 0)"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(PROMOCODE_REMOVE, parameters: param) { response, error, statusCode in
            
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
//                        self.txtPromoCode.text = ""
//                        self.txtPromoCode.isUserInteractionEnabled = true
//                        self.txtPromoCode.alpha = 1
//                        self.btnApplyRemove.setTitle("Redeem".localizeString(string: Language.shared.currentAppLang), for: .normal)
//                        
//                        self.callGetCartAPI()
                        
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
    
    @IBAction func clickedSendLink(_ sender: Any) {
        payment_method = "link"
        imgKnet.image = UIImage(named: "ic_UnCheckbox")
        //    imgVisa.image = UIImage(named: "ic_UnCheckbox")
        imgApplePay.image = UIImage(named: "ic_UnCheckbox")
        imgSendLink.image = UIImage(named: "ic_Checkbox")
        imgCOd.image = UIImage(named: "ic_UnCheckbox")
        
        linkBottomcont.constant = 10
        
        viewProBottom.constant = 0
        viewPromoHi.constant = 45
        viewPromoCode.isHidden = false
        
        mainView_.frame = CGRect(x: 0, y: 0,width: self.view.frame.width, height: 930+160+15+10+30)
        tblVie.reloadData()
    }
    
    
    @IBAction func clickedContinue(_ sender: Any) {
        
        callRemoveApplyCodeAPI()
        
        appDelegate?.setUpHome()
    }
    
    @IBAction func clickedNex(_ sender: UIButton) {
 
        //let objAddress = self.objCart.address
        
        let objAddress = appDelegate?.getUserSelectedAddress()
        
        let minimum_order = Double(objAddress?.area.minimumOrder ?? "") ?? 0.0
        
        var objTotalAmount = self.lblSubTotal.text?.replacingOccurrences(of: " KD", with: "") ?? ""
        objTotalAmount = objTotalAmount.replacingOccurrences(of: ",", with: "")
        let totalAmount = Double(objTotalAmount) ?? 0.0
 
        let walletBalance = Double(walletBalance) ?? 0
        let couponBalance = Double(dicLoyaltyCoupons.point) ?? 0
        let totalAmount11 = Double(objCart.total.cartTotal ?? "") ?? 0

        print("walletBalance \(walletBalance)")
        print("totalAmount \(totalAmount11)")
        print("is_used_credit \(is_used_credit)")

        if (walletBalance >= totalAmount11) && is_used_credit == true
        {
            if totalAmount >= minimum_order
            {
                
                payment_method = "credit"
                
                callCheckOutAPI()
                
            }
            else
            {
                
                let strMinimumOrder = String.init(format: "%.3f", minimum_order)
                let strTotalAmount = String.init(format: "%.3f", totalAmount)

                let minimumOrder = " \("Minimum order is".localizeString(string: Language.shared.currentAppLang)) \(strMinimumOrder) \("KD".localizeString(string: Language.shared.currentAppLang))"
                let currentOrder = " \("Your current order is".localizeString(string: Language.shared.currentAppLang)) \(strTotalAmount) \("KD".localizeString(string: Language.shared.currentAppLang))"
                
                let msg = "\(minimumOrder)\n\(currentOrder)"
                print(msg)
                
                let mainS =  UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
                vc.strTitle = "Minimum order"
                vc.strMsg = msg
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: false)
            }
            
            
        } else if is_loaylty == true {
            if selectedIndex == -1 {
                self.setUpMakeToast(msg: "Please select loyalty coupon")
            } else {
                
                let dicLoaylty = dicLoyaltyCoupons.coupons[selectedIndex]
                
                let amount = Double(dicLoaylty.amount) ?? 0.0
                let cartTotal = Double(self.objCart.total.cartTotal) ?? 0.0
                
                if amount >= cartTotal  {
                    payment_method = "loyalty"
                    callCheckOutAPI()
                } else {
                    if payment_method == "" {
                        self.setUpMakeToast(msg: "Please select payment method".localizeString(string: Language.shared.currentAppLang))
                    } else {
                        if payment_method == "knet" {
                            payment_method = "loyalty_knet"
                        } else {
                            payment_method = "loyalty_cod"
                        }
                        callCheckOutAPI()
                    }
                }
            }
        }
        else if payment_method == ""
        {
            self.setUpMakeToast(msg: "Please select payment method".localizeString(string: Language.shared.currentAppLang))
        }
        else
        {
 
//            if appDelegate?.getApplicationSettingData().businessrules.isDelivery == "1" && objAddress?.area.deliverySwitch == 1
//            {
                if payment_method == "link"
                {
                    
                    if totalAmount >= minimum_order
                    {
                        
                        if txtMobileNo.text == ""
                        {
                            self.setUpMakeToast(msg: "Please enter mobile number".localizeString(string: Language.shared.currentAppLang))
                        }
                        else if (txtMobileNo.text?.count ?? 0) != 8
                        {
                            self.setUpMakeToast(msg: "Please enter valid mobile number".localizeString(string: Language.shared.currentAppLang))
                        }
                        else
                        {
                            callOrderDoPaymentAPI()
                        }
                        
                    }
                    else
                    {
                        
                        let strMinimumOrder = String.init(format: "%.3f", minimum_order)
                        let strTotalAmount = String.init(format: "%.3f", totalAmount)
 
                        let minimumOrder = " \("Minimum order is".localizeString(string: Language.shared.currentAppLang)) \(strMinimumOrder) \("KD".localizeString(string: Language.shared.currentAppLang))"
                        let currentOrder = " \("Your current order is".localizeString(string: Language.shared.currentAppLang)) \(strTotalAmount) \("KD".localizeString(string: Language.shared.currentAppLang))"
                        
                        let msg = "\(minimumOrder)\n\(currentOrder)"
                        print(msg)
                        
                        let mainS =  UIStoryboard(name: "Home", bundle: nil)
                        let vc = mainS.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
                        vc.strTitle = "Minimum order"
                        vc.strMsg = msg
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: false)
                    }
                    
                }
                else
                {
//                    let objAddress = appDelegate?.getUserSelectedAddress()
//                    
//                    let minimum_order = Double(objAddress?.area.minimumOrder ?? "") ?? 0.0
//                    let totalAmount = Double(self.lblSubTotal.text?.replacingOccurrences(of: " KD", with: "") ?? "") ?? 0.0
                    
                    if totalAmount >= minimum_order
                    {
                        
                        if is_used_credit == true
                        {
                            payment_method = "credit_knet"
                            callCheckOutAPI()
                        }
                        else
                        {
                            callCheckOutAPI()
                        }
                        
                    }
                    else
                    {
                        
                        let strMinimumOrder = String.init(format: "%.3f", minimum_order)
                        let strTotalAmount = String.init(format: "%.3f", totalAmount)
 
                        let minimumOrder = " \("Minimum order is".localizeString(string: Language.shared.currentAppLang)) \(strMinimumOrder) \("KD".localizeString(string: Language.shared.currentAppLang))"
                        let currentOrder = " \("Your current order is".localizeString(string: Language.shared.currentAppLang)) \(strTotalAmount) \("KD".localizeString(string: Language.shared.currentAppLang))"
                        
                        let msg = "\(minimumOrder)\n\(currentOrder)"
                        print(msg)
                        
                        let mainS =  UIStoryboard(name: "Home", bundle: nil)
                        let vc = mainS.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
                        vc.strTitle = "Minimum order"
                        vc.strMsg = msg
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: false)
                    }
                   
                }
//            }
//            else
//            {
//                let areaName = "\"\(objAddress?.areaName ?? "")\""
//
//                let mainS =  UIStoryboard(name: "Home", bundle: nil)
//                let vc = mainS.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
//                vc.modalPresentationStyle = .overFullScreen
//                vc.isAreYou = true
//                vc.strTitle = "\("Unfortunately, currently delivery services not available for".localizeString(string: Language.shared.currentAppLang)) \(areaName)"
//                self.present(vc, animated: false)
//            }
 
        }
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
                            let total_commission_amount = dic_result.value(forKey: "total_commission_amount") as? String ?? ""
                            
                            appDelegate?.user_commission = Double(total_commission_amount) ?? 0.0
                            self.lblCommissonAmount.text = "\(total_commission_amount)" + " KD"
                            
                            self.stackViewCommision.isHidden = total_commission_amount > "0.0" ? false : true
                            self.heightCommission.constant = total_commission_amount > "0.0" ? 110 : 70
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
    
    func callCheckOutAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        var param: [String: Any] = [:]
        
        let delivery_day_slot_id = AppManager.shared.delivery_day_slot_id
        let booked_slot_time = AppManager.shared.booked_slot_time
        let delivery_date = AppManager.shared.delivery_date
        
        if appDelegate?.dicCurrentLoginUser.user_type_text == "wholesaler" {
            // wallet API calling
            param = [
                "payment_method":self.payment_method,
                "is_used_credit":is_used_credit,
                "is_commission_used":is_commission_used,
                "delivery_day_slot_id": "\(delivery_day_slot_id)",
                "booked_slot_time": booked_slot_time,
                "delivery_date": delivery_date
            ]
        } else {
            
            var coupon_id = 0
            
            if is_loaylty == true {
                coupon_id = dicLoyaltyCoupons.coupons[selectedIndex].id ?? 0
            } else {
                coupon_id = 0
            }
            
            param = [
                "payment_method":self.payment_method,
                "delivery_day_slot_id": "\(delivery_day_slot_id)",
                "booked_slot_time": booked_slot_time,
                "delivery_date": delivery_date,
                "coupon_id": coupon_id
            ]
        }
        
        let _url = "?user_id=\(appDelegate?.dicCurrentLoginUser.id ?? 0)"
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(CHEOUT_USER + _url, parameters: param) { response, error, statusCode in
            
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
                        // self.setUpMakeToast(msg: message ?? "")
                        //appDelegate?.isOrder = true
                        // appDelegate?.strOrder = message ?? ""
                        
                        if self.payment_method == "knet" || self.payment_method == "credit_knet" || self.payment_method == "loyalty_knet"
                        {
                            let dicResult = response?.value(forKey: "result") as? NSDictionary
                            let payment_url = dicResult?.value(forKey: "payment_url") as? String
                            
                            let mainS = UIStoryboard(name: "Home", bundle: nil)
                            let vc = mainS.instantiateViewController(withIdentifier: "WebPaymentVC") as! WebPaymentVC
                            vc.strWebPaymentURL = payment_url ?? ""
                            self.navigationController?.pushViewController(vc, animated: false)
                        }
                        else if self.payment_method == "cod" || self.payment_method == "credit" || self.payment_method == "loyalty_cod"
                        {
                            APIClient.sharedInstance.hideIndicator()
                            
                            if appDelegate?.getIsGuestLogin() == true
                            {
                                appDelegate?.saveIsGuestLogin(dic: false)
     
                                appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
                                appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
                                
                                UserDefaults.standard.set("", forKey: "token")
                                UserDefaults.standard.synchronize()
                                
                                appDelegate?.saveIsUserLogin(dic: false)
                            }
                            
                            let mainS = UIStoryboard(name: "Home", bundle: nil)
                            let vc = mainS.instantiateViewController(withIdentifier: "ThankyouVC") as! ThankyouVC
                            self.navigationController?.pushViewController(vc, animated: false)
                        }
                        else if self.payment_method == "applePay"
                        {
                            self.startApplePayPayment()
                        }
                        else
                        {
                            self.setUpMakeToast(msg: message ?? "")
                            APIClient.sharedInstance.hideIndicator()
                        }
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
    
    func callOrderDoPaymentAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["payment_method":"knet","pay_by_mobile_number":self.txtMobileNo.text ?? "","county_code":"\(self.lblCode.text?.replacingOccurrences(of: "+", with: "") ?? "")"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(ORDER_DO_PAYMENT, parameters: param) { response, error, statusCode in
            
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
                        
                        APIClient.sharedInstance.hideIndicator()
                        
                        if appDelegate?.getIsGuestLogin() == true
                        {
                            appDelegate?.saveIsGuestLogin(dic: false)
     
                            appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
                            appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
                            
                            UserDefaults.standard.set("", forKey: "token")
                            appDelegate?.saveIsUserLogin(dic: false)
                        }
                        
                        
                        let mainS = UIStoryboard(name: "Home", bundle: nil)
                        let vc = mainS.instantiateViewController(withIdentifier: "ThankyouVC") as! ThankyouVC
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
                
                self.arrFactoryProduct.removeAll()
                self.arrNonFactoryProduct.removeAll()
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        if let dicResult = response?.value(forKey: "result") as? NSDictionary
                        {
                            self.objCart = TBCartListResult(fromDictionary: dicResult)
                            
                            self.switchExpressDelivery.isOn = self.objCart.is_express_delivery == 1 ? true : false
                            self.viewMainExpressOn.isHidden = appDelegate?.delivery_slot_allowed == 1 && self.objCart.is_express_delivery == 0 ? true : false
                            self.viewMainSelectTime.isHidden =  self.objCart.is_express_delivery == 0 && appDelegate?.delivery_slot_allowed == 1 ? false : true
                            
                            /*if let objAddress = self.objCart.address
                            {
                                if objAddress.id != nil
                                {
                                    let address = objAddress.address ?? ""
                                    let block = objAddress.block ?? ""
                                    let street = objAddress.street ?? ""
                                    let _ = objAddress.avenue ?? ""
                                    let building_number = objAddress.buildingNumber ?? ""
                                    let _ = objAddress.floor ?? ""
                                    let _ = objAddress.apartment ?? ""
                                    
                                    self.lblName.text = objAddress.areaName ?? ""
                                    
                    //                self.lblAddress.text = "Block \(block),st. \(street),Building \(building_number)"
                                    
                                    let Block_lan = "Block".localizeString(string: Language.shared.currentAppLang)
                                    let Street_lan = "Street".localizeString(string: Language.shared.currentAppLang)
                                    let Building_lan = "Building".localizeString(string: Language.shared.currentAppLang)
                                    
                                    self.lblAddress.text = "\(Block_lan) \(block),\(Street_lan) \(street),\(Building_lan) \(building_number)"
                                    
                                    self.lblType.text = address
                                    
//                                    self.setPaymentOption()
                                    
                                    let camera = GMSCameraPosition.camera(withLatitude: Double(objAddress.latitude ?? "") ?? 0.0, longitude: Double(objAddress.longitude ?? "") ?? 0.0, zoom: 15.0)
                                    self.mapView?.camera = camera
                                    
                                    let annotion = GMSMarker()
                                    annotion.position = CLLocationCoordinate2D(latitude: Double(objAddress.latitude ?? "") ?? 0.0, longitude: Double(objAddress.longitude ?? "") ?? 0.0)
                                    annotion.icon = self.imageWithImage(image: UIImage(named: "maps-and-flags")!, scaledToSize: CGSize(width: 30, height: 35))
                                    annotion.map = self.mapView
                                }
                                else
                                {
                                    self.callGetAddressAPI()
                                }
                            }
                            else
                            {
                                self.callGetAddressAPI()
                            }*/
                            
                            self.setPaymentOption()
                            
                            if self.is_loaylty == true {
                                self.viewApplePay.isHidden = true
                                self.viewMainSendLink.isHidden = true
                            } else {
                                self.viewApplePay.isHidden = false
                                self.viewMainSendLink.isHidden = false
                            }
                            
                            if self.objCart.promocode == ""
                            {
                                
                                self.promobottomCont.constant = 0
                                self.lblPromoCodeDisc.isHidden = true
                                self.lblPromoCodeDisc.text = ""
                                self.lblPromoPrice.isHidden = true
                                
                                self.txtPromoCode.text = ""
                                self.txtPromoCode.isUserInteractionEnabled = true
                                self.txtPromoCode.alpha = 1
                                self.btnApplyRemove.setTitle("Redeem".localizeString(string: Language.shared.currentAppLang), for: .normal)
                            }
                            else
                            {
                                self.promobottomCont.constant = 11
                                self.lblPromoCodeDisc.isHidden = false
                                self.lblPromoPrice.isHidden = false
                                self.lblPromoCodeDisc.text = "Promo Code Discount:".localizeString(string: Language.shared.currentAppLang)
                                self.lblPromoPrice.text = "- \(self.objCart.total.promocode_value ?? "") \(self.objCart.currency.uppercased())"
                                
//                                self.txtPromoCode.text = self.objCart.promocode ?? ""
//                                self.txtPromoCode.isUserInteractionEnabled = false
//                                self.txtPromoCode.alpha = 0.6
                              //  self.btnApplyRemove.setTitle("Remove".localizeString(string: Language.shared.currentAppLang), for: .normal)
                            }
                            
                            self.lblSubTotal.text = "\(self.objCart.total.total_before_discount ?? "") \(self.objCart.currency.uppercased())"
                            self.lblDCharge.text = "\(self.objCart.total.cartDeliveryCharge ?? "") \(self.objCart.currency.uppercased())"
                            self.lblTotal.text = "\(self.objCart.total.cartTotal ?? "") \(self.objCart.currency.uppercased())"
 
                            if let arrCartItems = dicResult.value(forKey: "cart_items") as? NSArray
                            {
                                for obj in arrCartItems
                                {
                                    let dicData = TBCartListCartItem(fromDictionary: obj as! NSDictionary)
                                    arrCart.append(dicData)
                                    
                                    if dicData.factoryProduct == 1
                                    {
                                        self.arrFactoryProduct.append(dicData)
                                    }
                                    else
                                    {
                                        self.arrNonFactoryProduct.append(dicData)
                                    }
                                    
                                    if (self.objCart.express_delivery == 1)
                                    {
                                        if self.objCart.is_express_delivery == 1
                                        {
                                            self.lblTDeliveyCharge.text = "Express Delivery Charge:".localizeString(string: Language.shared.currentAppLang)

                                            
                                            let expressDeliveryTime = self.objCart.express_delivery_time ?? ""
                                            var expressDeliveryMessage = ""
                                            let expressDeliveryCharge = self.objCart.express_delivery_charge ?? ""
                                            let deliveryTime = self.objCart.express_delivery_time ?? ""

                                            if Language.shared.isArabic == false
                                            {
                                                expressDeliveryMessage = "Express delivery available for your area for \(expressDeliveryCharge) KD. Order will be delivered in \(deliveryTime) working hours."
                                            }
                                            else
                                            {
                                                expressDeliveryMessage = "التوصيل السريع متوفر لعنوانك مقابل \(expressDeliveryCharge) KD سيتم توصيل طلبك خلال \(deliveryTime)"
                                            }
                                            
                                            if Language.shared.isArabic == false
                                            {
                                                self.lblYourOrder.text = "Your order will delivered in \(expressDeliveryTime) working\nhours."
                                            }
                                            else
                                            {
                                                self.lblYourOrder.text = "سيتم توصيل طلبك خلال \(expressDeliveryTime) ساعات\n عمل."
                                            }
                                            
                                            self.lblEpressMesg.text = expressDeliveryMessage
                                            self.btn.setTitle(/*"Remove".localizeString(string: Language.shared.currentAppLang)*/"", for: .normal)
                                        }
                                        else
                                        {
                                            self.lblTDeliveyCharge.text = "Delivery Charge:".localizeString(string: Language.shared.currentAppLang)

                                            let expressDeliveryCharge = self.objCart.express_delivery_charge ?? ""
                                            let deliveryTime = self.objCart.express_delivery_time ?? ""
                                            var expressDeliveryMessage = ""

                                            if Language.shared.isArabic == false{
                                                expressDeliveryMessage = "Express delivery available for your area for \(expressDeliveryCharge) KD. Order will be delivered in \(deliveryTime) working hours."
                                            }
                                            else{
                                                expressDeliveryMessage = "التوصيل السريع متوفر لعنوانك مقابل \(expressDeliveryCharge) KD سيتم توصيل طلبك خلال \(deliveryTime)"
                                            }
                                            
                                            if Language.shared.isArabic == false
                                            {
                                                self.lblYourOrder.text = "The following items will be delivered in 24 hours"
                                            }
                                            else
                                            {
                                                self.lblYourOrder.text = "سيتم توصيل طلبك خلالسيتم توصيل العناصر التالية خلال 24 ساعة"
                                            }

                                            self.lblEpressMesg.text = expressDeliveryMessage
                                            self.btn.setTitle(/*"Yes".localizeString(string: Language.shared.currentAppLang)*/"", for: .normal)
                                        }
                                        
                                      //  self.viewEpressDe.isHidden = false
                                        self.viewDEpressHieghtCont.constant = 50
                                        
                                        self.lblTopContMEss.constant = 20
                                        self.btnTopRemoveCont.constant = 20
                                        self.btnRemoveHieght.constant = 0
                                        self.btnRemoveBottomcomt.constant = 0
                                        
                                    }
                                    else
                                    {
                                        
                                        self.lblEpressMesg.text = ""
                                      // self.viewEpressDe.isHidden = true
                                        self.viewDEpressHieghtCont.constant = 0
                                        
                                        self.lblTopContMEss.constant = 0 //20
                                        self.btnTopRemoveCont.constant = 0 //20
                                        self.btnRemoveHieght.constant = 0 //40
                                        self.btnRemoveBottomcomt.constant = 0 //14
 
                                        self.lblTDeliveyCharge.text = "Delivery Charge:".localizeString(string: Language.shared.currentAppLang)
                                        
                                        self.mainView_.frame = CGRect(x: 0, y: 0,width: self.view.frame.width, height: 930 + 25 + 10 + 30)
                                    }
                                    
                                }
                            }
                        }
                        
                        appDelegate?.strTotalCount = "\(arrCart.count)"
                        
                        if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCountItem.isHidden = true
                        }
                        else
                        {
                            self.viewCountItem.isHidden = true
                        }
                        
                        self.lblCartCount.text = "\(arrCart.count)"
                        
                        self.tblVie.reloadData()
                    }
                    else
                    {
                        self.arrFactoryProduct.removeAll()
                        self.arrNonFactoryProduct.removeAll()
                        self.tblVie.reloadData()
                        
                        appDelegate?.strTotalCount = "0"
                        self.lblCartCount.text = "0"
                        
                        if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCountItem.isHidden = true
                        }
                        else
                        {
                            self.viewCountItem.isHidden = true
                        }
                        
                        APIClient.sharedInstance.hideIndicator()
                    }
                    
                }
                else
                {
                    if appDelegate?.strTotalCount == "0"
                    {
                        self.viewCountItem.isHidden = true
                    }
                    else
                    {
                        self.viewCountItem.isHidden = true
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
    
    func callModifytoCartAPI(is_express_delivery: String,cart_id: String)
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["cart_id":cart_id,"is_express_delivery":is_express_delivery]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(MODIFY_CART_INFO, parameters: param) { response, error, statusCode in
            
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
                        self.callGetCartAPI()
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
    
    func callGetAddressAPI()
    {
        // APIClient.sharedInstance.showIndicator()
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(GET_ADDRESS + "\(appDelegate?.dicCurrentLoginUser.id ?? 0)", parameters: param) { response, error, statusCode in
            
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
                        self.arrAddressList.removeAll()
                        
                        if let arrResult = response?.value(forKey: "result") as? NSArray
                        {
                            if arrResult.count > 0
                            {
                                let dicData = TBAddressResult(fromDictionary: (arrResult[0] as? NSDictionary)!)
                                appDelegate?.saveUserSelectedAddress(dic: dicData)
                                
                                
                                if let objAddress = appDelegate?.getUserSelectedAddress()
                                {
                                    let _ = objAddress.address ?? ""
                                    let block = objAddress.block ?? ""
                                    let street = objAddress.street ?? ""
                                    let _ = objAddress.avenue ?? ""
                                    let building_number = objAddress.buildingNumber ?? ""
                                    let _ = objAddress.floor ?? ""
                                    let _ = objAddress.apartment ?? ""
                                    
                                    self.lblName.text = objAddress.areaName ?? ""
                                    
//                                    self.lblAddress.text = "Block \(block),st. \(street),Building \(building_number)"
                                    
                                    let Block_lan = "Block".localizeString(string: Language.shared.currentAppLang)
                                    let Street_lan = "Street".localizeString(string: Language.shared.currentAppLang)
                                    let Building_lan = "Building".localizeString(string: Language.shared.currentAppLang)
                                    
                                    self.lblAddress.text = "\(Block_lan) \(block),\(Street_lan) \(street),\(Building_lan) \(building_number)"
                                    
                                    self.lblType.text = objAddress.address ?? ""
                                    
                                    let camera = GMSCameraPosition.camera(withLatitude: Double(objAddress.latitude ?? "") ?? 0.0, longitude: Double(objAddress.longitude ?? "") ?? 0.0, zoom: 15.0)
                                    self.mapView?.camera = camera
                                    
                                    let annotion = GMSMarker()
                                    annotion.position = CLLocationCoordinate2D(latitude: Double(objAddress.latitude ?? "") ?? 0.0, longitude: Double(objAddress.longitude ?? "") ?? 0.0)
                                    annotion.icon = self.imageWithImage(image: UIImage(named: "maps-and-flags")!, scaledToSize: CGSize(width: 30, height: 35))
                                    annotion.map = self.mapView
                                }
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
    
    func callLoyaltyCouponsAPI() {
        APIClient.sharedInstance.showIndicator()

        let param = ["":""]
        print(param)

        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(LOYALTY_COUPONS, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200 {
                    if status == 1 {
                        
                        if let result = response?.value(forKey: "result") as? NSDictionary {
                            let dic = TBLoyaltyCouponsResult(fromDictionary: result)
                            self.dicLoyaltyCoupons = dic
                            
                            self.lblAvailableLoyaltyPoint.text = "\(dic.point ?? "") Points"
                            
                            if dic.point == "" {
                                self.viewMainLoyaltyPoints.isHidden = true
                            }
                            
                            DispatchQueue.main.async {
                                self.isApiCall = true
                                self.tblViewLoyaltyCoupons.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
                                self.tblViewLoyaltyCoupons.reloadData()
                            }
                        }
                        
                    } else {
                        APIClient.sharedInstance.hideIndicator()
                    }
                } else {
                    APIClient.sharedInstance.hideIndicator()
                    
                    if message?.contains("Unauthenticated.") == true {
                        appDelegate?.strTotalCount = "0"
                        appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
                        appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
                        appDelegate?.saveIsUserLogin(dic: false)
                    }
                }
            } else {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    func callGetWalletAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
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
                             self.lblBalanceUC.text = "\(user_wallet_amount) KD"
                            self.walletBalance = user_wallet_amount
                            
                            if appDelegate?.dicCurrentLoginUser.is_show_credit == 1
                            {
                                self.viewLineCredit.isHidden = false
                                self.viewMainCredit.isHidden = false
                                
                                if (Double(user_wallet_amount) ?? 0.0) > 0
                                {
                                    
                                    self.heightViewCrdit.constant = 100
                                    self.stackHifd.isHidden = false
                                    
                                } else {
                                   
                                    // wallet API calling
                                    self.heightViewCrdit.constant = 50
                                    self.stackHifd.isHidden = true
                                }
                            }
                            else {
                                self.viewMainCredit.isHidden = true
                                self.viewLineCredit.isHidden = true
                                self.heightViewCrdit.constant = 0
                            }
                          
                            
                            self.viewMainNo.backgroundColor = UIColor(hexString: "#F7C491")
                            self.viewMainYes.backgroundColor = .clear
                            
                            self.viewMainNo.borderColor = .clear
                            self.viewMainYes.borderColor = UIColor(hexString: "#AEAEB2")
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

extension PaymentVC: ADCountryPickerDelegate {
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String)
    {
        _ = picker.navigationController?.popToRootViewController(animated: true)
        
        self.lblCode.text = dialCode
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func countryFlag(_ countryCode: String) -> String {
        let flagBase = UnicodeScalar("🇦").value - UnicodeScalar("A").value
        
        let flag = countryCode
            .uppercased()
            .unicodeScalars
            .compactMap({ UnicodeScalar(flagBase + $0.value)?.description })
            .joined()
        return flag
    }
    
}

class checkOutListCell: UITableViewCell
{
    @IBOutlet weak var lblName: UILabel!
}


// MARK: - collectionView Delegate & DataSource
//extension PaymentVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = self.collectionViewLoayltyPoint.dequeueReusableCell(withReuseIdentifier: "LoayltyCouponCell", for: indexPath) as! LoayltyCouponCell
//        
//        return cell
//    }
//    
//    
//}
//
//class LoayltyCouponCell: UICollectionViewCell {
//    
//    @IBOutlet weak var lblPrice: UILabel!
//    @IBOutlet weak var lblPoint: UILabel!
//    @IBOutlet weak var imgSelect: UIImageView!
//}

class LoayltyCouponCell: UITableViewCell {
    
    @IBOutlet weak var imgCoupon: UIImageView!
    @IBOutlet weak var lblKD: UILabel!
    @IBOutlet weak var lblPoint: UILabel!
    @IBOutlet weak var imgSelect: UIImageView!
    
}
