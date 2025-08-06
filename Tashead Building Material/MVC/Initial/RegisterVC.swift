//
//  RegisterVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 01/06/23.
//

import UIKit
import LGSideMenuController
import DropDown
import CoreLocation
import MapKit
import GoogleMaps

class RegisterVC: UIViewController, CLLocationManagerDelegate, UITextViewDelegate, GMSMapViewDelegate {
    
    
    @IBOutlet weak var viewMapHiest: NSLayoutConstraint!
    
    
    @IBOutlet weak var btnMapGes: UIButton!
    
    @IBOutlet weak var viewCurrentMap: UIView!
    @IBOutlet weak var viewEditMap: UIView!
    
    @IBOutlet weak var btnConfirmMap: UIButton!
    
    @IBOutlet weak var viewDetailss: UIView!
    
    @IBOutlet weak var viewPass: UIView!
    @IBOutlet weak var viewConfirmPass: UIView!
    
    @IBOutlet weak var viewCountItem: UIView!
    @IBOutlet weak var mainView1: UIView!
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtCPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var imgCheck: UIImageView!
    
    // Address View
    
    @IBOutlet weak var viewAddressMain: UIView!
    @IBOutlet weak var viewAddressTop: UIView!
    @IBOutlet weak var txtAddrerssName: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    @IBOutlet weak var txtGovernorates: UITextField!
    
    @IBOutlet weak var imgArea: UIImageView!
    @IBOutlet weak var txtBlock: UITextField!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtAvenue: UITextField!
    @IBOutlet weak var txtBuliddingName: UITextField!
    @IBOutlet weak var txtFloor: UITextField!
    @IBOutlet weak var txtApartmentNo: UITextField!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    // Outlet Title
    
    @IBOutlet weak var lblTDAddress: UILabel!
    @IBOutlet weak var lblTSelectLoation: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnAddAddress: UIButton!
    @IBOutlet weak var lblTTC: UILabel!
    @IBOutlet weak var btnTCreateAccount: UIButton!
    
    var arrAreaList: [TBGovernoratesArea] = [TBGovernoratesArea]()
    var arrGovernorates: [TBGovernoratesResult] = [TBGovernoratesResult]()
    
    var strMobileNo = ""
    
    var strArea_id = ""
    var strGovernorates_id = ""
    
    var dropDown = DropDown()
    var dropGovernorates = DropDown()
    
    let locationManager = CLLocationManager()
    
    var objLatitude = ""
    var objLongitude = ""
    
    var currentLocationMarker: GMSMarker = GMSMarker()
    
    var isCurrentLocationChanged = false
    
    var isFromHome = false
    var selectViewContrller = UIViewController()
    
    var isGuestLogin = false
    
    var isSocialLogin = false
    
    var socialId = ""
    var socialDevice = ""
    var strName = ""
    var strEmail = ""
    
    // MARK: - viewdidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtFName.text = self.strName
        self.txtEmail.text = self.strEmail

        if isGuestLogin == true {
            viewPass.isHidden = true
            viewConfirmPass.isHidden = true
            btnTCreateAccount.setTitle("Continue as a guest".localizeString(string: Language.shared.currentAppLang), for: .normal)
         }
        else {
            btnTCreateAccount.setTitle("Create Account!".localizeString(string: Language.shared.currentAppLang), for: .normal)
         }
        
        if isSocialLogin == true {
            viewPass.isHidden = true
            viewConfirmPass.isHidden = true
            self.txtEmail.isUserInteractionEnabled = false
        }
        
        lblTDAddress.text = "Delivery Address".localizeString(string: Language.shared.currentAppLang)
        lblTTC.text = "Terms & conditions approval".localizeString(string: Language.shared.currentAppLang)
        lblTSelectLoation.text = "Select your location ( Optional )".localizeString(string: Language.shared.currentAppLang)
        
        btnAddAddress.setTitle("Add delivery address".localizeString(string: Language.shared.currentAppLang), for: .normal)
        btnAdd.setTitle("Add".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        txtFName.placeholder = "Full name*".localizeString(string: Language.shared.currentAppLang)
        txtPassword.placeholder = "Password*".localizeString(string: Language.shared.currentAppLang)
        txtCPassword.placeholder = "Confirm password*".localizeString(string: Language.shared.currentAppLang)
        txtEmail.placeholder = "Email".localizeString(string: Language.shared.currentAppLang)
        
        txtAddrerssName.placeholder = "Address name".localizeString(string: Language.shared.currentAppLang)
        txtGovernorates.placeholder = "Governorates*".localizeString(string: Language.shared.currentAppLang)
        txtArea.placeholder = "Area*".localizeString(string: Language.shared.currentAppLang)
        txtBlock.placeholder = "Block*".localizeString(string: Language.shared.currentAppLang)
        txtStreet.placeholder = "Street*".localizeString(string: Language.shared.currentAppLang)
        txtAvenue.placeholder = "Avenue ( Optional )".localizeString(string: Language.shared.currentAppLang)
        txtBuliddingName.placeholder = "Building number*".localizeString(string: Language.shared.currentAppLang)
        txtFloor.placeholder = "Floor ( Optional )".localizeString(string: Language.shared.currentAppLang)
        txtApartmentNo.placeholder = "Apartment number ( Optional )".localizeString(string: Language.shared.currentAppLang)
        
        
        let attributedStringtxtFirstName7 = NSMutableAttributedString(string: txtFName.placeholder ?? "")
        let lastCharacterIndextxtFirstName7 = attributedStringtxtFirstName7.length - 1
        let otherCharactersRangetxtFirstName7 = NSRange(location: 0, length: lastCharacterIndextxtFirstName7)
        attributedStringtxtFirstName7.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: lastCharacterIndextxtFirstName7, length: 1))
        attributedStringtxtFirstName7.addAttribute(.foregroundColor, value: UIColor.lightGray, range: otherCharactersRangetxtFirstName7)
        txtFName.attributedPlaceholder = attributedStringtxtFirstName7
        
        
        let attributedStringtxtFirstName8 = NSMutableAttributedString(string: txtPassword.placeholder ?? "")
        let lastCharacterIndextxtFirstName8 = attributedStringtxtFirstName8.length - 1
        let otherCharactersRangetxtFirstName8 = NSRange(location: 0, length: lastCharacterIndextxtFirstName8)
        attributedStringtxtFirstName8.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: lastCharacterIndextxtFirstName8, length: 1))
        attributedStringtxtFirstName8.addAttribute(.foregroundColor, value: UIColor.lightGray, range: otherCharactersRangetxtFirstName8)
        txtPassword.attributedPlaceholder = attributedStringtxtFirstName8
        
        let attributedStringtxtFirstName88 = NSMutableAttributedString(string: txtCPassword.placeholder ?? "")
        let lastCharacterIndextxtFirstName88 = attributedStringtxtFirstName88.length - 1
        let otherCharactersRangetxtFirstName88 = NSRange(location: 0, length: lastCharacterIndextxtFirstName88)
        attributedStringtxtFirstName88.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: lastCharacterIndextxtFirstName88, length: 1))
        attributedStringtxtFirstName88.addAttribute(.foregroundColor, value: UIColor.lightGray, range: otherCharactersRangetxtFirstName88)
        txtCPassword.attributedPlaceholder = attributedStringtxtFirstName88
        
        
        let attributedStringtxtFirstName1 = NSMutableAttributedString(string: txtGovernorates.placeholder ?? "")
        let lastCharacterIndextxtFirstName1 = attributedStringtxtFirstName1.length - 1
        let otherCharactersRangetxtFirstName1 = NSRange(location: 0, length: lastCharacterIndextxtFirstName1)
        attributedStringtxtFirstName1.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: lastCharacterIndextxtFirstName1, length: 1))
        attributedStringtxtFirstName1.addAttribute(.foregroundColor, value: UIColor.lightGray, range: otherCharactersRangetxtFirstName1)
        txtGovernorates.attributedPlaceholder = attributedStringtxtFirstName1
        
        
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
        
        
        
        let attributedStringtxtFirstName4 = NSMutableAttributedString(string: txtStreet.placeholder ?? "")
        let lastCharacterIndextxtFirstName4 = attributedStringtxtFirstName4.length - 1
        let otherCharactersRangetxtFirstName4 = NSRange(location: 0, length: lastCharacterIndextxtFirstName4)
        attributedStringtxtFirstName4.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: lastCharacterIndextxtFirstName4, length: 1))
        attributedStringtxtFirstName4.addAttribute(.foregroundColor, value: UIColor.lightGray, range: otherCharactersRangetxtFirstName4)
        txtStreet.attributedPlaceholder = attributedStringtxtFirstName4
        
        
        let attributedStringtxtFirstName5 = NSMutableAttributedString(string: txtBuliddingName.placeholder ?? "")
        let lastCharacterIndextxtFirstName5 = attributedStringtxtFirstName5.length - 1
        let otherCharactersRangetxtFirstName5 = NSRange(location: 0, length: lastCharacterIndextxtFirstName5)
        attributedStringtxtFirstName5.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: lastCharacterIndextxtFirstName5, length: 1))
        attributedStringtxtFirstName5.addAttribute(.foregroundColor, value: UIColor.lightGray, range: otherCharactersRangetxtFirstName5)
        txtBuliddingName.attributedPlaceholder = attributedStringtxtFirstName5
        
        imgCheck.isHidden = true
        
        viewAddressMain.isHidden = true
        mainView1.isHidden = true
        
        viewAddressTop.clipsToBounds = true
        viewAddressTop.layer.cornerRadius = 15
        viewAddressTop.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        
        callAreaListAPI()
        
        DispatchQueue.main.async {
            
            self.mapView.overrideUserInterfaceStyle = .dark
            self.mapView.delegate = self
            
            self.mapView.isMyLocationEnabled = true
            self.mapView.settings.scrollGestures = true
            self.mapView.settings.zoomGestures = true
            
            if CLLocationManager.locationServicesEnabled()
            {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.distanceFilter = 10
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.startUpdatingLocation()
            }
            else
            {
                self.objLatitude = "\(appDelegate?.kuwaitCurrentLat ?? 0.0)"
                self.objLongitude = "\(appDelegate?.kuwaitCurrentLong ?? 0.0)"
                
                let camera = GMSCameraPosition.camera(withLatitude: appDelegate?.kuwaitCurrentLat ?? 0.0, longitude: appDelegate?.kuwaitCurrentLong ?? 0.0, zoom: 15.0)
                self.mapView?.camera = camera
                
                self.currentLocationMarker.position = CLLocationCoordinate2D(latitude: appDelegate?.kuwaitCurrentLat ?? 0.0, longitude: appDelegate?.kuwaitCurrentLong ?? 0.0)
                self.currentLocationMarker.icon = self.imageWithImage(image: UIImage(named: "maps-and-flags")!, scaledToSize: CGSize(width: 30, height: 35))
                self.currentLocationMarker.map = self.mapView
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
        
        txtMessage.delegate = self
   //     txtMessage.pla = "Comment (optional)".localizeString(string: Language.shared.currentAppLang)
        
        // Do any additional setup after loading the view.
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
                        self.txtBuliddingName.text = "\(pm.thoroughfare!)"
                        
                    }
                    if pm.thoroughfare != nil {
                        //// Street name
                        addressString = addressString + pm.thoroughfare! + ", "
                        self.txtStreet.text = "\(pm.thoroughfare!)"
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
//                    self.txtAddrerssName.text = addressString
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
    
    
    @IBAction func clickedTC(_ sender: Any) {
        let mainS = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "AboutVC") as! AboutVC
        vc.strTitle = "TERMS & CONDITIONS"
        vc.isOpenSide = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
//        if txtMessage.text == "Comment (optional)".localizeString(string: Language.shared.currentAppLang) {
//            txtMessage.text = ""
//        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtMessage.text.isEmpty {
           // txtMessage.text = "Comment (optional)".localizeString(string: Language.shared.currentAppLang)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.lblCartCount.text = appDelegate?.strTotalCount
        
        //        if appDelegate?.strTotalCount == "0"
        //        {
        //            self.viewCountItem.isHidden = true
        //        }
        //        else
        //        {
        //            self.viewCountItem.isHidden = false
        //        }
        
        if Language.shared.isArabic {
            imgBack.image = UIImage(named: "Back_Ar")
            
            txtFName.textAlignment = .right
            txtEmail.textAlignment = .right
            txtPassword.textAlignment = .right
            txtCPassword.textAlignment = .right
            txtMessage.textAlignment = .right
            
            txtAddrerssName.textAlignment = .right
            txtGovernorates.textAlignment = .right
            txtArea.textAlignment = .right
            txtBlock.textAlignment = .right
            txtStreet.textAlignment = .right
            txtAvenue.textAlignment = .right
            txtBuliddingName.textAlignment = .right
            txtFloor.textAlignment = .right
            txtApartmentNo.textAlignment = .right
            
            lblTSelectLoation.textAlignment = .right
            lblTTC.textAlignment = .right
        }
        else
        {
            imgBack.image = UIImage(named: "Back")
            
            txtFName.textAlignment = .left
            txtEmail.textAlignment = .left
            txtPassword.textAlignment = .left
            txtCPassword.textAlignment = .left
            txtMessage.textAlignment = .left
            
            txtAddrerssName.textAlignment = .left
            txtGovernorates.textAlignment = .left
            txtArea.textAlignment = .left
            txtBlock.textAlignment = .left
            txtStreet.textAlignment = .left
            txtAvenue.textAlignment = .left
            txtBuliddingName.textAlignment = .left
            txtFloor.textAlignment = .left
            txtApartmentNo.textAlignment = .left
            
            lblTSelectLoation.textAlignment = .left
            lblTTC.textAlignment = .left
        }
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error" + error.description)
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        currentLocationMarker.position = position.target
        self.objLatitude = String(currentLocationMarker.position.latitude)
        self.objLongitude = String(currentLocationMarker.position.longitude)
        
        currentLocationMarker.icon = self.imageWithImage(image: UIImage(named: "maps-and-flags")!, scaledToSize: CGSize(width: 30, height: 35))
        currentLocationMarker.map = self.mapView
        self.currentLocationMarker.isDraggable = true
        
        getAddressFromLatLon(latitude: currentLocationMarker.position.latitude, longitude: currentLocationMarker.position.longitude)
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
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func setdropDownArea()
    {
        var arrArea = NSMutableArray()
        
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
                
                if item == obj.areaNameAr
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
    
    func setdropDowngovernorates()
    {
        var arrArea = NSMutableArray()
        
        for obj in arrGovernorates
        {
            arrArea.add(obj.name ?? "")
        }
        
        dropGovernorates.dataSource = arrArea as! [String]
        dropGovernorates.anchorView = txtGovernorates
        dropGovernorates.direction = .bottom
        
        dropGovernorates.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.txtGovernorates.text = item
            
            for obj in arrGovernorates
            {
                if item == obj.name
                {
                    self.strGovernorates_id = "\(obj.id ?? 0)"
                    self.arrAreaList = obj.areas
                    
                    self.setdropDownArea()
                }
            }
        }
        
        dropGovernorates.bottomOffset = CGPoint(x: 0, y: txtGovernorates.bounds.height)
        dropGovernorates.topOffset = CGPoint(x: 0, y: -txtGovernorates.bounds.height)
        dropGovernorates.dismissMode = .onTap
        dropGovernorates.textColor = UIColor.black
        dropGovernorates.backgroundColor = UIColor(red: 255/255, green:  255/255, blue:  255/255, alpha: 1)
        dropGovernorates.selectionBackgroundColor = UIColor.clear
        
        dropGovernorates.reloadAllComponents()
    }
    
    @IBAction func clickedConfimrMapa(_ sender: Any) {
        
        viewMapHiest.constant = 130
        
        viewEditMap.isHidden = false
        
        btnConfirmMap.isHidden = true
        
        btnMapGes.isHidden = false
        
        viewCurrentMap.isHidden = true
        
        isCurrentLocationChanged = true
        
        let camera7 = GMSCameraPosition.camera(withLatitude: Double(objLatitude) ?? 0.0, longitude: Double(objLongitude) ?? 0.0, zoom: 15.0)
        self.mapView?.camera = camera7
        
        currentLocationMarker.position = CLLocationCoordinate2D(latitude: Double(objLatitude) ?? 0.0, longitude: Double(objLongitude) ?? 0.0)
        currentLocationMarker.icon = self.imageWithImage(image: UIImage(named: "maps-and-flags")!, scaledToSize: CGSize(width: 30, height: 35))
        currentLocationMarker.map = self.mapView
    }
    
    @IBAction func clickedEditMapa(_ sender: Any) {
        
        viewMapHiest.constant = 350
        viewEditMap.isHidden = true
        
        viewCurrentMap.isHidden = false
        
        btnConfirmMap.isHidden = false
        
        btnMapGes.isHidden = true
    }
    
    @IBAction func clickedCurrentLocationa(_ sender: Any) {
        
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
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickedCart(_ sender: Any) {
    }
    @IBAction func clickedAddAddress(_ sender: Any) {
        viewAddressMain.isHidden = false
        mainView1.isHidden = false
        
        viewMapHiest.constant = 130
        
        viewEditMap.isHidden = false
        
        btnConfirmMap.isHidden = true
        
        btnMapGes.isHidden = false
        viewCurrentMap.isHidden = true
        
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
    @IBAction func clickedTerms(_ sender: Any) {
        if imgCheck.isHidden == true
        {
            imgCheck.isHidden = false
        }
        else
        {
            imgCheck.isHidden = true
        }
    }
    @IBAction func clickedCreateAccount(_ sender: Any) {
        if isValidRegister()
        {
            callRegisterAPI()
        }
    }
    @IBAction func clickedGoogle(_ sender: Any) {
    }
    @IBAction func clickedApple(_ sender: Any) {
    }
    
    // Address
    
    @IBAction func clickedClose(_ sender: Any) {
        viewAddressMain.isHidden = true
        mainView1.isHidden = true
        
    }
    @IBAction func clickedArea(_ sender: Any) {
        dropDown.show()
    }
    
    @IBAction func clickedgovernorates(_ sender: Any) {
        dropGovernorates.show()
    }
    
    @IBAction func clickedAdd(_ sender: Any) {
        viewAddressMain.isHidden = true
        mainView1.isHidden = true
    }
    
    // MARK: - calling API
    
    func callRegisterAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let country_code = "965"
        
        let mobile_number = self.strMobileNo
        
        let name = self.txtFName.text ?? ""
        
        let email = self.txtEmail.text ?? ""
        
        let password = self.txtPassword.text ?? ""
        
        let password_confirmation = self.txtCPassword.text ?? ""
        
        let device_type = "1"
        
        let device_token = appDelegate?.devicePushToken ?? ""
        
        let device_serial_id = appDelegate?.deviceSerialId ?? ""
        
        let version = "1"
        
        let area_id = self.strArea_id
        
        let address = self.txtAddrerssName.text ?? ""
        
        let block = self.txtBlock.text ?? ""
        
        let street = self.txtStreet.text ?? ""
        
        let building_number = self.txtBuliddingName.text ?? ""
        
        let latitude = self.objLatitude
        
        let longitude = self.objLongitude
        
        let comment = self.txtMessage.text ?? ""
        
        var param = ["":""]
        
        var url_ = ""
        
        if self.isGuestLogin == true
        {
            url_ = GUEST_REGISTER
            param = ["country_code":country_code,"mobile_number":mobile_number,"name":name,"email":email,"device_type":device_type,"device_token":device_token,"device_serial_id":device_serial_id,"version":version,"area_id":area_id,"address":address,"block":block,"street":street,"building_number":building_number,"latitude":latitude,"longitude":longitude,"comment":comment]
        }
        else if self.isSocialLogin == true 
        {
            url_ = SOCIAL_REGISTER
            param = ["social_id":self.socialId,"social_device":self.socialDevice,"country_code":country_code,"mobile_number":mobile_number,"name":name,"email":email,"device_type":device_type,"device_token":device_token,"device_serial_id":device_serial_id,"version":version,"area_id":area_id,"address":address,"block":block,"street":street,"building_number":building_number,"latitude":latitude,"longitude":longitude,"comment":comment]
        }
        else
        {
            url_ = REGISTER_USER
            param = ["country_code":country_code,"mobile_number":mobile_number,"name":name,"email":email,"password":password,"password_confirmation":password_confirmation,"device_type":device_type,"device_token":device_token,"device_serial_id":device_serial_id,"version":version,"area_id":area_id,"address":address,"block":block,"street":street,"building_number":building_number,"latitude":latitude,"longitude":longitude,"comment":comment]
        }
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderPost(url_, parameters: param) { response, error, statusCode in
            
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
                        if let result = response?.value(forKey: "result") as? NSDictionary
                        {
                            let dicData = TBLoginUserResult(fromDictionary: result)
                            
                            appDelegate?.saveCuurentUserData(dic: dicData)
                            appDelegate?.dicCurrentLoginUser = dicData
                            
                            if self.isGuestLogin == true {
                                appDelegate?.saveIsGuestLogin(dic: true)
                            }
                            
                            UserDefaults.standard.set(dicData.token ?? "", forKey: "token")
                            UserDefaults.standard.synchronize()
                            
                            appDelegate?.saveIsUserLogin(dic: true)
                            appDelegate?.isFirstTime = true
                            appDelegate?.setUpHome()
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
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    func callAreaListAPI()
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
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    // MARK: - validation
    
    func isValidRegister() -> Bool
    {
        if isGuestLogin == true
        {
            if txtFName.text == ""
            {
                self.setUpMakeToast(msg: "Please enter full name".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            //            else if txtAddrerssName.text == ""
            //            {
            //                self.setUpMakeToast(msg: "Please enter address".localizeString(string: Language.shared.currentAppLang))
            //                return false
            //            }
            else if txtArea.text == ""
            {
                self.setUpMakeToast(msg: "Please select area".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if txtBlock.text == ""
            {
                self.setUpMakeToast(msg: "Please enter block".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if txtStreet.text == ""
            {
                self.setUpMakeToast(msg: "Please enter street".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if txtBuliddingName.text == ""
            {
                self.setUpMakeToast(msg: "Please enter buliding number".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if imgCheck.isHidden == true
            {
                self.setUpMakeToast(msg: "You must agree with the terms and conditions.".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if objLatitude == ""
            {
                DispatchQueue.main.async {
                    self.showPermissionAlert()
                }
                
                return false
            }
            else if txtEmail.text != ""
            {
                if !AppUtilites.isValidEmail(testStr: txtEmail.text ?? "")
                {
                    self.setUpMakeToast(msg: "Please enter valid email".localizeString(string: Language.shared.currentAppLang))
                    return false
                }
                
                return true
            }
            
            return true
        }
        else if isSocialLogin == true
        {
            if txtFName.text == ""
            {
                self.setUpMakeToast(msg: "Please enter full name".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            //            else if txtAddrerssName.text == ""
            //            {
            //                self.setUpMakeToast(msg: "Please enter address".localizeString(string: Language.shared.currentAppLang))
            //                return false
            //            }
            else if txtArea.text == ""
            {
                self.setUpMakeToast(msg: "Please select area".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if txtBlock.text == ""
            {
                self.setUpMakeToast(msg: "Please enter block".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if txtStreet.text == ""
            {
                self.setUpMakeToast(msg: "Please enter street".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if txtBuliddingName.text == ""
            {
                self.setUpMakeToast(msg: "Please enter buliding number".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if imgCheck.isHidden == true
            {
                self.setUpMakeToast(msg: "You must agree with the terms and conditions.".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if objLatitude == ""
            {
                DispatchQueue.main.async {
                    self.showPermissionAlert()
                }
                
                return false
            }
            else if txtEmail.text != ""
            {
                if !AppUtilites.isValidEmail(testStr: txtEmail.text ?? "")
                {
                    self.setUpMakeToast(msg: "Please enter valid email".localizeString(string: Language.shared.currentAppLang))
                    return false
                }
                
                return true
            }
            
            return true
        }
        else
        {
            if txtFName.text == ""
            {
                self.setUpMakeToast(msg: "Please enter full name".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if txtPassword.text == ""
            {
                self.setUpMakeToast(msg: "Please enter password".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if txtCPassword.text == ""
            {
                self.setUpMakeToast(msg: "Please enter confirm password".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if txtPassword.text != txtCPassword.text
            {
                self.setUpMakeToast(msg: "Password dose not match".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if txtAddrerssName.text == ""
            {
                self.setUpMakeToast(msg: "Please enter address".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if txtArea.text == ""
            {
                self.setUpMakeToast(msg: "Please select area".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if txtBlock.text == ""
            {
                self.setUpMakeToast(msg: "Please enter block".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if txtStreet.text == ""
            {
                self.setUpMakeToast(msg: "Please enter street".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if txtBuliddingName.text == ""
            {
                self.setUpMakeToast(msg: "Please enter buliding number".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if imgCheck.isHidden == true
            {
                self.setUpMakeToast(msg: "You must agree with the terms and conditions.".localizeString(string: Language.shared.currentAppLang))
                return false
            }
            else if objLatitude == ""
            {
                DispatchQueue.main.async {
                    self.showPermissionAlert()
                }
                
                return false
            }
            else if txtEmail.text != ""
            {
                if !AppUtilites.isValidEmail(testStr: txtEmail.text ?? "")
                {
                    self.setUpMakeToast(msg: "Please enter valid email".localizeString(string: Language.shared.currentAppLang))
                    return false
                }
                
                return true
            }
            
            return true
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
    
}
