//
//  AddNewAddress1VC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 25/07/25.
//

import UIKit
import DropDown
import CoreLocation
import MapKit
import GoogleMaps

class AddNewAddress1VC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    @IBOutlet weak var lblTitleNewAddress: UILabel!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtGovernorates: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    @IBOutlet weak var txtBlock: UITextField!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtAvenue: UITextField!
    @IBOutlet weak var txtBuildingNumber: UITextField!
    @IBOutlet weak var txtFloor: UITextField!
    @IBOutlet weak var txtApartmentNumber: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var viewMain: UIView! {
        didSet {
            viewMain.clipsToBounds = true
            viewMain.layer.cornerRadius = 20
            viewMain.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        }
    }
    
    var arrAreaList: [TBGovernoratesArea] = [TBGovernoratesArea]()
    var arrGovernorates: [TBGovernoratesResult] = [TBGovernoratesResult]()
    
    var dropDown = DropDown()
    var dropGovernorates = DropDown()

    let locationManager = CLLocationManager()
    
    var objLatitude = ""
    var objLongitude = ""
    
    var currentLocationMarker: GMSMarker = GMSMarker()
    var strArea_id = ""
    var strGovernorates_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitleNewAddress.text = "New address".localizeString(string: Language.shared.currentAppLang)
        
        txtAddress.placeholder = "Address name".localizeString(string: Language.shared.currentAppLang)
        txtGovernorates.placeholder = "Governorates*".localizeString(string: Language.shared.currentAppLang)
        txtArea.placeholder = "Area*".localizeString(string: Language.shared.currentAppLang)
        txtBlock.placeholder = "Block*".localizeString(string: Language.shared.currentAppLang)
        txtStreet.placeholder = "Street*".localizeString(string: Language.shared.currentAppLang)
        txtAvenue.placeholder = "Avenue ( Optional )".localizeString(string: Language.shared.currentAppLang)
        txtBuildingNumber.placeholder = "Building number*".localizeString(string: Language.shared.currentAppLang)
        txtFloor.placeholder = "Floor ( Optional )".localizeString(string: Language.shared.currentAppLang)
        txtApartmentNumber.placeholder = "Apartment number ( Optional )".localizeString(string: Language.shared.currentAppLang)
        
        btnAdd.setTitle("Add".localizeString(string: Language.shared.currentAppLang), for: .normal)

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
        
        let attributedStringtxtFirstName5 = NSMutableAttributedString(string: txtBuildingNumber.placeholder ?? "")
        let lastCharacterIndextxtFirstName5 = attributedStringtxtFirstName5.length - 1
        let otherCharactersRangetxtFirstName5 = NSRange(location: 0, length: lastCharacterIndextxtFirstName5)
        attributedStringtxtFirstName5.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: lastCharacterIndextxtFirstName5, length: 1))
        attributedStringtxtFirstName5.addAttribute(.foregroundColor, value: UIColor.lightGray, range: otherCharactersRangetxtFirstName5)
        txtBuildingNumber.attributedPlaceholder = attributedStringtxtFirstName5


        if Language.shared.isArabic {
            txtAddress.textAlignment = .right
            txtGovernorates.textAlignment = .right
            txtArea.textAlignment = .right
            txtBlock.textAlignment = .right
            txtStreet.textAlignment = .right
            txtAvenue.textAlignment = .right
            txtBuildingNumber.textAlignment = .right
            txtFloor.textAlignment = .right
            txtApartmentNumber.textAlignment = .right
        }
        else
        {
            txtAddress.textAlignment = .left
            txtGovernorates.textAlignment = .left
            txtArea.textAlignment = .left
            txtBlock.textAlignment = .left
            txtStreet.textAlignment = .left
            txtAvenue.textAlignment = .left
            txtBuildingNumber.textAlignment = .left
            txtFloor.textAlignment = .left
            txtApartmentNumber.textAlignment = .left
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
        
        // Do any additional setup after loading the view.
    }

    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickedCurrentLocation(_ sender: Any) {
        
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
    @IBAction func clickedAdd(_ sender: Any) {
        if self.strArea_id == ""
        {
            self.setUpMakeToast(msg: "Please select area".localizeString(string: Language.shared.currentAppLang))
        }
        else if txtBlock.text == ""
        {
            self.setUpMakeToast(msg: "Please enter block".localizeString(string: Language.shared.currentAppLang))
        }
        else if txtStreet.text == ""
        {
            self.setUpMakeToast(msg: "Please enter street".localizeString(string: Language.shared.currentAppLang))
        }
        else if txtBuildingNumber.text == ""
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
    
    @IBAction func clickedGovernorates(_ sender: Any) {
        dropGovernorates.show()
    }
    @IBAction func clickedArea(_ sender: Any) {
        dropDown.show()
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
                    
                    self.txtArea.text = ""
                    
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
    
    func callCreateAddressAPI()
    {
        // APIClient.sharedInstance.showIndicator()
        
        let user_id = "\(appDelegate?.dicCurrentLoginUser.id ?? 0)"
        
        let area_id = self.strArea_id
        
        let address = self.txtAddress.text ?? ""
        
        let block = self.txtBlock.text ?? ""
        
        let street = self.txtStreet.text ?? ""
        
        let avenue = self.txtAvenue.text ?? ""
        
        let building_number = self.txtBuildingNumber.text ?? ""
        
        let floor = self.txtFloor.text ?? ""
        
        let apartment = self.txtApartmentNumber.text ?? ""
        
        let latitude = self.objLatitude
        
        let longitude = self.objLongitude
        
        let param = ["user_id":"\(user_id)","area_id":"\(area_id)","address":address,"block":block,"street":street,"avenue":avenue,"building_number":building_number,"floor":floor,"apartment":apartment,"latitude":latitude,"longitude":longitude]
        
        var _url = CREATE_ADDRESS
        
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
                            self.clickedBack(self)
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
                        self.txtBuildingNumber.text = "\(pm.thoroughfare!)"
                        
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
                        self.txtApartmentNumber.text = "\(pm.subAdministrativeArea!)"
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
        
        objLatitude = "\(location?.coordinate.latitude ?? 0.0)"
        objLongitude = "\(location?.coordinate.longitude ?? 0.0)"
        
        let camera = GMSCameraPosition.camera(withLatitude: location?.coordinate.latitude ?? 0.0, longitude: location?.coordinate.longitude ?? 0.0, zoom: 15.0)
        self.mapView?.camera = camera
        
        currentLocationMarker.position = CLLocationCoordinate2D(latitude: location?.coordinate.latitude ?? 0.0, longitude: location?.coordinate.longitude ?? 0.0)
        currentLocationMarker.icon = self.imageWithImage(image: UIImage(named: "maps-and-flags")!, scaledToSize: CGSize(width: 30, height: 35))
        currentLocationMarker.map = self.mapView
        
    }
    
}
