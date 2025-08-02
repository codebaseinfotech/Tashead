//
//  APIClient.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 31/05/23.
//

import Foundation
import Alamofire
import SVProgressHUD
import UIKit

class APIClient: NSObject {
    
    typealias completion = ( _ result: Dictionary<String, Any>, _ error: Error?) -> ()
    
    class var sharedInstance: APIClient {
        
        struct Static {
            static let instance: APIClient = APIClient()
        }
        return Static.instance
    }
    
    var responseData: NSMutableData!
    
    func pushNetworkErrorVC()
    {
        
    }
    
    
    func MakeAPICallWithAuthHeaderDelete(_ url: String, parameters: [String: Any], completionHandler:@escaping (NSDictionary?, Error?, Int?) -> Void) {
        
        print("url = \(BASE_URL + url)")
        
        if NetConnection.isConnectedToNetwork() == true
        {
            let token = UserDefaults.standard.value(forKey: "token") as? String
            
            let headers: HTTPHeaders = ["Accept": "application/json","device_type":"ios","Authorization": "Bearer \(token ?? "")","apiToken":"123","language":Language.shared.currentAppLang]
            print(headers)
            let rawString = BASE_URL + url
            
            let cleanedString = rawString.trimmingCharacters(in: .whitespacesAndNewlines)
                .components(separatedBy: .controlCharacters).joined()
            
            AF.request(cleanedString, method: .delete, parameters: parameters, encoding: URLEncoding(destination: .methodDependent), headers: headers).responseJSON { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? NSDictionary) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }
    
    func MakeAPICallWithAuthHeaderPost(_ url: String, parameters: [String: Any], completionHandler:@escaping (NSDictionary?, Error?, Int?) -> Void) {
        
        print("url = \(BASE_URL + url)")
        
        if NetConnection.isConnectedToNetwork() == true
        {
            let token = UserDefaults.standard.value(forKey: "token") as? String
            
            let headers: HTTPHeaders = ["Accept": "application/json","device_type":"ios","Authorization": "Bearer \(token ?? "")","apiToken":"123","language":Language.shared.currentAppLang]
            
            print(headers)
            
            let rawString = BASE_URL + url
            
            let cleanedString = rawString.trimmingCharacters(in: .whitespacesAndNewlines)
                .components(separatedBy: .controlCharacters).joined()
            
            AF.request(cleanedString, method: .post, parameters: parameters, encoding: URLEncoding(destination: .methodDependent), headers: headers).responseJSON { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? NSDictionary) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }
    
    
    func MakeAPICallWithoutAuthHeaderPost(_ url: String, parameters: [String: Any], completionHandler:@escaping (NSDictionary?, Error?, Int?) -> Void) {
        
        print("url = \(BASE_URL + url)")
        
        if NetConnection.isConnectedToNetwork() == true
        {
            let headers: HTTPHeaders = ["apiToken": "123","device_type":"ios","Accept": "application/json","language":Language.shared.currentAppLang]
            print(headers)
            let rawString = BASE_URL + url
            
            let cleanedString = rawString.trimmingCharacters(in: .whitespacesAndNewlines)
                .components(separatedBy: .controlCharacters).joined()
            
            AF.request(cleanedString, method: .post,parameters: parameters, encoding: URLEncoding(destination: .methodDependent), headers: headers).responseJSON { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? NSDictionary) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }
    
    func MakeAPICallWithoutAuthHeaderGet(_ url: String, parameters: [String: Any], completionHandler:@escaping (NSDictionary?, Error?, Int?) -> Void) {
        
        print("url = \(BASE_URL + url)")
        
        if NetConnection.isConnectedToNetwork() == true
        {
            let headers: HTTPHeaders = ["apiToken": "123","device_type":"ios","Accept": "application/json","language":Language.shared.currentAppLang]
            print(headers)
            let rawString = BASE_URL + url
            
            let cleanedString = rawString.trimmingCharacters(in: .whitespacesAndNewlines)
                .components(separatedBy: .controlCharacters).joined()
            
            AF.request(cleanedString, method: .get, encoding: URLEncoding(destination: .methodDependent), headers: headers).responseJSON { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? NSDictionary) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }
    
    func MakeAPICallWithAuthHeaderGet(_ url: String, parameters: [String: Any], completionHandler:@escaping (NSDictionary?, Error?, Int?) -> Void) {
        
        print("url = \(BASE_URL+url)")
        
        if NetConnection.isConnectedToNetwork() == true
        {
            let token = UserDefaults.standard.value(forKey: "token") as? String
            
            let headers: HTTPHeaders = ["Accept": "application/json","device_type":"ios","Authorization": "Bearer \(token ?? "")","apiToken":"123","language":Language.shared.currentAppLang]
            print(headers)
            let rawString = BASE_URL + url
            
            let cleanedString = rawString.trimmingCharacters(in: .whitespacesAndNewlines)
                .components(separatedBy: .controlCharacters).joined()
            
            AF.request(cleanedString, method: .get, parameters: parameters, encoding: URLEncoding(destination: .methodDependent), headers: headers).responseJSON { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? NSDictionary) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }
    
    
    func MakeAPICallWithAuthHeaderGetString(_ url: String, parameters: [String: Any], completionHandler:@escaping (String?, Error?, Int?) -> Void) {
        
        print("url = \(url)")
        
        if NetConnection.isConnectedToNetwork() == true
        {
            let token = UserDefaults.standard.value(forKey: "token") as? String
            
            let headers: HTTPHeaders = ["Accept": "application/json","device_type":"ios","Authorization": "Bearer \(token ?? "")","apiToken":"123","language":Language.shared.currentAppLang]
            
            AF.request(url, method: .get, encoding: URLEncoding(destination: .methodDependent), headers: nil).responseJSON { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? String) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }
    
    
    func showIndicator(){
        SVProgressHUD.show()
    }
    
    func hideIndicator(){
        SVProgressHUD.dismiss()
    }
    
    func showSuccessIndicator(message: String){
        SVProgressHUD.showSuccess(withStatus: message)
    }
}

