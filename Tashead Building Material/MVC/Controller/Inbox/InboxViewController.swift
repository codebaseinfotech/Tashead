//
//  InboxViewController.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 09/07/25.
//

import UIKit

class InboxViewController: UIViewController {

    @IBOutlet weak var lblInboxTitle: UILabel!
    @IBOutlet weak var viewCartCount: UIView!
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var tblView: UITableView! {
        didSet {
            
            tblView.register(UINib(nibName: "InboxTableViewCell", bundle: nil), forCellReuseIdentifier: "InboxTableViewCell")
            
            tblView.delegate = self
            tblView.dataSource = self
        }
    }
    @IBOutlet weak var imgBack: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgBack.image = Language.shared.isArabic ? UIImage(named: "Back_Ar") : UIImage(named: "Back")
            
        lblInboxTitle.text = "Inbox".localizeString(string: Language.shared.currentAppLang)
        callGetCartAPI()
        
        // Do any additional setup after loading the view.
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
                        
                        appDelegate?.strTotalCount = "\(arrCart.count)"
                        
                        if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCartCount.isHidden = true
                        }
                        else
                        {
                            self.viewCartCount.isHidden = true
                        }
                        
                        self.lblCartCount.text = "\(arrCart.count)"
                    }
                    else
                    {
                        appDelegate?.strTotalCount = "0"
                        self.lblCartCount.text = "0"
                        
                        if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCartCount.isHidden = true
                        }
                        else
                        {
                            self.viewCartCount.isHidden = true
                        }
                        
                        APIClient.sharedInstance.hideIndicator()
                    }
                    
                }
                else
                {
                    if appDelegate?.strTotalCount == "0"
                    {
                        self.viewCartCount.isHidden = true
                    }
                    else
                    {
                        self.viewCartCount.isHidden = true
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
    
    

}

extension InboxViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InboxTableViewCell") as! InboxTableViewCell
        
        cell.lblMessage.textAlignment = Language.shared.isArabic ? .right : .left
        cell.lblDescrption.textAlignment = Language.shared.isArabic ? .right : .left
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = InboxDetailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("InboxHeaderView", owner: self, options: [:])?.first as! InboxHeaderView

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
}
