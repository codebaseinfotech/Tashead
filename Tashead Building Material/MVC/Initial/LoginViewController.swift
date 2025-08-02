//
//  LoginViewController.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 31/05/23.
//

import UIKit
import LGSideMenuController
import Toast_Swift
import GoogleSignIn
import AuthenticationServices
import AuthenticationServices
import Firebase
import FirebaseAuth
import Alamofire
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, UITextFieldDelegate, GIDSignInDelegate,ASAuthorizationControllerPresentationContextProviding {
    
    @IBOutlet weak var lblGoogle: UILabel!
    @IBOutlet weak var lblFb: UILabel!
    @IBOutlet weak var lblApple: UILabel!
    
    
    @IBOutlet weak var imgCart: UIImageView!
    
    
    @IBOutlet weak var viewCountItem: UIView!
    
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblCartCount: UILabel!
    
    // out title
    @IBOutlet weak var lblTLogin: UILabel!
    @IBOutlet weak var lblTRegisterUsing: UILabel!
    
    @IBOutlet weak var btnTForgot: UIButton!
    @IBOutlet weak var btnTLogin: UIButton!
    @IBOutlet weak var btnTGuest: UIButton!
    @IBOutlet weak var btnTRegister: UIButton!
    @IBOutlet weak var btnTGooglr: UIButton!
    @IBOutlet weak var btnTFacbook: UIButton!
    @IBOutlet weak var btntApple: UIButton!
    @IBOutlet weak var lblTOr: UILabel!
    
    @IBOutlet weak var viewMainSocialMidia: UIView!
    @IBOutlet weak var viewGoogle: UIView!
    @IBOutlet weak var viewFacebook: UIView!
    @IBOutlet weak var viewApple: UIView!
    
    var isFromHome = false
    var selectViewContrller = UIViewController()
    
    var isAppleLogin:Bool = false
    fileprivate var currentNonce: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if appDelegate?.getApplicationSettingData() != nil {
            viewMainSocialMidia.isHidden = appDelegate?.getApplicationSettingData().businessrules.isSocialMedia == "1" ? false : true
            viewGoogle.isHidden = appDelegate?.getApplicationSettingData().businessrules.isSocialMedia == "1" ? false : true
            viewFacebook.isHidden = appDelegate?.getApplicationSettingData().businessrules.isSocialMedia == "1" ? false : true
            viewApple.isHidden = appDelegate?.getApplicationSettingData().businessrules.isSocialMedia == "1" ? false : true
            lblTRegisterUsing.isHidden = appDelegate?.getApplicationSettingData().businessrules.isSocialMedia == "1" ? false : true
        }
        
        
        lblTOr.text = "Or".localizeString(string: Language.shared.currentAppLang)
        
        lblTLogin.text = "LOGIN".localizeString(string: Language.shared.currentAppLang)
        lblTRegisterUsing.text = "Register using following accont".localizeString(string: Language.shared.currentAppLang)
        
        txtEmail.placeholder = "Mobile Number".localizeString(string: Language.shared.currentAppLang)
        txtPassword.placeholder = "Password".localizeString(string: Language.shared.currentAppLang)
        
        btnTForgot.setTitle("Forgot Password !".localizeString(string: Language.shared.currentAppLang), for: .normal)
        btnTLogin.setTitle("Login".localizeString(string: Language.shared.currentAppLang), for: .normal)
        btnTGuest.setTitle("Continue as a guest".localizeString(string: Language.shared.currentAppLang), for: .normal)
        btnTRegister.setTitle("Register".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        lblGoogle.text = "Sign in with Google".localizeString(string: Language.shared.currentAppLang)
        lblFb.text = "Sign in with Facebook".localizeString(string: Language.shared.currentAppLang)
        lblApple.text = "Sign in with Apple".localizeString(string: Language.shared.currentAppLang)
 
        
        if Language.shared.isArabic {
            imgBack.image = UIImage(named: "Back_Ar")
            
            txtEmail.textAlignment = .right
            txtPassword.textAlignment = .right
        }
        else
        {
            imgBack.image = UIImage(named: "Back")
            
            txtEmail.textAlignment = .left
            txtPassword.textAlignment = .left
        }
        
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.lblCartCount.text = appDelegate?.strTotalCount
        
        //        if appDelegate?.strTotalCount == "0"
        //        {
        self.viewCountItem.isHidden = true
        self.imgCart.isHidden = true
        //        }
        //        else
        //        {
        //            self.viewCountItem.isHidden = false
        //            self.imgCart.isHidden = false
        //
        //        }
        
        self.viewCountItem.isHidden = true
        self.imgCart.isHidden = true
        
        
        self.txtEmail.text = appDelegate?.strPhone ?? ""
        
        appDelegate?.strPhone = ""
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
        
        if isFromHome == true
        {
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            appDelegate?.setUpHome()
        }
        
    }
    
    @IBAction func clickedCart(_ sender: Any) {
       
        
    }
    
    
    @IBAction func clickedForgotPass(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func clickedLogin(_ sender: Any) {
        if isValidLogin()
        {
            callLoginAPI()
        }
    }
    @IBAction func clickedCoutinueGust(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "MobileRegisterVC") as! MobileRegisterVC
        vc.isFromHome = self.isFromHome
        vc.isGuestLogin = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func clickedRegister(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "MobileRegisterVC") as! MobileRegisterVC
        vc.isFromHome = self.isFromHome
        appDelegate?.saveIsGuestLogin(dic: false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickedGoogleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let userId = user.userID                  // For client-side use only!
        // let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile?.name
        let givenName = user.profile?.givenName
        let familyName = user.profile?.familyName
        let email = user.profile?.email
        
        self.callSocialLoginAPI(socialID: userId ?? "", socialDevice: "2", email: email ?? "", name: fullName?.replacingOccurrences(of: " ", with: "") ?? "")
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    @IBAction func clickedFacebookLogin(_ sender: Any) {
        fetchFbUserData()
    }
 
    func fetchFbUserData() {
        let fbLoginManager : LoginManager = LoginManager()
        
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) -> Void in
            //  if (error == nil){
            let fbloginresult : LoginManagerLoginResult = result!
            // if user cancel the login
            if (result?.isCancelled)!{
                return
            }
            if(fbloginresult.grantedPermissions.contains("public_profile")) {
                //                    self.startAnimation()
                
                guard let token = AccessToken.current else {
                    print("Failed to get access token")
                    return
                }
                
                let tokenString = token.tokenString
                
                let request = GraphRequest(graphPath: "me", parameters: ["fields": "id,email, name,first_name,last_name"], tokenString: tokenString, version: nil, httpMethod: .get)
                request.start { _, result, error in
                    if let error = error {
                        print("Failed to start graph request: \(error)")
                        return
                    }
                    
                    var _socialID = ""
                    var _email = ""
                    var _First_name = ""
                    var _Last_name = ""
                    
                    if let dict = result as? [String: Any] {
                        print(dict)
                        
                        if let id = dict["id"] as? String {
                            _socialID = id
                        }
                        
                        if let fname = dict["first_name"] as? String {
                            _First_name = fname
                        }
                        
                        if let lname = dict["last_name"] as? String {
                            _Last_name = lname
                        }
                        
                        if let email = dict["email"] as? String {
                            _email = email
                        }
                        
                        self.callSocialLoginAPI(socialID: _socialID, socialDevice: "3", email: _email, name: "\(_First_name) \(_Last_name)")
                    }
                }
            }
        }
    }
    
    @IBAction func clickedAppleLogin(_ sender: Any) {
        self.startSignInWithAppleFlow()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    @available(iOS 13, *)
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        //      request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    //    @available(iOS 13, *)
    //    private func sha256(_ input: String) -> String {
    //        let inputData = Data(input.utf8)
    //        let hashedData = SHA256.hash(data: inputData)
    //        let hashString = hashedData.compactMap {
    //            return String(format: "%02x", $0)
    //        }.joined()
    //
    //        return hashString
    //    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    
    
    // MARK: - calling API
    
    func callLoginAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let device_token = appDelegate?.devicePushToken ?? ""
        
        let device_serial_id = appDelegate?.deviceSerialId ?? ""
        
        let version = "1"
        
        let param = ["email":self.txtEmail.text ?? "","password":self.txtPassword.text ?? "","device_token":device_token,"device_serial_id":device_serial_id,"version":version]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderPost(LOG_IN, parameters: param) { response, error, statusCode in
            
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
                            
                            appDelegate?.setNotificaationTag()
                            
                            if dicData.user_type_text == "guest"
                            {
                                appDelegate?.saveIsGuestLogin(dic: true)
                            }
                            else
                            {
                                appDelegate?.saveIsGuestLogin(dic: false)
                            }
                            
                            UserDefaults.standard.set(dicData.token ?? "", forKey: "token")
                            UserDefaults.standard.synchronize()
                            
                            appDelegate?.saveIsUserLogin(dic: true)
                            
                            if self.isFromHome == true
                            {
                                self.navigationController?.popViewController(animated: true)
                            }
                            else
                            {
                                appDelegate?.setUpHome()
                            }
                        }
                    }
                    else
                    {
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
    
    func callSocialLoginAPI(socialID: String,socialDevice: String,email:String,name:String)
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["social_id":socialID,"social_device":socialDevice,"device_type":"1"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderPost(SOCIAL_LOGIN, parameters: param) { response, error, statusCode in
            
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
                            
                            appDelegate?.setNotificaationTag()
                            
                            if dicData.user_type_text == "guest"
                            {
                                appDelegate?.saveIsGuestLogin(dic: true)
                            }
                            else
                            {
                                appDelegate?.saveIsGuestLogin(dic: false)
                            }
                            
                            UserDefaults.standard.set(dicData.token ?? "", forKey: "token")
                            UserDefaults.standard.synchronize()
                            
                            appDelegate?.saveIsUserLogin(dic: true)
                            
                            if self.isFromHome == true
                            {
                                self.navigationController?.popViewController(animated: true)
                            }
                            else
                            {
                                appDelegate?.setUpHome()
                            }
                        }
                    }
                    else
                    {
                        let mainS = UIStoryboard(name: "Main", bundle: nil)
                        let vc = mainS.instantiateViewController(withIdentifier: "MobileRegisterVC") as! MobileRegisterVC
                        vc.isSocialLogin = true
                        vc.socialId = socialID
                        vc.socialDevice = socialDevice
                        vc.strName = name
                        vc.strEmail = email
                        vc.isFromHome = self.isFromHome
                        appDelegate?.saveIsGuestLogin(dic: false)
                        self.navigationController?.pushViewController(vc, animated: true)
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
    
    func isValidLogin() -> Bool
    {
        if txtEmail.text == ""
        {
            self.setUpMakeToast(msg: "Please enter mobile number".localizeString(string: Language.shared.currentAppLang))
            return false
        }
        else if (txtEmail.text?.count ?? 0) != 8
        {
            self.setUpMakeToast(msg: "Please enter valid mobile number".localizeString(string: Language.shared.currentAppLang))
            return false
        }
        else if txtPassword.text == ""
        {
            self.setUpMakeToast(msg: "Please enter password".localizeString(string: Language.shared.currentAppLang))
            return false
        }
        
        return true
    }
    
}


@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.\(appleIDCredential)")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token:- ")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data:\(appleIDToken.debugDescription)")
                return
            }
            
            let fullName = appleIDCredential.fullName
            
            let firstName = fullName?.givenName ?? fullName?.familyName
            var LastName  = fullName?.familyName ?? fullName?.givenName
            
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            let userIdentifier = appleIDCredential.user
            
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if (error != nil) {
                    print(error!.localizedDescription)
                    return
                }
                else{
                    let additionalInfo = authResult?.additionalUserInfo?.profile
                    
                    if let email = additionalInfo!["email"] as? String
                    {
                        print(email)
                        
                        self.callSocialLoginAPI(socialID: userIdentifier, socialDevice: "1", email: email, name: "\(firstName ?? "") \(LastName ?? "")")
                    }
                    else
                    {
                        
                        self.callSocialLoginAPI(socialID: userIdentifier, socialDevice: "1", email: "", name: "\(firstName ?? "") \(LastName ?? "")")
                    }
                    
                }
                
            }
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            // Handle error.
            print("Sign in with Apple errored: \(error)")
        }
        
    }
    
}
