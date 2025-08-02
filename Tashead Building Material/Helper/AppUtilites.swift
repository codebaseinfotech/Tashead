//
//  AppUtilites.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 31/05/23.
//

import UIKit
import Foundation
import Toast_Swift

class AppUtilites: NSObject {
    
    class var sharedInstance: AppUtilites {
        struct Static {
            static let instance: AppUtilites = AppUtilites()
        }
        return Static.instance
    }
    
    class var deviceHasTopNotch: Bool {
        if #available(iOS 11.0,  *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    func getViewController(controllerName: String) -> UIViewController {
        return mainStoryboard.instantiateViewController(withIdentifier: controllerName)
    }
    
    class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    class func isValidPhone(value: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    class func validateMobile(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
    }

   class func isValidPassword(value: String) -> Bool {
        // least one uppercase,
        // least one digit
        // least one lowercase
        // least one symbol
        //  min 8 characters total

        value.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: value)
    }
    
    class func isPasswordValid(_ Password : String) -> Bool{
        let Password = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z](?=.*[0-9].{>6}$")
        return Password.evaluate(with: Password)
    }

    
    // MARK: - AlertView
    
    class func showAlert(title: String, message: String, cancelButtonTitle: String) {
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: cancelButtonTitle, style: .default))
        window.visibleViewController?.present(alertView, animated: true)
        
    }
    
    class func showAlert(title: String, message: String, actionButtonTitle: String, completionHandler : @escaping () -> Void) {
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertView.addAction(UIAlertAction(title: actionButtonTitle, style: .default, handler: { (_) in
            completionHandler()
        }))
        
        window.visibleViewController?.present(alertView, animated: true)
        
    }
    
    class func showAlert(title: String, message: String, actionButtonTitle: String, cancelButtonTitle: String, completionHandler : @escaping () -> Void) {
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertView.addAction(UIAlertAction(title: actionButtonTitle, style: .default, handler: { (_) in
            completionHandler()
        }))
        
        alertView.addAction(UIAlertAction(title: cancelButtonTitle, style: .default, handler: nil))
        
        window.visibleViewController?.present(alertView, animated: true)
        
    }
    
}

public extension UIWindow {
    var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(self.rootViewController)
    }
    
    static func getVisibleViewControllerFrom(_ vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(pvc)
            } else {
                return vc
            }
        }
    }
}

extension UIDevice {
    var hasNotch: Bool
    {
        if #available(iOS 11.0, tvOS 11.0, *) {
            let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
            return bottom > 0
        } else {
            return false
        }
    }
    
    /*
     if UIDevice.current.hasNotch
     {
         //... consider notch
     }
     else
     {
        //... don't have to consider notch
     }
     */
}

extension UIViewController
{
    func setUpMakeToast(msg: String)
    {
        setUpHideToast()
        self.view.makeToast(msg ,position: .center)
        
//        let window = UIApplication.shared.windows
//        window.last?.makeToast(msg,position: .center)
    }
    
    func setUpHideToast()
    {
        self.view.hideToast()
        let window = UIApplication.shared.windows
        window.last?.hideToast()
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data(base64Encoded: imageBase64String)
        let image = UIImage(data: imageData!)
        return image!
    }
     
    
}
