//
//  LoyaltyPointsVC.swift
//  Tashead Building Material
//
//  Created by iMac on 01/08/25.
//

import UIKit

class LoyaltyPointsVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var lblTotalPoints: UILabel!
    @IBOutlet weak var lblNoDataFounf: UILabel! {
        didSet {
            lblNoDataFounf.text = "No Data Found".localizeString(string: Language.shared.currentAppLang)
        }
    }
    @IBOutlet weak var imgBack: UIImageView! {
        didSet {
            imgBack.image = Language.shared.isArabic ? UIImage(named: "Back_Ar") : UIImage(named: "Back")
        }
    }
    @IBOutlet weak var lblLoyatyPoint: UILabel! {
        didSet {
            lblLoyatyPoint.text = "Loyalty Points".localizeString(string: Language.shared.currentAppLang)
        }
    }
    @IBOutlet weak var lblTotalPoint: UILabel! {
        didSet {
            lblTotalPoint.text = "Total Points".localizeString(string: Language.shared.currentAppLang) + " :"
        }
    }
    @IBOutlet weak var btnRedeem: UIButton! {
        didSet {
            btnRedeem.setTitle("Redeem".localizeString(string: Language.shared.currentAppLang), for: .normal)
        }
    }
    
    var arrLoyaltyCouponsHistory: [TBLoyaltyCouponsHistoryHistory] = [TBLoyaltyCouponsHistoryHistory]()
    
    var isApiCall = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.register(UINib(nibName: "LoyaltyPointsTblCell", bundle: nil), forCellReuseIdentifier: "LoyaltyPointsTblCell")
        tblView.delegate = self
        tblView.dataSource = self
        
        callLoyaltyCouponsHistoryAPI()
        // Do any additional setup after loading the view.
    }


    @IBAction func clickedBack(_ sender: Any) {
        appDelegate?.setUpHome()
    }
    
    @IBAction func clickedRedeem(_ sender: Any) {
        let vc = LoyaltyCouponsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func callLoyaltyCouponsHistoryAPI() {
        APIClient.sharedInstance.showIndicator()

        let param = ["":""]
        print(param)

        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(LOYALTY_COUPONS_HISTORY, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200 {
                    if status == 1 {
                        
                        if let result = response?.value(forKey: "result") as? NSDictionary {
                            self.arrLoyaltyCouponsHistory.removeAll()
                            
                            if let history = result.value(forKey: "history") as? NSArray {
                                for obj in history {
                                    let dic = TBLoyaltyCouponsHistoryHistory(fromDictionary: obj as! NSDictionary)
                                    self.arrLoyaltyCouponsHistory.append(dic)
                                }
                            }
                            
                            let point = result.value(forKey: "point") as? String
                            
                            let Points = "Points".localizeString(string: Language.shared.currentAppLang)

                            self.lblTotalPoints.text = point == "" ? "0" + " " + Points : "\(point ?? "")" + " " + Points

                            if self.arrLoyaltyCouponsHistory.count > 0 {
                                self.lblNoDataFounf.isHidden = true
                            } else {
                                self.lblNoDataFounf.isHidden = false
                            }

                            DispatchQueue.main.async {
                                self.tblView.reloadData()
                            }
                        }
                        
                    } else {
                        APIClient.sharedInstance.hideIndicator()
                    }
                } else {
                    APIClient.sharedInstance.hideIndicator()
                    
                    if message?.contains("Unauthenticated.") == true {
                        appDelegate?.strTotalCount = "0"
                        appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
                        appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
                        appDelegate?.saveIsUserLogin(dic: false)
                    }
                }
            } else {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }

}

extension LoyaltyPointsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrLoyaltyCouponsHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "LoyaltyPointsTblCell", for: indexPath) as! LoyaltyPointsTblCell
        
        let dicData = arrLoyaltyCouponsHistory[indexPath.row]
        
        cell.lblTitle.text = dicData.type == "redeem" ? "Loyalty Points Redeemed".localizeString(string: Language.shared.currentAppLang) : "Loyalty Points Credited".localizeString(string: Language.shared.currentAppLang)
        cell.lblOrderId.text = "\(dicData.orderId ?? 0)"
        cell.lblTime.text = dicData.createdAt ?? ""
        cell.lblPoints.text = "\(dicData.points ?? "") Points"
        
        cell.lblPoints.textColor = dicData.type == "redeem" ? .red : UIColor(hexString: "5ABD3B")
        
        cell.selectionStyle = .none
        return cell
    }

}
