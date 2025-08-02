//
//  NewHomeVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 26/12/24.
//

import UIKit
import LGSideMenuController
import CoreLocation
import MarqueeLabel

class NewHomeVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var tblView: UITableView! {
        didSet {
            tblView.delegate = self
            tblView.dataSource = self
            if #available(iOS 15.0, *) {
                tblView.sectionHeaderTopPadding = 0
            } else {
                // Fallback on earlier versions
            }
        }
    }
    @IBOutlet weak var viewCartItem: UIView!
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var imgCartRight: NSLayoutConstraint!
    @IBOutlet weak var imgCartWidth: NSLayoutConstraint!
    @IBOutlet weak var imgCart: UIImageView!
    // collectionSectionInSet
    
    let locationManager = CLLocationManager()
    var arrBannersList: [TBBannersResult] = [TBBannersResult]()
    var arrMasterCategories: [TBMasterCategoriesResult] = [TBMasterCategoriesResult]()
    var arrCategoriesStepWise: [TBCategoriesResult] = [TBCategoriesResult]()
    var arrInfluencersList: [TBInfluencersListResult] = [TBInfluencersListResult]()
    
    var selectedIndex = 0
    
    // MARK: - view Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = UserDefaults.standard.value(forKey: "token") as? String ?? ""

        print("Usertoken:- \(token)")
        
        callComminsonAPI(isShowIndicator: false)
        callBannersAPI()
        callGetCartAPI()
        callMasterCategoriesAPI()
        callCategoriesStepWiseAPI()
        callInfluencersAPI()
        
        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled(){
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.distanceFilter = 10
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.startUpdatingLocation()
            }
         }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if appDelegate?.isFirstTime == true {
                if appDelegate?.getCmsAdverd() != nil {
                    appDelegate?.isFirstTime = false
                    let mainS =  UIStoryboard(name: "Home", bundle: nil)
                    let vc = mainS.instantiateViewController(withIdentifier: "AdsVC") as! AdsVC
                    vc.delegateClose = self
                    vc.modalPresentationStyle = .overFullScreen
                    let navController = UINavigationController(rootViewController: vc)
                    navController.modalPresentationStyle = .overFullScreen
                    vc.navigationController?.navigationBar.isHidden = true
                    self.present(navController, animated: false)
                } else {
                    self.openChooseDelivery()
                }
            } else {
                self.openChooseDelivery()
            }
        }
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if appDelegate?.isOrder == true
        {
            appDelegate?.isOrder = false
            self.setUpMakeToast(msg: appDelegate?.strOrder ?? "")
        }
        
      
        if appDelegate?.dicCurrentLoginUser.id != nil
        {
            imgCartRight.constant = 20
            imgCartWidth.constant = 22
            imgCart.isHidden = false
            
            self.callProfileDetailAPI()
            
            //lblUserNaem.text = "\("Welcome".localizeString(string: Language.shared.currentAppLang)) \(appDelegate?.dicCurrentLoginUser.name ?? "")"
            
//            lblUserNaem.isHidden = true
//            imgProfile.isHidden = true

            callGetCartAPI()
        }
        else
        {
          //  lblUserNaem.text = "Welcome Guest".localizeString(string: Language.shared.currentAppLang)
            
//            lblUserNaem.isHidden = true
//            imgProfile.isHidden = true
            
            imgCartRight.constant = 0
            imgCartWidth.constant = 0
            imgCart.isHidden = true

        }
    }
    
    func openChooseDelivery() {
        
        if appDelegate?.dicCurrentLoginUser.id != nil
        {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if appDelegate?.isFirstTimeAddress == true {
                    appDelegate?.isFirstTimeAddress = false
                    let vc = ChooseDeliveryAddress()
                    vc.modalPresentationStyle = .overFullScreen
                    vc.delegateChooseDelivery = self
                    let navController = UINavigationController(rootViewController: vc)
                    navController.modalPresentationStyle = .overFullScreen
                    vc.navigationController?.navigationBar.isHidden = true
                    self.present(navController, animated: false)
                }
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let _ = locations.last
    }
    
    // MARK: - Action Method
    @IBAction func clickedMenu(_ sender: Any) {
        if Language.shared.isArabic {
            self.sideMenuController?.showRightView(animated: true, completion: nil)
        } else {
            self.sideMenuController?.showLeftView(animated: true, completion: nil)
        }
    }
    @IBAction func clickedNotification(_ sender: Any) {
        
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
    @IBAction func clickedSearch(_ sender: Any) {
        let mains = UIStoryboard(name: "Home", bundle: nil)
        let vc = mains.instantiateViewController(withIdentifier: "SearchProductVC") as! SearchProductVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    // MARK: - callling API
    func callBannersAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderGet(GET_BANNERS, parameters: param) { response, error, statusCode in
            
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
                        self.arrBannersList.removeAll()
                        
                        if let arrResult = response?.value(forKey: "result") as? NSArray
                        {
                            for obj in arrResult
                            {
                                let dicData = TBBannersResult(fromDictionary: obj as! NSDictionary)
                                self.arrBannersList.append(dicData)
                            }
                        }
                        
                        self.tblView.reloadData()
                    }
                    else
                    {
                        self.arrBannersList.removeAll()
                        self.tblView.reloadData()
                        APIClient.sharedInstance.hideIndicator()
                        self.setUpMakeToast(msg: message ?? "")
                    }
                }
                else
                {
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
                        
                        self.callRemoveApplyCodeAPI(cart_id: "\(objCart.cartId ?? 0)")
                        
                        appDelegate?.strTotalCount = "\(arrCart.count)"
                        
                        if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCartItem.isHidden = true
                        }
                        else
                        {
                            self.viewCartItem.isHidden = false
                        }
                        
                        self.lblCartCount.text = "\(arrCart.count)"
                    }
                    else
                    {
                        appDelegate?.strTotalCount = "0"
                        self.lblCartCount.text = "0"
                        
                        if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCartItem.isHidden = true
                        }
                        else
                        {
                            self.viewCartItem.isHidden = false
                        }
                        
                        APIClient.sharedInstance.hideIndicator()
                    }
                    
                }
                else
                {
                    if appDelegate?.strTotalCount == "0"
                    {
                        self.viewCartItem.isHidden = true
                    }
                    else
                    {
                        self.viewCartItem.isHidden = false
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
                            let total_commission_amount = dic_result.value(forKey: "total_commission_amount") as? Float ?? 0.0
                            
                            appDelegate?.user_commission = Double(total_commission_amount)
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
    
    func callRemoveApplyCodeAPI(cart_id: String)
    {
        
        let param = ["cart_id":cart_id]
        
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
                        
                  //      self.setUpMakeToast(msg: message ?? "")
                    }
                    else
                    {
                    //    self.setUpMakeToast(msg: message ?? "")
                     }
                }
                else
                {
                  //  self.setUpMakeToast(msg: message ?? "")
                }
            }
            else
            {
            }
        }
    }
    
    func callMasterCategoriesAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderGet(GET_CATEGORIES_MASTER, parameters: param) { response, error, statusCode in
            
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
                        if let arrResult = response?.value(forKey: "result") as? NSArray
                        {
                            for obj in arrResult
                            {
                                let dicData = TBMasterCategoriesResult(fromDictionary: obj as! NSDictionary)
                                self.arrMasterCategories.append(dicData)
                            }
                        }
                        
                        self.tblView.reloadData()
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                        
                        self.setUpMakeToast(msg: message ?? "")
                    }
                }
                else
                {
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
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    func callCategoriesStepWiseAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderGet(GET_CATEGORIES_SETP_WISE, parameters: param) { response, error, statusCode in
            
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
                        if let arrResult = response?.value(forKey: "result") as? NSArray
                        {
                            for obj in arrResult
                            {
                                let dicData = TBCategoriesResult(fromDictionary: obj as! NSDictionary)
                                self.arrCategoriesStepWise.append(dicData)
                            }
                        }
                        self.tblView.reloadData()
                        
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                        
                        self.setUpMakeToast(msg: message ?? "")
                    }
                }
                else
                {
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
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    func callInfluencersAPI()
    {
//        APIClient.sharedInstance.showIndicator()
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderGet(INFLUENCERS_LIST, parameters: param) { response, error, statusCode in
            
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
                        self.arrInfluencersList.removeAll()
                        
                        if let arrResult = response?.value(forKey: "result") as? NSArray
                        {
                            for obj in arrResult
                            {
                                let dicData = TBInfluencersListResult(fromDictionary: obj as! NSDictionary)
                                self.arrInfluencersList.append(dicData)
                            }
                        }
                        
                        self.tblView.reloadData()
                    }
                    else
                    {
                        self.arrInfluencersList.removeAll()
                        self.tblView.reloadData()
                        APIClient.sharedInstance.hideIndicator()
                        
                        self.setUpMakeToast(msg: message ?? "")
                    }
                }
                else
                {
                    self.arrInfluencersList.removeAll()
                    self.tblView.reloadData()
                    
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

// MARK: - didOnChooseDelivery
extension NewHomeVC: didOnChooseDelivery {
    func didTapOnNoDelivery(areaName: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let mainS =  UIStoryboard(name: "Home", bundle: nil)
            let vc = mainS.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
            vc.modalPresentationStyle = .overFullScreen
            vc.isAreYou = true
            vc.strTitle = "\("Unfortunately, currently delivery services not available for".localizeString(string: Language.shared.currentAppLang)) \(areaName)"
            self.present(vc, animated: false)
        }
    }
    
}

// MARK: - didTapOnAds
extension NewHomeVC: didTapOnAds {
    func onTapClose() {
        
        
        openChooseDelivery()
    }
    
    
}

// MARK: - collectionView Delegate & DataSource
extension NewHomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrInfluencersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewInfluncerCell", for: indexPath) as! NewInfluncerCell
        
        let dicData = arrInfluencersList[indexPath.row]
 
//        cell.hideSkeltonview()
        
        var media_link_url = "\(dicData.image ?? "")"
        media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        cell.imgInfu.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let home: ToolsVC = mainStoryboard.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
        home.objInfluencers = arrInfluencersList[indexPath.row]
        let homeNavigation = UINavigationController(rootViewController: home)
        let leftViewController: SideMenuVC = mainStoryboard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        
        if Language.shared.isArabic {
            
            let controller = LGSideMenuController.init(rootViewController: homeNavigation, leftViewController: nil, rightViewController: leftViewController)
            controller.leftViewWidth = home.view.frame.size.width - 70
            homeNavigation.navigationBar.isHidden = true
            appDelegate?.window?.rootViewController = controller
            appDelegate?.window?.makeKeyAndVisible()
        }
        else
        {
            let controller = LGSideMenuController.init(rootViewController: homeNavigation, leftViewController: leftViewController, rightViewController: nil)
            controller.leftViewWidth = home.view.frame.size.width - 70
            homeNavigation.navigationBar.isHidden = true
            appDelegate?.window?.rootViewController = controller
            appDelegate?.window?.makeKeyAndVisible()
        }
        
        
        
    }
    
}


// MARK: - tblView Delegate & DataSource
extension NewHomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if selectedIndex == 0 {
                return arrMasterCategories.count
            } else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "TopHomeBannerCell") as! TopHomeBannerCell
            
            cell.delegateVC = self
            if arrBannersList.count > 0 {
                cell.arrBannersList = arrBannersList
                cell.collectionViewBanner.reloadData()
            }
            
            return cell
        } else {
            if selectedIndex == 0 {
                let cell = self.tblView.dequeueReusableCell(withIdentifier: "InfluencersListCell") as! InfluencersListCell
                
                let dicData = arrMasterCategories[indexPath.row]
                
 
                cell.configure(with: dicData.name ?? "")
                
                var media_link_url = "\(dicData.image ?? "")"
                media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                cell.imgPic.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
                
                cell.lblName.textAlignment = .center
                
                return cell
            } else {
                let cell = self.tblView.dequeueReusableCell(withIdentifier: "MaterialsTblViewCell") as! MaterialsTblViewCell
                cell.delegateVC = self
                if arrCategoriesStepWise.count > 0 {
                    cell.arrNewCategoriesStepWise = arrCategoriesStepWise
                    cell.collectionViewMaterials.reloadData()
                }
                
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if selectedIndex == 0 {
                let dicData = arrMasterCategories[indexPath.row]
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "SubCategoriesVC") as! SubCategoriesVC
                vc.strCategoryID = "\(dicData.id ?? 0)"
                vc.isStepWise = false
                vc.strTitle = dicData.name ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 190
        } else {
            if selectedIndex == 0 {
                return 90
            } else {
                let totalItems = arrCategoriesStepWise.count
                let itemsPerRow: CGFloat = 3 // Example: 3 items per row
                let itemHeight: CGFloat = 115 // Example: Item height
                let spacing: CGFloat = 12 // Example: Spacing between rows
                let numberOfRows = ceil(CGFloat(totalItems) / itemsPerRow)
                let collectionViewHeight = numberOfRows * itemHeight + (numberOfRows - 1) * spacing
                return collectionViewHeight
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.5
        } else {
            return 190
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        } else {
            let headerView = Bundle.main.loadNibNamed("HomeTopHeaderView", owner: self, options: [:])?.first as! HomeTopHeaderView
            headerView.delegateVC = self
            
            headerView.collectionViewInfu.delegate = self
            headerView.collectionViewInfu.dataSource = self
            headerView.collectionViewInfu.collectionViewLayout = headerView.InflowLayout
            
            let nib = UINib(nibName: "NewInfluncerCell", bundle: nil)
            headerView.collectionViewInfu.register(nib, forCellWithReuseIdentifier: "NewInfluncerCell")
            headerView.collectionViewInfu.reloadData()
            
            headerView.lblCategories.text = "CATEGORIES".localizeString(string: Language.shared.currentAppLang)
            headerView.lblTInfo.text = "INFLUENCERS / Building Experts".localizeString(string: Language.shared.currentAppLang)
            headerView.lblTConstrucation.text = "CONSTRUCTION MATERIALS STEP WISE".localizeString(string: Language.shared.currentAppLang)
            
            if selectedIndex == 0 {
                headerView.viewCategories.backgroundColor = UIColor(hexString: "#F3CB97")
                headerView.viewConstrucatiom.backgroundColor = .white
            } else {
                headerView.viewConstrucatiom.backgroundColor = UIColor(hexString: "#F3CB97")
                headerView.viewCategories.backgroundColor = .white
            }
            
            headerView.clickedSegment = { [self] index in
                selectedIndex = index
                tblView.reloadData()
            }
            
            if headerView.arrInfluencersList.count > 0 {
                
                if headerView.arrInfluencersList.count == 1 {
                    headerView.collectionViewInfu.isHidden = true
                    headerView.viewInfuMain.isHidden = false
                    
                    headerView.viewInfu2.isHidden = false
                    headerView.viewInfu1.isHidden = true
                    headerView.viewInfu3.isHidden = true
                    
                    headerView.widthInfu2.constant = 70
                    
                    let dicData = self.arrInfluencersList[0]
                    
                    var media_link_url = "\(dicData.image ?? "")"
                    media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                    headerView.imgInfu2.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
                    
                } else if self.arrInfluencersList.count == 2 {
                    headerView.collectionViewInfu.isHidden = true
                    headerView.viewInfuMain.isHidden = false
                    
                    headerView.viewInfu2.isHidden = true
                    headerView.viewInfu1.isHidden = false
                    headerView.viewInfu3.isHidden = false
                    
                    headerView.widthInfu2.constant = 0
                    
                    var media_link_url = "\(self.arrInfluencersList[0].image ?? "")"
                    media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                    headerView.imgInfu1.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
                    
                    var media_link_url1 = "\(self.arrInfluencersList[1].image ?? "")"
                    media_link_url1 = (media_link_url1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                    headerView.imgInfu3.sd_setImage(with: URL.init(string: media_link_url1),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
                    
                } else if self.arrInfluencersList.count == 3 {
                    headerView.collectionViewInfu.isHidden = true
                    headerView.viewInfuMain.isHidden = false
                    
                    headerView.viewInfu2.isHidden = false
                    headerView.viewInfu1.isHidden = false
                    headerView.viewInfu3.isHidden = false
                    
                    headerView.widthInfu2.constant = 70
                    
                    var media_link_url = "\(self.arrInfluencersList[0].image ?? "")"
                    media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                    headerView.imgInfu1.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
                    
                    var media_link_url1 = "\(self.arrInfluencersList[1].image ?? "")"
                    media_link_url1 = (media_link_url1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                    headerView.imgInfu2.sd_setImage(with: URL.init(string: media_link_url1),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
                    
                    var media_link_url2 = "\(self.arrInfluencersList[2].image ?? "")"
                    media_link_url2 = (media_link_url2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                    headerView.imgInfu3.sd_setImage(with: URL.init(string: media_link_url2),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
                    
                } else {
                    headerView.collectionViewInfu.reloadData()
                    headerView.collectionViewInfu.isHidden = false
                    headerView.viewInfuMain.isHidden = true
                    
                }
            }
            
            return headerView
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
}

// MARK: - SilderCell
class SilderCell: UICollectionViewCell
{
    @IBOutlet weak var imgPic: UIImageView!
}

// MARK: - InfluencersListCell
class InfluencersListCell: UITableViewCell
{
    @IBOutlet weak var imgPic: UIImageView!
    @IBOutlet weak var lblName: MarqueeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblName.type = .continuous
        lblName.speed = .duration(10.0)
        lblName.trailingBuffer = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblName.restartLabel()
    }
    
    func configure(with text: String) {
        lblName.text = text.uppercased()
        lblName.restartLabel()
    }
}

// MARK: - ConstructionCell
class ConstructionCell: UICollectionViewCell
{
    @IBOutlet weak var imgPic: UIImageView!
    @IBOutlet weak var lblName: UILabel!
}

// MARK: - MaterialsTblViewCell
class MaterialsTblViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionViewMaterials: UICollectionView! {
        didSet {
            collectionViewMaterials.delegate = self
            collectionViewMaterials.dataSource = self
            collectionViewMaterials.collectionViewLayout = ConflowLayout
        }
    }
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint!
    
    let ConsectionInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    let ConitemsPerRow: CGFloat = 3
    
    var ConflowLayout: UICollectionViewFlowLayout {
        let _ConflowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.ConsectionInsets.left * (self.ConitemsPerRow + 1)
            let availableWidth = self.collectionViewMaterials.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.ConitemsPerRow
            
            _ConflowLayout.itemSize = CGSize(width: widthPerItem, height: widthPerItem)
            
            _ConflowLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
            _ConflowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
            _ConflowLayout.minimumInteritemSpacing = 10
            _ConflowLayout.minimumLineSpacing = 10
        }
        
        // edit properties here
        return _ConflowLayout
    }
    
    var arrNewCategoriesStepWise: [TBCategoriesResult] = [TBCategoriesResult]()
    var delegateVC: UIViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrNewCategoriesStepWise.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewMaterials.dequeueReusableCell(withReuseIdentifier: "ConstructionCell", for: indexPath) as! ConstructionCell
        
        let dicData = arrNewCategoriesStepWise[indexPath.row]
        
        cell.lblName.text = dicData.name ?? ""
        
        var media_link_url = "\(dicData.image ?? "")"
        media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        cell.imgPic.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dicData = arrNewCategoriesStepWise[indexPath.row]
        let mainS = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "SubCategoriesVC") as! SubCategoriesVC
        vc.strCategoryID = "\(dicData.id ?? 0)"
        vc.isStepWise = true
        vc.strTitle = dicData.name ?? ""
        delegateVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - TopHomeBannerCell
class TopHomeBannerCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionViewBanner: UICollectionView!{
        didSet {
            collectionViewBanner.delegate = self
            collectionViewBanner.dataSource = self
            collectionViewBanner.collectionViewLayout = SlidflowLayout
        }
    }
    @IBOutlet weak var pageCon: UIPageControl!
    
    let SlidsectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let SliditemsPerRow: CGFloat = 1
    
    var SlidflowLayout: UICollectionViewFlowLayout {
        let _SlidflowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.SlidsectionInsets.left * (self.SliditemsPerRow + 1)
            let availableWidth = self.collectionViewBanner.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.SliditemsPerRow
            
            _SlidflowLayout.itemSize = CGSize(width: widthPerItem, height: 190)
            
            _SlidflowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            _SlidflowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
            _SlidflowLayout.minimumInteritemSpacing = 0
            _SlidflowLayout.minimumLineSpacing = 0
        }
        
        // edit properties here
        return _SlidflowLayout
    }
    
    var arrBannersList: [TBBannersResult] = [TBBannersResult]()
    var delegateVC: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if let collectionView = scrollView as? UICollectionView {
            switch collectionView.tag {
            case 7:
                let currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
                pageCon.currentPage = Int(currentPage)
            default:
                print("unknown")
            }
        } else{
            print("cant cast")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrBannersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionViewBanner.dequeueReusableCell(withReuseIdentifier: "SilderCell", for: indexPath) as! SilderCell
        
        let dicData = arrBannersList[indexPath.row]
        
        var media_link_url = "\(dicData.image ?? "")"
        media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        cell.imgPic.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dicData = arrBannersList[indexPath.row]
        
        if dicData.type == "2"
        {
            let mainS = UIStoryboard(name: "Home", bundle: nil)
            let vc = mainS.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
            vc.strProductID = dicData.value ?? ""
            delegateVC?.navigationController?.pushViewController(vc, animated: true)
        }
        else if dicData.type == "1"
        {
            if let url = URL(string: dicData.value ?? "") {
                UIApplication.shared.open(url)
            }
        }
    }
    
}
