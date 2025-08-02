//
//  AppDelegate.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 31/05/23.
//
//com.Tashead
import UIKit
import IQKeyboardManagerSwift
import LGSideMenuController
import GoogleSignIn
import Firebase
import GooglePlaces
import GoogleMaps
import FBSDKLoginKit
import FBSDKCoreKit
import OneSignal
 
@main
class AppDelegate: UIResponder, UIApplicationDelegate, OSPermissionObserver, OSSubscriptionObserver, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    var dicCurrentLoginUser = TBLoginUserResult()
    
    var strPhone = ""
    
    var strTotalCount = "0"
    var isOrder = false
    var strOrder = ""
    
    var kuwaitCurrentLat = 29.378586
    var kuwaitCurrentLong = 47.990341
 
    var objWhichController = UIViewController()
    
    var isFirstTime = false
    var isFirstTimeAddress = false
    
    var devicePushToken = "123"
    let deviceSerialId = UIDevice.current.identifierForVendor?.uuidString
    
    var delivery_slot_allowed: Int = 0
    
    var is_default = -1
    
    var user_commission = 0.0
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        isFirstTime = true
        isFirstTimeAddress = true
        
        IQKeyboardManager.shared.enable = true
        
        // Remove this method to stop OneSignal Debugging
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        //        setNotificaationTag()
        // OneSignal initialization
        
        let notificationReceivedBlock: OSHandleNotificationReceivedBlock = { notification in
            
            print("Received Notification: ", notification!.payload.notificationID!)
            print("launchURL: ", notification?.payload.launchURL ?? "No Launch Url")
            print("content_available = \(notification?.payload.contentAvailable ?? false)")
            
            print("content_available = \(notification?.payload.body ?? "")")
            
        }
        
        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
            // This block gets called when the user reacts to a notification received
            let payload: OSNotificationPayload? = result?.notification.payload
            
            print("Message: ", payload!.body!)
            print("badge number: ", payload?.badge ?? 0)
            print("notification sound: ", payload?.sound ?? "No sound")
            
        }
        
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false, kOSSettingsKeyInAppLaunchURL: true, ]
        
        OneSignal.initWithLaunchOptions(launchOptions, appId: oneSignalId, handleNotificationReceived: notificationReceivedBlock, handleNotificationAction: notificationOpenedBlock, settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification
        
        OneSignal.getUserDevice()?.getUserId()
        // promptForPushNotifications will show the native iOS notification permission prompt.
        // We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 8)
        
        OneSignal.add(self as OSPermissionObserver)
        
        OneSignal.add(self as OSSubscriptionObserver)
        
        devicePushToken = OneSignal.getUserDevice()?.getUserId() ?? ""
        
        print("OneSignal devicePushToken \(devicePushToken)")
        
        FirebaseApp.configure()
        
        GMSServices.provideAPIKey(GOOGLE_KEY)
        GMSPlacesClient.provideAPIKey(GOOGLE_KEY)
        
        GIDSignIn.sharedInstance().clientID = "383455892930-6cgqo0j732em7503hbsvv413it44fkvu.apps.googleusercontent.com"
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        setSemantricFlow()
        
        setupPush()
        
        registerForRemoteNotification()
        
        callApplicationSettingAPI()
        
        //        if let isFinishaWalcome = UserDefaults.standard.value(forKey: "isFinishaWalcome") as? Bool
        //        {
        //            if isFinishaWalcome == true
        //            {
        if self.getIsUserLogin() == true
        {
            dicCurrentLoginUser = getCurrentUserData()
            
            setNotificaationTag()
            
            setUpHome()
        }
        else
        {
            setUpHome()
        }
        //            }
        //            else
        //            {
        //                setUpHome()
        //            }
        //        }
        //        else
        //        {
        //            setUpHome()
        //        }
        
        return true
    }
    
    func onOSPermissionChanged(_ stateChanges: OSPermissionStateChanges!) {
        print("PermissionStateChanges: ", stateChanges!)
    }
    
    func onOSSubscriptionChanged(_ stateChanges: OSSubscriptionStateChanges!) {
        print("Subscribed for OneSignal push notifications!")
    }
    
    func setupPush()
    {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            // Handle user allowing / declining notification permission. Example:
            if (granted) {
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.registerForRemoteNotifications()
                })
            } else {
                print("User declined notification permissions")
            }
        }
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            // UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        if #available(iOS 10.0, *) {
            
            let center = UNUserNotificationCenter.current()
            // center.delegate  = self
            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                if (granted)
                {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                    
                }
            }
        }
        else{
            
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
            
        }
        
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func registerForRemoteNotification() {
        if #available(iOS 10.0, *) {
#if !(arch(i386) || arch(x86_64))
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                if granted {
                    UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings: UNNotificationSettings) -> Void  in
                        guard settings.authorizationStatus == UNAuthorizationStatus.authorized else {
                            return
                        }
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                    })
                }
            }
#endif
        } else {
#if !(arch(i386) || arch(x86_64))
            let notificationSettings = UIUserNotificationSettings(types: [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notificationSettings)
            UIApplication.shared.registerForRemoteNotifications()
#endif
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        
        print("User declined notification didReceive")
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any])
    {
        
        print("User declined notification didReceiveRemoteNotification")
        print(userInfo)
        let state = UIApplication.shared.applicationState
        
        //        let myBookingVC = MyBookingVC()
        //         if let navigation = self.window?.rootViewController as? UINavigationController
        //        {
        //            navigation.pushViewController(myBookingVC, animated: true)
        //        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        let userInfo = notification.request.content.userInfo
        
        print(userInfo)
        
        completionHandler([.alert, .badge, .sound])
    }
    
    
    func application(
            _ app: UIApplication,
            open url: URL,
            options: [UIApplication.OpenURLOptionsKey : Any] = [:]
        ) -> Bool {
            return ApplicationDelegate.shared.application(
                app,
                open: url,
                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
            )
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
                            self.saveApplicationSettingData(dic: dicData)
                            
                            self.delivery_slot_allowed = dicData.businessrules.deliverySlotAllowed
                            if dicData.businessrules.fullPageAdSwitch == 1
                            {
                                self.callCmsAdverdAPI()
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
                        appDelegate?.saveCmsAdverd(dic: TBCmsAdverdResult())
                        var arrAddressList : [TBAddressResult] = [TBAddressResult]()
                        appDelegate?.saveUserAllAddress(dic: arrAddressList)
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
    
    func callCmsAdverdAPI()
    {
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderGet(CMC_ADVERD, parameters: param) { response, error, statusCode in
            
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
                            let dicData = TBCmsAdverdResult(fromDictionary: dicResult)
                            self.saveCmsAdverd(dic: dicData)
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
                        appDelegate?.saveCmsAdverd(dic: TBCmsAdverdResult())
                        var arrAddressList : [TBAddressResult] = [TBAddressResult]()
                        appDelegate?.saveUserAllAddress(dic: arrAddressList)
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
    

    
    func setUpHome()
    {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let home: NewHomeVC = mainStoryboard.instantiateViewController(withIdentifier: "NewHomeVC") as! NewHomeVC
        let homeNavigation = UINavigationController(rootViewController: home)
        let leftViewController: SideMenuVC = mainStoryboard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        
        if Language.shared.isArabic {
            
            let controller = LGSideMenuController.init(rootViewController: homeNavigation, leftViewController: nil, rightViewController: leftViewController)
            controller.leftViewWidth = home.view.frame.size.width - 70
            homeNavigation.navigationBar.isHidden = true
            self.window?.rootViewController = controller
            self.window?.makeKeyAndVisible()
        }
        else
        {
            let controller = LGSideMenuController.init(rootViewController: homeNavigation, leftViewController: leftViewController, rightViewController: nil)
            controller.leftViewWidth = home.view.frame.size.width - 70
            homeNavigation.navigationBar.isHidden = true
            self.window?.rootViewController = controller
            self.window?.makeKeyAndVisible()
        }
        
        
    }
    
    func setUpWelcome()
    {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let home: WelcomeVC = mainStoryboard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
        let homeNavigation = UINavigationController(rootViewController: home)
        homeNavigation.navigationBar.isHidden = true
        self.window?.rootViewController = home
        self.window?.makeKeyAndVisible()
    }
    
    func setUpLogin()
    {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let home: LoginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let homeNavigation = UINavigationController(rootViewController: home)
        let HomeStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let leftViewController: SideMenuVC = HomeStoryboard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        
        if Language.shared.isArabic {
            let controller = LGSideMenuController.init(rootViewController: homeNavigation, leftViewController: nil, rightViewController: leftViewController)
            controller.leftViewWidth = home.view.frame.size.width - 70
            homeNavigation.navigationBar.isHidden = true
            self.window?.rootViewController = controller
            self.window?.makeKeyAndVisible()
        }
        else
        {
            let controller = LGSideMenuController.init(rootViewController: homeNavigation, leftViewController: leftViewController, rightViewController: nil)
            controller.leftViewWidth = home.view.frame.size.width - 70
            homeNavigation.navigationBar.isHidden = true
            self.window?.rootViewController = controller
            self.window?.makeKeyAndVisible()
        }
        
        
    }
    
    func saveCuurentUserData(dic: TBLoginUserResult)
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: dic)
        UserDefaults.standard.setValue(data, forKey: "currentUserDataTB")
        UserDefaults.standard.synchronize()
    }
    
    func getCurrentUserData() -> TBLoginUserResult
    {
        if let data = UserDefaults.standard.object(forKey: "currentUserDataTB"){
            
            let arrayObjc = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
            return arrayObjc as! TBLoginUserResult
        }
        return TBLoginUserResult()
    }
    
    
    func saveApplicationSettingData(dic: TBApplicationSettingsResult)
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: dic)
        UserDefaults.standard.setValue(data, forKey: "ApplicationSettingData")
        UserDefaults.standard.synchronize()
    }
    
    func getApplicationSettingData() -> TBApplicationSettingsResult
    {
        if let data = UserDefaults.standard.object(forKey: "ApplicationSettingData"){
            
            let arrayObjc = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
            return arrayObjc as! TBApplicationSettingsResult
        }
        return TBApplicationSettingsResult()
    }
    
    func saveUserAllAddress(dic: [TBAddressResult])
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: dic)
        UserDefaults.standard.setValue(data, forKey: "UserAllAddress")
        UserDefaults.standard.synchronize()
    }
    
    func getUserAllAddress() -> [TBAddressResult]
    {
        if let data = UserDefaults.standard.object(forKey: "UserAllAddress"){
            
            let arrayObjc = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
            return arrayObjc as! [TBAddressResult]
        }
        return [TBAddressResult]()
    }
    
    
    func saveUserSelectedAddress(dic: TBAddressResult)
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: dic)
        UserDefaults.standard.setValue(data, forKey: "UserSelectedAddress")
        UserDefaults.standard.synchronize()
    }
    
    func getUserSelectedAddress() -> TBAddressResult
    {
        if let data = UserDefaults.standard.object(forKey: "UserSelectedAddress"){
            
            let arrayObjc = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
            return arrayObjc as! TBAddressResult
        }
        return TBAddressResult()
    }
    
    func saveCmsAdverd(dic: TBCmsAdverdResult)
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: dic)
        UserDefaults.standard.setValue(data, forKey: "CmsAdverdResult")
        UserDefaults.standard.synchronize()
    }
    
    func getCmsAdverd() -> TBCmsAdverdResult
    {
        if let data = UserDefaults.standard.object(forKey: "CmsAdverdResult"){
            
            let arrayObjc = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
            return arrayObjc as! TBCmsAdverdResult
        }
        return TBCmsAdverdResult()
    }
    
    func saveIsGuestLogin(dic: Bool)
    {
        UserDefaults.standard.set(dic, forKey: "IsGuestLogin")
        UserDefaults.standard.synchronize()
    }
    
    func getIsGuestLogin() -> Bool
    {
        return UserDefaults.standard.bool(forKey: "IsGuestLogin")
    }    
    
    func saveIsUserLogin(dic: Bool)
    {
        UserDefaults.standard.set(dic, forKey: "isUserLogin")
        UserDefaults.standard.synchronize()
    }
    
    func getIsUserLogin() -> Bool
    {
        return UserDefaults.standard.bool(forKey: "isUserLogin")
    }
    
    func setNotificaationTag() {
        guard let userId = appDelegate?.dicCurrentLoginUser.id else {
            return
        }
        
        var json: [String: Any] = [:]
        json["isNoti"] = "1"
        json["deviceType"] = "1"
        json["language"] = Language.shared.currentAppLang
        json["userId"] = userId
       
        print("setNotificaationTag \(json)")
        OneSignal.sendTags(json)
        OneSignal.setExternalUserId("\(userId)")
    }
    
}
 
