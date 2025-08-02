//
//  ContactVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 05/06/23.
//

import UIKit
import LGSideMenuController
import MapKit
import UITextView_Placeholder

class ContactVC: UIViewController, UITextViewDelegate, CLLocationManagerDelegate {
    
  //  @IBOutlet weak var imgCart: UIImageView!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
  //  @IBOutlet weak var viewCountItem: UIView!
    
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var lblON1: UILabel!
    @IBOutlet weak var lblON2: UILabel!
    @IBOutlet weak var lblSN1: UILabel!
    @IBOutlet weak var lblSN2: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var lbltContact: UILabel!
    @IBOutlet weak var lblTON1: UILabel!
    @IBOutlet weak var lblTON2: UILabel!
    @IBOutlet weak var lblTN1: UILabel!
    @IBOutlet weak var lblTN2: UILabel!
    @IBOutlet weak var lblTStoreAddrss: UILabel!
    
    @IBOutlet weak var btnTSend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblON1.text = appDelegate?.getApplicationSettingData().officeNumber1 ?? ""
        
        lblON2.text = appDelegate?.getApplicationSettingData().officeNumber2 ?? ""
        
        lblSN1.text = appDelegate?.getApplicationSettingData().supportNumber1 ?? ""
        
        lblSN2.text = appDelegate?.getApplicationSettingData().supportNumber2 ?? ""
        
        lblAddress.text = appDelegate?.getApplicationSettingData().storeAddress ?? ""
        
        let latitude: CLLocationDegrees = Double(appDelegate?.getApplicationSettingData().storeAddressLat ?? "") ?? 0.0
        let longitude: CLLocationDegrees = Double(appDelegate?.getApplicationSettingData().storeAddressLon ?? "") ?? 0.0
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        
        mapView.setRegion(region, animated: true)
        
        // Optionally, add a pin to mark the current location
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        
        lbltContact.text = "CONTACT US".localizeString(string: Language.shared.currentAppLang)
        lblTON1.text = "OFFICE NUMBER".localizeString(string: Language.shared.currentAppLang)
        lblTON2.text = "OFFICE NUMBER".localizeString(string: Language.shared.currentAppLang)
        lblTN1.text = "SUPPORT NUMBER".localizeString(string: Language.shared.currentAppLang)
        lblTN2.text = "SUPPORT NUMBER".localizeString(string: Language.shared.currentAppLang)
        lblTStoreAddrss.text = "STORE ADDRESS".localizeString(string: Language.shared.currentAppLang)
        
        txtName.placeholder = "Name".localizeString(string: Language.shared.currentAppLang)
        txtEmail.placeholder = "Email or Phone number".localizeString(string: Language.shared.currentAppLang)
        
        btnTSend.setTitle("Send".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        txtView.delegate = self        
        txtView.placeholder = "Text".localizeString(string: Language.shared.currentAppLang)
        
        if Language.shared.isArabic {
            txtView.placeholderTextView.textAlignment = .right
            txtView.textAlignment = .right
            lblAddress.textAlignment = .right
            
            lblTON1.textAlignment = .right
            lblTON2.textAlignment = .right
            lblTN1.textAlignment = .right
            lblTN2.textAlignment = .right
            
            lblON1.textAlignment = .right
            lblON2.textAlignment = .right
            lblSN1.textAlignment = .right
            lblSN2.textAlignment = .right
            
            txtName.textAlignment = .right
            txtEmail.textAlignment = .right
        } else {
            txtView.placeholderTextView.textAlignment = .left
            txtView.textAlignment = .left
            lblAddress.textAlignment = .left
            
            lblTON1.textAlignment = .left
            lblTON2.textAlignment = .left
            lblTN1.textAlignment = .left
            lblTN2.textAlignment = .left
            
            lblON1.textAlignment = .left
            lblON2.textAlignment = .left
            lblSN1.textAlignment = .left
            lblSN2.textAlignment = .left
            
            txtName.textAlignment = .left
            txtEmail.textAlignment = .left
        }
        
        // Do any additional setup after loading the view.
    }
   
    override func viewWillAppear(_ animated: Bool) {
        
        lblCartCount.text = appDelegate?.strTotalCount ?? ""
        
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
        }
        else
        {
            imgBack.image = UIImage(named: "Back")
        }
        
//        if let isUserLogin = appDelegate?.getIsUserLogin()
//                {
//                    if isUserLogin == true
//                    {
//                        imgCart.isHidden = false
//                        viewCountItem.isHidden = false
//                    }
//                    else
//                    {
//                        imgCart.isHidden = true
//                        viewCountItem.isHidden = true
//                    }
//                }
//                else
//                {
//                    imgCart.isHidden = true
//                    viewCountItem.isHidden = true
//                }
        
    }
    
    @IBAction func clickedOffice1(_ sender: Any) {
        callPhoneNumber(phoneNumber: appDelegate?.getApplicationSettingData().officeNumber1 ?? "")
    }
    
    @IBAction func clickedOffice2(_ sender: Any) {
        callPhoneNumber(phoneNumber: appDelegate?.getApplicationSettingData().officeNumber2 ?? "")
    }
    
    @IBAction func clickedSupport1(_ sender: Any) {
        callPhoneNumber(phoneNumber: appDelegate?.getApplicationSettingData().supportNumber1 ?? "")
    }
    
    @IBAction func clickedSupport2(_ sender: Any) {
        callPhoneNumber(phoneNumber: appDelegate?.getApplicationSettingData().supportNumber2 ?? "")
    }
    
    func callPhoneNumber(phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            // Handle the error
            print("Your device doesn't support phone calls.")
        }
    }
    
    @IBAction func clickedGoogleMap(_ sender: Any) {
        let latitude = appDelegate?.getApplicationSettingData().storeAddressLat ?? ""
        let longitude = appDelegate?.getApplicationSettingData().storeAddressLon ?? ""
        
        if let url = URL(string: "comgooglemaps://?q=\(latitude),\(longitude)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            // Handle the error, perhaps by opening the URL in a browser
            print("Google Maps is not installed. Opening in the browser...")
            if let webUrl = URL(string: "https://maps.google.com/?q=\(latitude),\(longitude)") {
                UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
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
    @IBAction func clickedSend(_ sender: Any) {
        if txtName.text == "" {
            self.setUpMakeToast(msg: "Please enter name")
        } else if txtEmail.text == "" {
            self.setUpMakeToast(msg: "Please enter email or mobile number")
        } else if txtView.text == "" {
            self.setUpMakeToast(msg: "Please enter message")
        } else {
            callingContactUsAPI()
        }
    }
    
    
    @IBAction func clickedTwiirter(_ sender: Any) {
        
        if let url = URL(string: appDelegate?.getApplicationSettingData().twitterLink ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func clickedInstagram(_ sender: Any) {
        
        if let url = URL(string: appDelegate?.getApplicationSettingData().instagramLink ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    // MARK: - calling API
    func callingContactUsAPI() {
        APIClient.sharedInstance.showIndicator()
        
        let name = txtName.text ?? ""
        let email = txtEmail.text ?? ""
        let message = txtView.text ?? ""
        
        let param = ["name":name,
                     "email":email,
                     "message":message]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderPost(CONTACT_US, parameters: param) { response, error, statusCode in
            
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
//                        self.setUpMakeToast(msg: message ?? "")
                        
                        let mainS =  UIStoryboard(name: "Home", bundle: nil)
                        let vc = mainS.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
                        vc.strTitle = message ?? ""
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: false)
                        
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
                        
                        appDelegate?.saveIsUserLogin(dic: false)
                    }
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
    }
    
}
