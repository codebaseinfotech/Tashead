//
//  AddressVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 02/06/23.
//

import UIKit
import LGSideMenuController
import DropDown
import CoreLocation
import MapKit
import GoogleMaps

class AddressVC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, onUpdateAddress {
    
    @IBOutlet weak var viewCurrentLoca: UIView!
    
    @IBOutlet weak var viewEdit: UIView!
    
    @IBOutlet weak var btnMapGes: UIButton!
    @IBOutlet weak var mapViewHeighCont: NSLayoutConstraint!
    @IBOutlet weak var btnConfrimPopupMap: UIButton!
    
    @IBOutlet weak var lblNewAddress: UILabel!
    @IBOutlet weak var viewAddAddress: UIView!
    @IBOutlet weak var viewAddressList: UIView!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    // Add Address
    @IBOutlet weak var vieWAddAddressTop: UIView!
    @IBOutlet weak var txtAddressNam: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    @IBOutlet weak var txtBlock: UITextField!
    @IBOutlet weak var txtSrteet: UITextField!
    @IBOutlet weak var txtAvenue: UITextField!
    @IBOutlet weak var txtBulddingNo: UITextField!
    @IBOutlet weak var txtFloor: UITextField!
    @IBOutlet weak var txtApartmentNo: UITextField!
    
    @IBOutlet weak var txtGov: UITextField!
    
    // AddressList
    
    @IBOutlet weak var viewAddressListTop: UIView!
    @IBOutlet weak var tblViewAddress: UITableView!
    
    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var lblTChooseAddress: UILabel!
    @IBOutlet weak var lblTSelectLoc: UILabel!
    
    @IBOutlet weak var btnTAddAddress: UIButton!
    
    // var
    
    var selectedAddress = -1
    
    var isAddProfileAddress = false
    
    var isUpdateProfile = false
    
    var arrAreaList: [TBGovernoratesArea] = [TBGovernoratesArea]()
    var arrGovernorates: [TBGovernoratesResult] = [TBGovernoratesResult]()
    
    var dropDown = DropDown()
    var dropGovernorates = DropDown()
    
    var strArea_id = ""
    var strGovernorates_id = ""
    
    var dicAddressDetail = TBAddressResult()
    
    var delegateAddress: onUpdateAddress?
    
    var arrAddressList : [TBAddressResult] = [TBAddressResult]()
    
    var isGotoPayment = false
    
    var strQty = 0
    var strpro_Id = 0
    
    var delegatePro: ProdDelegate?
    
    var isModify = false
    
    let locationManager = CLLocationManager()
    
    var objLatitude = ""
    var objLongitude = ""
    
    var currentLocationMarker: GMSMarker = GMSMarker()
    
    var isCurrentLocationChanged = false
    
    var objCart = TBCartListResult()
    
    var cart_id_ = 0
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lblNewAddress.text = "New address".localizeString(string: Language.shared.currentAppLang)
        lblTChooseAddress.text = "Choose delivery address".localizeString(string: Language.shared.currentAppLang)
        lblTSelectLoc.text = "Select your location ( Optional )".localizeString(string: Language.shared.currentAppLang)
        
        txtAddressNam.placeholder = "Address name".localizeString(string: Language.shared.currentAppLang)
        txtGov.placeholder = "Governorates*".localizeString(string: Language.shared.currentAppLang)
        txtArea.placeholder = "Area*".localizeString(string: Language.shared.currentAppLang)
        txtBlock.placeholder = "Block*".localizeString(string: Language.shared.currentAppLang)
        txtSrteet.placeholder = "Street*".localizeString(string: Language.shared.currentAppLang)
        txtAvenue.placeholder = "Avenue ( Optional )".localizeString(string: Language.shared.currentAppLang)
        txtBulddingNo.placeholder = "Building number*".localizeString(string: Language.shared.currentAppLang)
        txtFloor.placeholder = "Floor ( Optional )".localizeString(string: Language.shared.currentAppLang)
        txtApartmentNo.placeholder = "Apartment number ( Optional )".localizeString(string: Language.shared.currentAppLang)
        
        btnAdd.setTitle("Add".localizeString(string: Language.shared.currentAppLang), for: .normal)
        btnTAddAddress.setTitle("Add new address".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        
        let attributedStringtxtFirstName1 = NSMutableAttributedString(string: txtGov.placeholder ?? "")
        let lastCharacterIndextxtFirstName1 = attributedStringtxtFirstName1.length - 1
        let otherCharactersRangetxtFirstName1 = NSRange(location: 0, length: lastCharacterIndextxtFirstName1)
        attributedStringtxtFirstName1.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: lastCharacterIndextxtFirstName1, length: 1))
        attributedStringtxtFirstName1.addAttribute(.foregroundColor, value: UIColor.lightGray, range: otherCharactersRangetxtFirstName1)
        txtGov.attributedPlaceholder = attributedStringtxtFirstName1
        
        
        let attributedStringtxtFirstName2 = NSMutableAttributedString(string: txtArea.placeholder ?? "")
        let lastCharacterIndextxtFirstName2 = attributedStringtxtFirstName2.length - 1
        let otherCharactersRangetxtFirstName2 = NSRange(location: 0, length: lastCharacterIndextxtFirstName2)
        attributedStringtxtFirstName2.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: lastCharacterIndextxtFirstName2, length: 1))
        attributedStringtxtFirstName2.addAttribute(.foregroundColor, value: UIColor.lightGray, range: otherCharactersRangetxtFirstName2)
        txtArea.attributedPlaceholder = attributedStringtxtFirstName2
        
        
        let attributedStringtxtFirstName3 = NSMutableAttributedString(string: txtBlock.placeholder ?? "")
        let lastCharacterIndextxtFirstName3 = attributedStringtxtFirstName3.length - 1
        let otherCharactersRangetxtFirstName3 = NSRange(location: 0, length: lastCharacterIndextxtFirstName3)
        attributedStringtxtFirstName3.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: lastCharacterIndextxtFirstName3, length: 1))
        attributedStringtxtFirstName3.addAttribute(.foregroundColor, value: UIColor.lightGray, range: otherCharactersRangetxtFirstName3)
        txtBlock.attributedPlaceholder = attributedStringtxtFirstName3
        
        
        
        let attributedStringtxtFirstName4 = NSMutableAttributedString(string: txtSrteet.placeholder ?? "")
        let lastCharacterIndextxtFirstName4 = attributedStringtxtFirstName4.length - 1
        let otherCharactersRangetxtFirstName4 = NSRange(location: 0, length: lastCharacterIndextxtFirstName4)
        attributedStringtxtFirstName4.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: lastCharacterIndextxtFirstName4, length: 1))
        attributedStringtxtFirstName4.addAttribute(.foregroundColor, value: UIColor.lightGray, range: otherCharactersRangetxtFirstName4)
        txtSrteet.attributedPlaceholder = attributedStringtxtFirstName4
        
        
        let attributedStringtxtFirstName5 = NSMutableAttributedString(string: txtBulddingNo.placeholder ?? "")
        let lastCharacterIndextxtFirstName5 = attributedStringtxtFirstName5.length - 1
        let otherCharactersRangetxtFirstName5 = NSRange(location: 0, length: lastCharacterIndextxtFirstName5)
        attributedStringtxtFirstName5.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: lastCharacterIndextxtFirstName5, length: 1))
        attributedStringtxtFirstName5.addAttribute(.foregroundColor, value: UIColor.lightGray, range: otherCharactersRangetxtFirstName5)
        txtBulddingNo.attributedPlaceholder = attributedStringtxtFirstName5
        
        vieWAddAddressTop.clipsToBounds = true
        vieWAddAddressTop.layer.cornerRadius = 15
        vieWAddAddressTop.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        
        viewAddressListTop.clipsToBounds = true
        viewAddressListTop.layer.cornerRadius = 15
        viewAddressListTop.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        
        if Language.shared.isArabic {
            txtAddressNam.textAlignment = .right
            txtGov.textAlignment = .right
            txtArea.textAlignment = .right
            txtBlock.textAlignment = .right
            txtSrteet.textAlignment = .right
            txtAvenue.textAlignment = .right
            txtBulddingNo.textAlignment = .right
            txtFloor.textAlignment = .right
            txtApartmentNo.textAlignment = .right
            
            lblTSelectLoc.textAlignment = .right
        }
        else
        {
            txtAddressNam.textAlignment = .left
            txtGov.textAlignment = .left
            txtArea.textAlignment = .left
            txtBlock.textAlignment = .left
            txtSrteet.textAlignment = .left
            txtAvenue.textAlignment = .left
            txtBulddingNo.textAlignment = .left
            txtFloor.textAlignment = .left
            txtApartmentNo.textAlignment = .left
            
            lblTSelectLoc.textAlignment = .left
        }
        
        tblViewAddress.delegate = self
        tblViewAddress.dataSource = self
        
        if isAddProfileAddress == true
        {
            viewAddAddress.isHidden = false
            viewAddressList.isHidden = true
            
            if isUpdateProfile == true
            {
                isCurrentLocationChanged = true
                
                let camera = GMSCameraPosition.camera(withLatitude: Double(self.dicAddressDetail.latitude ?? "") ?? 0.0, longitude: Double(self.dicAddressDetail.longitude ?? "") ?? 0.0, zoom: 15.0)
                self.mapView?.camera = camera
               
                currentLocationMarker.position = CLLocationCoordinate2D(latitude: Double(self.dicAddressDetail.latitude ?? "") ?? 0.0, longitude: Double(self.dicAddressDetail.longitude ?? "") ?? 0.0)
                currentLocationMarker.icon = self.imageWithImage(image: UIImage(named: "maps-and-flags")!, scaledToSize: CGSize(width: 30, height: 35))
                currentLocationMarker.map = self.mapView
                
                
                lblNewAddress.text = "Update Address".localizeString(string: Language.shared.currentAppLang)
                btnAdd.setTitle("Update".localizeString(string: Language.shared.currentAppLang), for: .normal)
                
                self.strArea_id = "\(self.dicAddressDetail.areaId ?? "")"
                
                self.objLatitude = self.dicAddressDetail.latitude ?? ""
                self.objLongitude = self.dicAddressDetail.longitude ?? ""

                self.txtAddressNam.text = self.dicAddressDetail.address ?? ""
                self.txtArea.text = self.dicAddressDetail.areaName ?? ""
                self.txtBlock.text = self.dicAddressDetail.block ?? ""
                self.txtSrteet.text = self.dicAddressDetail.street ?? ""
                self.txtAvenue.text = self.dicAddressDetail.avenue ?? ""
                self.txtBulddingNo.text = self.dicAddressDetail.buildingNumber ?? ""
                self.txtFloor.text = self.dicAddressDetail.floor ?? ""
                self.txtApartmentNo.text = self.dicAddressDetail.apartment ?? ""
            }
            else
            {
                lblNewAddress.text = "New Address".localizeString(string: Language.shared.currentAppLang)
                
                btnAdd.setTitle("Add".localizeString(string: Language.shared.currentAppLang), for: .normal)
            }
        }else{
            viewAddAddress.isHidden = true
            viewAddressList.isHidden = false
        }
        
        callGovernoratesListAPI()
        
        DispatchQueue.main.async {
            
            self.mapView.overrideUserInterfaceStyle = .dark
            self.mapView.delegate = self
            
            self.mapView.isMyLocationEnabled = true
            self.mapView.settings.scrollGestures = true
            self.mapView.settings.zoomGestures = true
            
            
            if CLLocationManager.locationServicesEnabled(){
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.distanceFilter = 10
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.startUpdatingLocation()
            }
        }
        
        
        Task { [weak self] in

            if ((await self?.locationServicesEnabled()) != false) {
                // Do something
                self?.objLatitude = "\(appDelegate?.kuwaitCurrentLat ?? 0.0)"
                self?.objLongitude = "\(appDelegate?.kuwaitCurrentLong ?? 0.0)"
                
                let camera = GMSCameraPosition.camera(withLatitude: appDelegate?.kuwaitCurrentLat ?? 0.0, longitude: appDelegate?.kuwaitCurrentLong ?? 0.0, zoom: 15.0)
                self?.mapView?.camera = camera
                
                self?.currentLocationMarker.position = CLLocationCoordinate2D(latitude: appDelegate?.kuwaitCurrentLat ?? 0.0, longitude: appDelegate?.kuwaitCurrentLong ?? 0.0)
                self?.currentLocationMarker.icon = self?.imageWithImage(image: UIImage(named: "maps-and-flags")!, scaledToSize: CGSize(width: 30, height: 35))
                self?.currentLocationMarker.map = self?.mapView
                
                self?.getAddressFromLatLon(latitude: appDelegate?.kuwaitCurrentLat ?? 0.0, longitude: appDelegate?.kuwaitCurrentLong ?? 0.0)
            }
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callGetAddressAPI()
    }
    
    func setdropDowngovernorates()
    {
        var arrArea = NSMutableArray()
        
        for obj in arrGovernorates
        {
            arrArea.add(obj.name ?? "")
        }
        
        dropGovernorates.dataSource = arrArea as! [String]
        dropGovernorates.anchorView = txtGov
        dropGovernorates.direction = .bottom
        
        dropGovernorates.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.txtGov.text = item
            
            for obj in arrGovernorates
            {
                if item == obj.name
                {
                    self.strGovernorates_id = "\(obj.id ?? 0)"
                    self.arrAreaList = obj.areas
                    
                    self.txtArea.text = ""
                    
                    self.setdropDownArea()
                    
                    
                }
            }
        }
        
        dropGovernorates.bottomOffset = CGPoint(x: 0, y: txtGov.bounds.height)
        dropGovernorates.topOffset = CGPoint(x: 0, y: -txtGov.bounds.height)
        dropGovernorates.dismissMode = .onTap
        dropGovernorates.textColor = UIColor.black
        dropGovernorates.backgroundColor = UIColor(red: 255/255, green:  255/255, blue:  255/255, alpha: 1)
        dropGovernorates.selectionBackgroundColor = UIColor.clear
        
        dropGovernorates.reloadAllComponents()
    }
    
    func setdropDownArea()
    {
        let arrArea = NSMutableArray()
        
        for obj in arrAreaList
        {
            if Language.shared.isArabic {
                arrArea.add(obj.areaNameAr ?? "")
            } else {
                arrArea.add(obj.areaNameEn ?? "")
            }
        }
        
        dropDown.dataSource = arrArea as! [String]
        dropDown.anchorView = txtArea
        dropDown.direction = .bottom
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.txtArea.text = item
            
            for obj in arrAreaList
            {
                if item == obj.areaNameEn
                {
                    self.strArea_id = "\(obj.id ?? 0)"
                }
            }
        }
        
        dropDown.bottomOffset = CGPoint(x: 0, y: txtArea.bounds.height)
        dropDown.topOffset = CGPoint(x: 0, y: -txtArea.bounds.height)
        dropDown.dismissMode = .onTap
        dropDown.textColor = UIColor.black
        dropDown.backgroundColor = UIColor(red: 255/255, green:  255/255, blue:  255/255, alpha: 1)
        dropDown.selectionBackgroundColor = UIColor.clear
        
        dropDown.reloadAllComponents()
    }
    
    // Add Address
    
    @IBAction func clickedCurrentLoca(_ sender: Any) {
        isCurrentLocationChanged = false
        
        DispatchQueue.main.async {
 
            if CLLocationManager.locationServicesEnabled(){
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.distanceFilter = 10
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.stopUpdatingLocation()
                 self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    @IBAction func clickedConfrimMapPopup(_ sender: Any) {
        mapViewHeighCont.constant = 130
        viewEdit.isHidden = false
        
        btnConfrimPopupMap.isHidden = true
        
        btnMapGes.isHidden = false
        viewCurrentLoca.isHidden = true

        isCurrentLocationChanged = true
       
        let camera7 = GMSCameraPosition.camera(withLatitude: Double(objLatitude) ?? 0.0, longitude: Double(objLongitude) ?? 0.0, zoom: 15.0)
        self.mapView?.camera = camera7
        
        currentLocationMarker.position = CLLocationCoordinate2D(latitude: Double(objLatitude) ?? 0.0, longitude: Double(objLongitude) ?? 0.0)
        currentLocationMarker.icon = self.imageWithImage(image: UIImage(named: "maps-and-flags")!, scaledToSize: CGSize(width: 30, height: 35))
        currentLocationMarker.map = self.mapView
    }
    
    @IBAction func clickedEditMap(_ sender: Any) {
        mapViewHeighCont.constant = 350
        viewEdit.isHidden = true
        
        viewCurrentLoca.isHidden = false
 
        btnConfrimPopupMap.isHidden = false
        
        btnMapGes.isHidden = true
    }
    
    
    @IBAction func clickedGov(_ sender: Any) {
        dropGovernorates.show()
    }
    
    @IBAction func clickedArea(_ sender: Any) {
        dropDown.show()
    }
     
    
    @IBAction func clickedAdd(_ sender: Any) {
        if isAddProfileAddress == true
        {
            if self.strArea_id == ""
            {
                self.setUpMakeToast(msg: "Please select area".localizeString(string: Language.shared.currentAppLang))
            }
            else if txtBlock.text == ""
            {
                self.setUpMakeToast(msg: "Please enter block".localizeString(string: Language.shared.currentAppLang))
            }
            else if txtSrteet.text == ""
            {
                self.setUpMakeToast(msg: "Please enter street".localizeString(string: Language.shared.currentAppLang))
            }
            //            else if txtAvenue.text == ""
            //            {
            //                self.setUpMakeToast(msg: "Enter avenue")
            //            }
            else if txtBulddingNo.text == ""
            {
                self.setUpMakeToast(msg: "Please enter buliding number".localizeString(string: Language.shared.currentAppLang))
            }
            else if objLatitude == ""
            {
                DispatchQueue.main.async {
                    self.showPermissionAlert()
                }
            }
            //            else if txtFloor.text == ""
            //            {
            //                self.setUpMakeToast(msg: "Enter floor")
            //            }
            //            else if txtApartmentNo.text == ""
            //            {
            //                self.setUpMakeToast(msg: "Enter apartment number")
            //            }
            else
            {
                callCreateAddressAPI()
            }
        }else{
            if self.strArea_id == ""
            {
                self.setUpMakeToast(msg: "Please select area".localizeString(string: Language.shared.currentAppLang))
            }
            else if txtBlock.text == ""
            {
                self.setUpMakeToast(msg: "Please enter block".localizeString(string: Language.shared.currentAppLang))
            }
            else if txtSrteet.text == ""
            {
                self.setUpMakeToast(msg: "Please enter street".localizeString(string: Language.shared.currentAppLang))
            }
            else if txtBulddingNo.text == ""
            {
                self.setUpMakeToast(msg: "Please enter buliding number".localizeString(string: Language.shared.currentAppLang))
            }
            if objLatitude == ""
            {
                DispatchQueue.main.async {
                    self.showPermissionAlert()
                }
            }
            else
            {
                callCreateAddressAPI()
            }
        }
    }
    @IBAction func clickedClose(_ sender: Any) {
        viewAddAddress.isHidden = true
        viewAddressList.isHidden = false
        
        if isAddProfileAddress == true{
            self.dismiss(animated: false)
        }
    }
    
    
    @IBAction func clickedHidePopAddress(_ sender: Any) {
        viewAddAddress.isHidden = true
        viewAddressList.isHidden = true
        self.dismiss(animated: false)
    }
    
    
    
    // AddressList
    
    @IBAction func clickedAddNewAddres(_ sender: Any)
    {
        viewAddressList.isHidden = true
        viewAddAddress.isHidden = false
        
        mapViewHeighCont.constant = 130
        viewEdit.isHidden = false
        
        btnConfrimPopupMap.isHidden = true
        
        btnMapGes.isHidden = false
        viewCurrentLoca.isHidden = true

        isCurrentLocationChanged = false
        
        DispatchQueue.main.async {
            
            self.mapView.overrideUserInterfaceStyle = .dark
            self.mapView.delegate = self
            
            self.mapView.isMyLocationEnabled = true
            self.mapView.settings.scrollGestures = true
            self.mapView.settings.zoomGestures = true
 
            if CLLocationManager.locationServicesEnabled(){
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.distanceFilter = 10
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    func showPermissionAlert(){
        let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        })
        let cancelAction = UIAlertAction(title: "Don't allow", style: .default, handler: {(cAlertAction) in
            DispatchQueue.main.async {
                
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
    
    // MARK: - calling API
    
    func callGovernoratesListAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderPost(GET_GOVERNARATES, parameters: param) { response, error, statusCode in
            
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
                                let dicData = TBGovernoratesResult(fromDictionary: obj as! NSDictionary)
                                
                                self.arrGovernorates.append(dicData)
                            }
                        }
                        
                        if self.isUpdateProfile == true
                        {
                            for obj in self.arrGovernorates
                            {
                                if self.dicAddressDetail.governorateId == obj.id
                                {
                                    self.txtGov.text = obj.name ?? ""
                                    self.strGovernorates_id = "\(obj.id ?? 0)"
                                    self.arrAreaList = obj.areas
                                    self.setdropDownArea()
                                }
                            }
                        }
                        
                        
                        self.setdropDowngovernorates()
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
    
    func callAreaListAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["governorate_id":"1"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderPost(AREA_LIST, parameters: param) { response, error, statusCode in
            
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
                                let dicData = TBGovernoratesArea(fromDictionary: obj as! NSDictionary)
                                self.arrAreaList.append(dicData)
                            }
                        }
                        self.setdropDownArea()
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
    
    func callModifytoCartAPI(address_id: String,cart_id: String)
    {
        
        let param = ["cart_id":cart_id,"address_id":address_id]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(MODIFY_CART_INFO, parameters: param) { response, error, statusCode in
            
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
                        self.setUpMakeToast(msg: "Item successfully added in cart".localizeString(string: Language.shared.currentAppLang))
                        
                        self.delegatePro?.onProdReady(type: "fd")
                        
                        self.dismiss(animated: false)
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
    
    func callAddtoCartAPI(qty: Int,pro_Id: Int,address:Int)
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["product_price_id":"\(pro_Id)","quantity":"\(qty)","device_id":"12323213","ip":"202.200.20.23"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(CREATE_CART, parameters: param) { response, error, statusCode in
            
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
                        self.callGetCartAPI(address_id: "\(address ?? 0)")
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
    
    func callGetCartAPI(address_id: String)
    {
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(GET_MY_CART_BY_USER, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                var arrCart: [TBCartListCartItem] = [TBCartListCartItem]()
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        if let dicResult = response?.value(forKey: "result") as? NSDictionary
                        {
                            self.cart_id_ = (dicResult.value(forKey: "cart_id") as? Int) ?? 0
                            
                            if let arrCartItems = dicResult.value(forKey: "cart_items") as? NSArray
                            {
                                for obj in arrCartItems
                                {
                                    let dicData = TBCartListCartItem(fromDictionary: obj as! NSDictionary)
                                    arrCart.append(dicData)
                                }
                            }
                            
                            appDelegate?.strTotalCount = "\(arrCart.count)"
                            
                            self.callModifytoCartAPI(address_id: address_id, cart_id: "\(self.cart_id_ ?? 0)")
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
    
    
    func callGetAddressAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
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
                            for (index,objDic) in arrResult.enumerated()
                            {
                                let dicData = TBAddressResult(fromDictionary: (objDic as? NSDictionary)!)
                                
                                if self.isGotoPayment == true
                                {
                                    if appDelegate?.is_default == dicData.id
                                    {
                                        self.selectedAddress = index
                                    }
                                }
                                
                                self.arrAddressList.append(dicData)
                            }
                        }
                        
                        appDelegate?.saveUserAllAddress(dic: self.arrAddressList)
                        self.tblViewAddress.reloadData()
                    }
                    else
                    {
                        self.arrAddressList.removeAll()
                        self.tblViewAddress.reloadData()
                        appDelegate?.saveUserAllAddress(dic: self.arrAddressList)
                        
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
                    
                    self.arrAddressList.removeAll()
                    self.tblViewAddress.reloadData()
                    appDelegate?.saveUserAllAddress(dic: self.arrAddressList)
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
                
                self.arrAddressList.removeAll()
                self.tblViewAddress.reloadData()
                appDelegate?.saveUserAllAddress(dic: self.arrAddressList)
            }
        }
    }
    
    func callCreateAddressAPI()
    {
        // APIClient.sharedInstance.showIndicator()
        
        let user_id = "\(appDelegate?.dicCurrentLoginUser.id ?? 0)"
        
        let area_id = self.strArea_id
        
        let address = self.txtAddressNam.text ?? ""
        
        let block = self.txtBlock.text ?? ""
        
        let street = self.txtSrteet.text ?? ""
        
        let avenue = self.txtAvenue.text ?? ""
        
        let building_number = self.txtBulddingNo.text ?? ""
        
        let floor = self.txtFloor.text ?? ""
        
        let apartment = self.txtApartmentNo.text ?? ""
        
        let latitude = self.objLatitude
        
        let longitude = self.objLongitude
        
        let param = ["user_id":"\(user_id)","area_id":"\(area_id)","address":address,"block":block,"street":street,"avenue":avenue,"building_number":building_number,"floor":floor,"apartment":apartment,"latitude":latitude,"longitude":longitude]
        
        var _url = ""
        
        if isUpdateProfile == true{
            _url = "\(EDIT_ADDRESS)\(self.dicAddressDetail.id ?? 0)"
        }else{
            _url = CREATE_ADDRESS
        }
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(_url, parameters: param) { response, error, statusCode in
            
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
                        APIClient.sharedInstance.hideIndicator()
                        self.setUpMakeToast(msg: message ?? "")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.delegateAddress?.updateAddress(isUpdate: true, id: self.dicAddressDetail.id ?? 0)
                            self.dismiss(animated: false)
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
    
    func getAddressFromLatLon(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler:
                                                {(placemarks, error) in
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            
            if placemarks != nil {
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country)
                    print(pm.locality)
                    print(pm.subLocality)
                    print(pm.thoroughfare)
                    print(pm.postalCode)
                    print(pm.subThoroughfare)
                    
                    var addressString : String = ""
                    if pm.subThoroughfare != nil {
                        // Building number
                        addressString = addressString + pm.subThoroughfare! + ", "
                        self.txtBulddingNo.text = "\(pm.thoroughfare!)"
                        
                    }
                    if pm.thoroughfare != nil {
                        //// Street name
                        addressString = addressString + pm.thoroughfare! + ", "
                        self.txtSrteet.text = "\(pm.thoroughfare!)"
                    }
                    if pm.subLocality != nil {
                        //// block
                        addressString = addressString + pm.subLocality! + ", "
                        self.txtBlock.text = "\(pm.subLocality!)"
                    }
                    if pm.locality != nil {
                        // City name
                        addressString = addressString + pm.locality! + ", "
                    }
                    
                    if pm.administrativeArea != nil {
                        // State
                        addressString = addressString + pm.administrativeArea! + ", "
                    }
                    
                    if pm.subAdministrativeArea != nil {
                        addressString = addressString + pm.subAdministrativeArea! + ", "
                        self.txtApartmentNo.text = "\(pm.subAdministrativeArea!)"
                    }
                    
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        // Postal code
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    //self.strGetCurrentLocationAddress = addressString
                    //print(addressString)
//                    self.txtAddressNam.text = addressString
                }
                
            }
            
            
        })
    }
    
    func locationServicesEnabled() async -> Bool {
        CLLocationManager.locationServicesEnabled()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            // Handle location permission granted
            print("Location permission granted")
            // You can start using location services here
        case .denied:
            // Handle location permission denied
            print("Location permission denied")
            self.objLatitude = "\(appDelegate?.kuwaitCurrentLat ?? 0.0)"
            self.objLongitude = "\(appDelegate?.kuwaitCurrentLong ?? 0.0)"
            
            let camera = GMSCameraPosition.camera(withLatitude: appDelegate?.kuwaitCurrentLat ?? 0.0, longitude: appDelegate?.kuwaitCurrentLong ?? 0.0, zoom: 15.0)
            self.mapView?.camera = camera
            
            self.currentLocationMarker.position = CLLocationCoordinate2D(latitude: appDelegate?.kuwaitCurrentLat ?? 0.0, longitude: appDelegate?.kuwaitCurrentLong ?? 0.0)
            self.currentLocationMarker.icon = self.imageWithImage(image: UIImage(named: "maps-and-flags")!, scaledToSize: CGSize(width: 30, height: 35))
            self.currentLocationMarker.map = self.mapView
            
            self.getAddressFromLatLon(latitude: appDelegate?.kuwaitCurrentLat ?? 0.0, longitude: appDelegate?.kuwaitCurrentLong ?? 0.0)
            
            //showLocationPermissionAlert()
        case .notDetermined:
            // Handle location permission not determined
            print("Location permission not determined")
            self.objLatitude = "\(appDelegate?.kuwaitCurrentLat ?? 0.0)"
            self.objLongitude = "\(appDelegate?.kuwaitCurrentLong ?? 0.0)"
            
            let camera = GMSCameraPosition.camera(withLatitude: appDelegate?.kuwaitCurrentLat ?? 0.0, longitude: appDelegate?.kuwaitCurrentLong ?? 0.0, zoom: 15.0)
            self.mapView?.camera = camera
            
            self.currentLocationMarker.position = CLLocationCoordinate2D(latitude: appDelegate?.kuwaitCurrentLat ?? 0.0, longitude: appDelegate?.kuwaitCurrentLong ?? 0.0)
            self.currentLocationMarker.icon = self.imageWithImage(image: UIImage(named: "maps-and-flags")!, scaledToSize: CGSize(width: 30, height: 35))
            self.currentLocationMarker.map = self.mapView
            
            self.getAddressFromLatLon(latitude: appDelegate?.kuwaitCurrentLat ?? 0.0, longitude: appDelegate?.kuwaitCurrentLong ?? 0.0)
            
        case .restricted:
            // Handle location permission restricted
            print("Location permission restricted")
            self.objLatitude = "\(appDelegate?.kuwaitCurrentLat ?? 0.0)"
            self.objLongitude = "\(appDelegate?.kuwaitCurrentLong ?? 0.0)"
            
            let camera = GMSCameraPosition.camera(withLatitude: appDelegate?.kuwaitCurrentLat ?? 0.0, longitude: appDelegate?.kuwaitCurrentLong ?? 0.0, zoom: 15.0)
            self.mapView?.camera = camera
            
            self.currentLocationMarker.position = CLLocationCoordinate2D(latitude: appDelegate?.kuwaitCurrentLat ?? 0.0, longitude: appDelegate?.kuwaitCurrentLong ?? 0.0)
            self.currentLocationMarker.icon = self.imageWithImage(image: UIImage(named: "maps-and-flags")!, scaledToSize: CGSize(width: 30, height: 35))
            self.currentLocationMarker.map = self.mapView
            
            self.getAddressFromLatLon(latitude: appDelegate?.kuwaitCurrentLat ?? 0.0, longitude: appDelegate?.kuwaitCurrentLong ?? 0.0)
            
        @unknown default:
            break
        }
    }
    
    // MARK: -  Cuurent Location
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        currentLocationMarker.position = position.target
        self.objLatitude = String(currentLocationMarker.position.latitude)
        self.objLongitude = String(currentLocationMarker.position.longitude)
        
        currentLocationMarker.icon = self.imageWithImage(image: UIImage(named: "maps-and-flags")!, scaledToSize: CGSize(width: 30, height: 35))
        currentLocationMarker.map = self.mapView
        self.currentLocationMarker.isDraggable = true
        
        getAddressFromLatLon(latitude: currentLocationMarker.position.latitude, longitude: currentLocationMarker.position.longitude)
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        if isCurrentLocationChanged == false
        {
            objLatitude = "\(location?.coordinate.latitude ?? 0.0)"
            objLongitude = "\(location?.coordinate.longitude ?? 0.0)"
            
            let camera = GMSCameraPosition.camera(withLatitude: location?.coordinate.latitude ?? 0.0, longitude: location?.coordinate.longitude ?? 0.0, zoom: 15.0)
            self.mapView?.camera = camera
            
            currentLocationMarker.position = CLLocationCoordinate2D(latitude: location?.coordinate.latitude ?? 0.0, longitude: location?.coordinate.longitude ?? 0.0)
            currentLocationMarker.icon = self.imageWithImage(image: UIImage(named: "maps-and-flags")!, scaledToSize: CGSize(width: 30, height: 35))
            currentLocationMarker.map = self.mapView
        }
        
    }
}

extension AddressVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAddressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblViewAddress.dequeueReusableCell(withIdentifier: "AddressListCell") as! AddressListCell
        
        let dicData = arrAddressList[indexPath.row]
        
        let address = dicData.address ?? ""
        let block = dicData.block ?? ""
        let street = dicData.street ?? ""
        let avenue = dicData.avenue ?? ""
        let building_number = dicData.buildingNumber ?? ""
        let floor = dicData.floor ?? ""
        let apartment = dicData.apartment ?? ""
        
        cell.btnEdit.setTitle("Edit".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        cell.lblType.text = dicData.address ?? ""
        
        cell.lblName.text = dicData.areaName ?? ""
        
        let Block_lan = "Block".localizeString(string: Language.shared.currentAppLang)
        let Street_lan = "Street".localizeString(string: Language.shared.currentAppLang)
        let Building_lan = "Building".localizeString(string: Language.shared.currentAppLang)
        
        cell.lblAddress.text = "\(Block_lan) \(block),\(Street_lan) \(street),\(Building_lan) \(building_number)"
        
        
        if Language.shared.currentAppLang == "en" {
            cell.lblAddress.textAlignment = .left
        }
        else {
            cell.lblAddress.textAlignment = .right
        }
        
        if appDelegate?.getUserSelectedAddress().id == dicData.id
        {
            cell.imgCheck.isHidden = false
        }
        else
        {
            cell.imgCheck.isHidden = true
        }
        
        cell.btnEdit.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(clickedEditAddress(_ :)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func clickedEditAddress(_ sender: UIButton)
    {
        let dicData = arrAddressList[sender.tag]
        
        let mainS = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "AddressVC") as! AddressVC
        vc.isAddProfileAddress = true
        vc.isUpdateProfile = true
        vc.dicAddressDetail = dicData
        vc.delegateAddress = self
        let home = UINavigationController(rootViewController: vc)
        home.modalPresentationStyle = .overFullScreen
        self.present(home, animated: false)
    }
    
    func updateAddress(isUpdate: Bool, id: Int) {
        if isUpdate == true{
            callGetAddressAPI()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let dicData = arrAddressList[indexPath.row]
        
        if dicData.isDeliveryAvailable == 1
        {
            selectedAddress = indexPath.row
            self.tblViewAddress.reloadData()

            appDelegate?.saveUserSelectedAddress(dic: dicData)
            
            if isModify == true
            {
                appDelegate?.is_default = dicData.id ?? 0
                callAddtoCartAPI(qty: strQty, pro_Id: strpro_Id, address: dicData.id)
            }
            else
            {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    
                    if self.isGotoPayment == true
                    {
                        self.delegateAddress?.updateAddress(isUpdate: false, id: dicData.id ?? 0)
                        
                        self.callModifytoCartAPI(address_id: "\(dicData.id ?? 0)", cart_id: "\(self.cart_id_ ?? 0)")
                    }
                    
                    self.dismiss(animated: true)
                }
            }
        }
        else
        {
            let areaName = "\"\(dicData.areaName ?? "")\""

            let mainS =  UIStoryboard(name: "Home", bundle: nil)
            let vc = mainS.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
            vc.modalPresentationStyle = .overFullScreen
            vc.isAreYou = true
            vc.strTitle = "\("Unfortunately, currently delivery services not available for".localizeString(string: Language.shared.currentAppLang)) \(areaName)"
            self.present(vc, animated: false)
        }
 
    }
}

class AddressListCell: UITableViewCell
{
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var imgCheck: UIImageView!
}

