//
//  HomeVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 01/06/23.
//

import UIKit
import LGSideMenuController
import SDWebImage
import CoreLocation

class HomeVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var imgRightCont: NSLayoutConstraint! //20
    @IBOutlet weak var imgCart: UIImageView!
    @IBOutlet weak var imgCartWidgt: NSLayoutConstraint! //22
    
    @IBOutlet weak var pageCont: UIPageControl!
    
    
    @IBOutlet weak var viewCountItem: UIView!
    @IBOutlet weak var lblUserNaem: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblCartCount: UILabel!
    
    // view Outlet
    
    @IBOutlet weak var viewCon: UIView!
    @IBOutlet weak var viewInfo: UIView!
    
    @IBOutlet weak var viewInfuMain: UIView!
    @IBOutlet weak var viewConMain: UIView!
    
    // collectionView & tblView
    
    @IBOutlet weak var collectionSlider: UICollectionView!
    @IBOutlet weak var collectionInfu: UICollectionView!
    @IBOutlet weak var collectionContraction: UICollectionView!
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var lblTWelcome: UILabel!
    @IBOutlet weak var lblTConstaction: UILabel!
    @IBOutlet weak var lblCategorie: UILabel!
    
    @IBOutlet weak var viewInf1: UIView!
    @IBOutlet weak var viewInf2: UIView!
    @IBOutlet weak var viewInf3: UIView!
    @IBOutlet weak var viewInfMain: UIView!
    
    @IBOutlet weak var imgInf1: UIImageView!
    @IBOutlet weak var imgInf2: UIImageView!
    @IBOutlet weak var imgInf3: UIImageView!
    
    @IBOutlet weak var widthViewInf2: NSLayoutConstraint! // 70
    
    @IBOutlet weak var lblTInfu: UILabel!
    
    let locationManager = CLLocationManager()
    
    // collectionSectionInSet
    
    let SlidsectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let SliditemsPerRow: CGFloat = 1
    
    var SlidflowLayout: UICollectionViewFlowLayout {
        let _SlidflowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.SlidsectionInsets.left * (self.SliditemsPerRow + 1)
            let availableWidth = self.view.frame.width - paddingSpace
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
    
    let InsectionInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    let InitemsPerRow: CGFloat = 5
    
    var InflowLayout: UICollectionViewFlowLayout {
        let _InflowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.InsectionInsets.left * (self.InitemsPerRow + 1)
            let availableWidth = self.collectionInfu.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.InitemsPerRow
            
            _InflowLayout.itemSize = CGSize(width: 70, height: 70)
            
            _InflowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            _InflowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
            _InflowLayout.minimumInteritemSpacing = 12
            _InflowLayout.minimumLineSpacing = 12
        }
        
        // edit properties here
        return _InflowLayout
    }
    
    let ConsectionInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    let ConitemsPerRow: CGFloat = 3
    
    var ConflowLayout: UICollectionViewFlowLayout {
        let _ConflowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.ConsectionInsets.left * (self.ConitemsPerRow + 1)
            let availableWidth = self.view.frame.width - paddingSpace
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
    var arrMasterCategories: [TBMasterCategoriesResult] = [TBMasterCategoriesResult]()
    var arrCategoriesStepWise: [TBCategoriesResult] = [TBCategoriesResult]()
    
    var arrInfluencersList: [TBInfluencersListResult] = [TBInfluencersListResult]()
    
    var arrBannersList: [TBBannersResult] = [TBBannersResult]()
 
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lblCategorie.text = "CATEGORIES".localizeString(string: Language.shared.currentAppLang)
        lblTInfu.text = "INFLUENCERS / Building Experts".localizeString(string: Language.shared.currentAppLang)
        lblTConstaction.text = "CONSTRUCTION MATERIALS STEP WISE".localizeString(string: Language.shared.currentAppLang)
        
        viewInfo.backgroundColor = UIColor(hexString: "#F3CB97")
        viewCon.backgroundColor = .white
        
        viewInfuMain.isHidden = false
        viewConMain.isHidden = true
        
        tblView.delegate = self
        tblView.dataSource =  self
        
        collectionSlider.delegate = self
        collectionSlider.dataSource = self
        collectionSlider.collectionViewLayout = SlidflowLayout
        
        collectionInfu.delegate = self
        collectionInfu.dataSource = self
        collectionInfu.collectionViewLayout = InflowLayout
        
        collectionContraction.delegate = self
        collectionContraction.dataSource = self
        collectionContraction.collectionViewLayout = ConflowLayout
        
        if appDelegate?.dicCurrentLoginUser.id != nil
        {
            callGetAddressAPI()
        }
        
        
        callMasterCategoriesAPI()
        callCategoriesStepWiseAPI()
        callInfluencersAPI()
        callBannersAPI()
   
        if CLLocationManager.locationServicesEnabled(){
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.distanceFilter = 10
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.startUpdatingLocation()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if appDelegate?.isOrder == true
        {
            appDelegate?.isOrder = false
            self.setUpMakeToast(msg: appDelegate?.strOrder ?? "")
        }
        
      
        if appDelegate?.dicCurrentLoginUser.id != nil
        {
            imgRightCont.constant = 20
            imgCartWidgt.constant = 22
            imgCart.isHidden = false

            
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
            
            imgRightCont.constant = 0
            imgCartWidgt.constant = 0
            imgCart.isHidden = true

        }
    }
    
    @IBAction func clickedInf1(_ sender: Any) {
        
        let mainS = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
        vc.objInfluencers = arrInfluencersList[0]
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    @IBAction func clickedInf2(_ sender: Any) {
        
        if Language.shared.isArabic
        {
            if arrInfluencersList.count == 1 {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
                vc.objInfluencers = arrInfluencersList[0]
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
                vc.objInfluencers = arrInfluencersList[1]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else
        {
            if arrInfluencersList.count == 1 {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
                vc.objInfluencers = arrInfluencersList[0]
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
                vc.objInfluencers = arrInfluencersList[1]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    @IBAction func clickedInf3(_ sender: Any) {
        
        if Language.shared.isArabic
        {
            if arrInfluencersList.count == 3
            {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
                vc.objInfluencers = arrInfluencersList[2]
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
                vc.objInfluencers = arrInfluencersList[1]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else
        {
            if arrInfluencersList.count == 3 {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
                vc.objInfluencers = arrInfluencersList[2]
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
                vc.objInfluencers = arrInfluencersList[1]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        
    }
    
    @IBAction func clickedProfile(_ sender: Any) {
        
        if let isUserLogin = appDelegate?.getIsUserLogin()
        {
            if isUserLogin == true
            {
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let vc: ProfileViewController = mainStoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                self.navigationController?.pushViewController(vc, animated: false)
            }
            else
            {
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: LoginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                vc.isFromHome = true
                vc.selectViewContrller = self
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
        else
        {
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: LoginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            vc.isFromHome = true
            self.navigationController?.pushViewController(vc, animated: false)
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
    
    @IBAction func clickedSearch(_ sender: Any) {
//        let mains = UIStoryboard(name: "Home", bundle: nil)
//        let vc = mains.instantiateViewController(withIdentifier: "SearchProductVC") as! SearchProductVC
//        self.navigationController?.pushViewController(vc, animated: true)
        
       
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
    
    @IBAction func clickedIn(_ sender: Any) {
        viewInfo.backgroundColor = UIColor(hexString: "#F3CB97")
        viewCon.backgroundColor = .white
        
        viewInfuMain.isHidden = false
        viewConMain.isHidden = true
    }
    @IBAction func clicledCon(_ sender: Any) {
        viewCon.backgroundColor = UIColor(hexString: "#F3CB97")
        viewInfo.backgroundColor = .white
        
        viewConMain.isHidden = false
        viewInfuMain.isHidden = true
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
        APIClient.sharedInstance.showIndicator()
        
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
                        
                        if self.arrInfluencersList.count > 0 {
                            
                            if self.arrInfluencersList.count == 1 {
                                self.collectionInfu.isHidden = true
                                self.viewInfMain.isHidden = false
                                
                                self.viewInf2.isHidden = false
                                self.viewInf1.isHidden = true
                                self.viewInf3.isHidden = true
                                
                                self.widthViewInf2.constant = 70
                                
                                let dicData = self.arrInfluencersList[0]
                                
                                var media_link_url = "\(dicData.image ?? "")"
                                media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                                self.imgInf2.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
                                
                            } else if self.arrInfluencersList.count == 2 {
                                self.collectionInfu.isHidden = true
                                self.viewInfMain.isHidden = false
                                
                                self.viewInf2.isHidden = true
                                self.viewInf1.isHidden = false
                                self.viewInf3.isHidden = false
                                
                                self.widthViewInf2.constant = 0
                                
                                var media_link_url = "\(self.arrInfluencersList[0].image ?? "")"
                                media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                                self.imgInf1.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
                                
                                var media_link_url1 = "\(self.arrInfluencersList[1].image ?? "")"
                                media_link_url1 = (media_link_url1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                                self.imgInf3.sd_setImage(with: URL.init(string: media_link_url1),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
                                
                            } else if self.arrInfluencersList.count == 3 {
                                self.collectionInfu.isHidden = true
                                self.viewInfMain.isHidden = false
                                
                                self.viewInf2.isHidden = false
                                self.viewInf1.isHidden = false
                                self.viewInf3.isHidden = false
                                
                                self.widthViewInf2.constant = 70
                                
                                var media_link_url = "\(self.arrInfluencersList[0].image ?? "")"
                                media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                                self.imgInf1.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
                                
                                var media_link_url1 = "\(self.arrInfluencersList[1].image ?? "")"
                                media_link_url1 = (media_link_url1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                                self.imgInf2.sd_setImage(with: URL.init(string: media_link_url1),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
                                
                                var media_link_url2 = "\(self.arrInfluencersList[2].image ?? "")"
                                media_link_url2 = (media_link_url2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                                self.imgInf3.sd_setImage(with: URL.init(string: media_link_url2),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
                                
                            } else {
                                self.collectionInfu.isHidden = false
                                self.viewInfMain.isHidden = true
                            }
                        }
                        
                        self.collectionInfu.reloadData()
                    }
                    else
                    {
                        self.arrInfluencersList.removeAll()
                        self.collectionInfu.reloadData()
                        APIClient.sharedInstance.hideIndicator()
                        
                        self.setUpMakeToast(msg: message ?? "")
                    }
                }
                else
                {
                    self.arrInfluencersList.removeAll()
                    self.collectionInfu.reloadData()
                    
                    if message?.contains("Unauthenticated.") == true
                    {
                        appDelegate?.strTotalCount = "0"
                        
                        appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
                        appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
                        appDelegate?.saveCmsAdverd(dic: TBCmsAdverdResult())
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
                        
                        self.collectionContraction.reloadData()
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
                        
                        self.pageCont.numberOfPages = self.arrBannersList.count
                        
                        self.collectionSlider.tag = 7
                        
                        self.collectionSlider.reloadData()
                    }
                    else
                    {
                        self.arrBannersList.removeAll()
                        self.collectionSlider.reloadData()
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
                            self.viewCountItem.isHidden = true
                        }
                        else
                        {
                            self.viewCountItem.isHidden = false
                        }
                        
                        self.lblCartCount.text = "\(arrCart.count)"
                    }
                    else
                    {
                        appDelegate?.strTotalCount = "0"
                        self.lblCartCount.text = "0"
                        
                        if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCountItem.isHidden = true
                        }
                        else
                        {
                            self.viewCountItem.isHidden = false
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
                        self.viewCountItem.isHidden = false
                    }
                    
                    self.lblCartCount.text = "0"
                    
                    if message?.contains("Unauthenticated.") == true
                    {
                        appDelegate?.strTotalCount = "0"
                        
                        appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
                        appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
                        
                        appDelegate?.saveCmsAdverd(dic: TBCmsAdverdResult())
                        
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
    
    func callGetAddressAPI()
    {
        
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
                        var arrAddressList : [TBAddressResult] = [TBAddressResult]()
                        
                        if let arrResult = response?.value(forKey: "result") as? NSArray
                        {
                            for objDic in arrResult
                            {
                                let dicData = TBAddressResult(fromDictionary: (objDic as? NSDictionary)!)
                                arrAddressList.append(dicData)
                            }
                            appDelegate?.saveUserAllAddress(dic: arrAddressList)
                        }
                    }
                    else
                    {
                        let arrAddressList : [TBAddressResult] = [TBAddressResult]()
                        appDelegate?.saveUserAllAddress(dic: arrAddressList)
                        
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
                        appDelegate?.saveCmsAdverd(dic: TBCmsAdverdResult())
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

extension HomeVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMasterCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "InfluencersListCell") as! InfluencersListCell
        
        let dicData = arrMasterCategories[indexPath.row]
        
        cell.lblName.text = dicData.name ?? ""
        
        var media_link_url = "\(dicData.image ?? "")"
        media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        cell.imgPic.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dicData = arrMasterCategories[indexPath.row]
        let mainS = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "SubCategoriesVC") as! SubCategoriesVC
        vc.strCategoryID = "\(dicData.id ?? 0)"
        vc.isStepWise = false
        vc.strTitle = dicData.name ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionSlider
        {
            return arrBannersList.count
        }
        else if collectionView == collectionInfu
        {
            return arrInfluencersList.count
        }
        else
        {
            return arrCategoriesStepWise.count
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
            if let collectionView = scrollView as? UICollectionView {
                switch collectionView.tag {
                case 7:
                    let currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
                    pageCont.currentPage = Int(currentPage)
                default:
                    print("unknown")
                }
            } else{
                print("cant cast")
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionSlider
        {
            let cell = self.collectionSlider.dequeueReusableCell(withReuseIdentifier: "SilderCell", for: indexPath) as! SilderCell
            
            let dicData = arrBannersList[indexPath.row]
            
            var media_link_url = "\(dicData.image ?? "")"
            media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            cell.imgPic.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
            
            return cell
        }
        else if collectionView == collectionInfu
        {
            let cell = self.collectionInfu.dequeueReusableCell(withReuseIdentifier: "InfluencersCell", for: indexPath) as! InfluencersCell
            
            let dicData = arrInfluencersList[indexPath.row]
            
            var media_link_url = "\(dicData.image ?? "")"
            media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            cell.imgPic.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
            
            return cell
        }
        else
        {
            let cell = self.collectionContraction.dequeueReusableCell(withReuseIdentifier: "ConstructionCell", for: indexPath) as! ConstructionCell
            
            let dicData = arrCategoriesStepWise[indexPath.row]
            
            cell.lblName.text = dicData.name ?? ""
            
            var media_link_url = "\(dicData.image ?? "")"
            media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            cell.imgPic.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionSlider
        {
            let dicData = arrBannersList[indexPath.row]
            
            if dicData.type == "2"
            {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
                vc.strProductID = dicData.value ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if dicData.type == "1"
            {
                if let url = URL(string: dicData.value ?? "") {
                    UIApplication.shared.open(url)
                }
            }
        }
        else if collectionView == collectionContraction
        {
            let dicData = arrCategoriesStepWise[indexPath.row]
            let mainS = UIStoryboard(name: "Home", bundle: nil)
            let vc = mainS.instantiateViewController(withIdentifier: "SubCategoriesVC") as! SubCategoriesVC
            vc.strCategoryID = "\(dicData.id ?? 0)"
            vc.isStepWise = true
            vc.strTitle = dicData.name ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if collectionView == collectionInfu
        {
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
    
    
}


class InfluencersCell: UICollectionViewCell
{
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imgPic: UIImageView!
}


