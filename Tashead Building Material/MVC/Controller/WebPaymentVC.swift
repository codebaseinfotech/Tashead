//
//  WebPaymentVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 27/07/24.
//

import UIKit
import WebKit
import Kanna

class WebPaymentVC: UIViewController,  WKNavigationDelegate, UIWebViewDelegate
{
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    
    var webView : WKWebView!
    
    var strWebPaymentURL = ""
    
    var isFromCredit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Language.shared.isArabic {
            
            imgBack.image = UIImage(named: "Back_Ar")
            
        } else {
            
            imgBack.image = UIImage(named: "Back")
            
        }
        
        //  callGetPaymentURLAPI()
        
        DispatchQueue.main.async {
            self.webView = WKWebView()
            
            self.webView.frame = CGRect.init(x: 0, y: 0, width: self.mainView.frame.size.width, height: self.mainView.frame.size.height)
            
            self.webView.load(NSURLRequest(url: NSURL(string: self.strWebPaymentURL ?? "")! as URL) as URLRequest)
            
            self.webView.allowsBackForwardNavigationGestures = true
            
            self.webView.navigationDelegate = self
            
            self.webView.scrollView.bounces = false
            
            self.mainView.addSubview(self.webView)
            
            self.webView.navigationDelegate = self
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //    func callGetPaymentURLAPI()
    //    {
    //        let token = UserDefaults.standard.value(forKey: "token") as? String
    //
    //        var request = URLRequest(url: URL(string: "https://demo.tashead.com/do-payment")!,timeoutInterval: Double.infinity)
    //        request.addValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
    //
    //        request.addValue("XSRF-TOKEN=eyJpdiI6InBXQStkWFQzTjEzNkpMYkNxM3paeGc9PSIsInZhbHVlIjoiRDROdzJISm1XQnZ3UUhRSmZFODRTeXcxVzBkZXVEbnZnMVdrY0Z1MFkrMEhJVTZjV290OTlSVDdQK1JNVDVQMVQ1ckFCMU1QbStiNkF5QW1nSWE3bUpYNWhuemROM1NtcEp6eGV2ZVZZZDhSamlXUVZZd012bXhuMFAzQ0UvNmgiLCJtYWMiOiIxMzMyYWM3YjZjY2I4ODc4YmMxNDZjZmZhZTY2MDBhNjAzODUwZjA2MWRjZDkwZGVmNzZkMmNiNmUxODhlYjc4IiwidGFnIjoiIn0%3D; tashead_session=eyJpdiI6InhxcWQ0eERBT1pveWF6ZHdNNU5WeHc9PSIsInZhbHVlIjoiSnFaNDBTSlNGUTV4NGFQbk9jbmNkb29NSkdwcDZacndlQlJFSHBqTDhXU3NIK3VOMVlQOFNrVSs2anNwR1l1V2RPQkZ2eDZYYzMyLzFOdDFqZ1B6UzFINmU2NHVNQWl5TS9qamVYRk14blZhNkdwbkxGUmZzbDd6OUQ3eUVxUVoiLCJtYWMiOiI2ZjBlN2FjZDBmZmY0ZjhiMzhhM2UzODJlYThjMGFkZWY3YWVkMjMxZmZiNGFmNjE5YTQwODk0Y2E3MjAyYmNjIiwidGFnIjoiIn0%3D", forHTTPHeaderField: "Cookie")
    //
    //        request.httpMethod = "GET"
    //
    //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //            guard let data = data else {
    //                print(String(describing: error))
    //                return
    //            }
    //            print(String(data: data, encoding: .utf8)!)
    //
    //            let strWebPaymentURL = String(data: data, encoding: .utf8)
    //
    //            DispatchQueue.main.async {
    //                self.webView = WKWebView()
    //
    //                DispatchQueue.main.async {
    //                    self.webView.frame = CGRect.init(x: 0, y: 0, width: self.mainView.frame.size.width, height: self.mainView.frame.size.height)
    //
    //                    self.webView.load(NSURLRequest(url: NSURL(string: strWebPaymentURL ?? "")! as URL) as URLRequest)
    //
    //                    self.webView.allowsBackForwardNavigationGestures = true
    //
    //                    self.webView.navigationDelegate = self
    //
    //                    self.webView.scrollView.bounces = false
    //
    //                    self.mainView.addSubview(self.webView)
    //                }
    //
    //                self.webView.navigationDelegate = self
    //            }
    //
    //        }
    //
    //        task.resume()
    //
    //    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        APIClient.sharedInstance.showIndicator()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        APIClient.sharedInstance.hideIndicator()
        
        webView.evaluateJavaScript("window.location.href") { (result, error) in
            
            if error == nil {
                print(result as Any)
                
                let requestUrl = "\(result ?? "")"
                webView.evaluateJavaScript("document.documentElement.outerHTML") { (result, error) in
                    if error == nil {
                        print(result as Any)
                        
                        let doc = "\(result ?? "")"
                        
                        self.sfd(htmlString: "\(result ?? "")")
                        
                    }
                }
                
            }
        }
        
    }
    
    func sfd(htmlString: String)
    {
        
        // Parse the HTML
        if let doc = try? HTML(html: htmlString, encoding: .utf8) {
            // Find the span with id="object_session"
            if let span = doc.at_css("#object_session"),
               let jsonString = span.text {
                // Convert JSON string to Dictionary
                if let jsonData = jsonString.data(using: .utf8) {
                    do {
                        if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                            // Access your data
                            print(jsonDict)
                            
                            if (jsonDict["result"] as? String) == "CAPTURED"
                            {
                                
                                if appDelegate?.getIsGuestLogin() == true
                                {
                                    appDelegate?.saveIsGuestLogin(dic: false)
                                    
                                    appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
                                    appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
                                     
                                    UserDefaults.standard.set("", forKey: "token")
                                     UserDefaults.standard.synchronize()
                                    
                                    appDelegate?.saveIsUserLogin(dic: false)
                                }
 
                                
                                let mainS = UIStoryboard(name: "Home", bundle: nil)
                                let vc = mainS.instantiateViewController(withIdentifier: "ThankYouPaymentVC") as! ThankYouPaymentVC
                                vc.dicData = jsonDict
                                vc.isSuccess = true
                                vc.isFromCredit = isFromCredit
                                self.navigationController?.pushViewController(vc, animated: false)
                            }
                            else
                            {
                                
                                let mainS = UIStoryboard(name: "Home", bundle: nil)
                                let vc = mainS.instantiateViewController(withIdentifier: "ThankYouPaymentVC") as! ThankYouPaymentVC
                                vc.dicData = jsonDict
                                vc.isSuccess = false
                                vc.isFromCredit = isFromCredit
                                self.navigationController?.pushViewController(vc, animated: false)
                            }
                            
                        }
                    } catch {
                        print("Error parsing JSON: \(error)")
                    }
                }
            }
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]?
    {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
        APIClient.sharedInstance.showIndicator()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        let dict = message.body as? Dictionary<String, String>
        print(dict)
    }
}
