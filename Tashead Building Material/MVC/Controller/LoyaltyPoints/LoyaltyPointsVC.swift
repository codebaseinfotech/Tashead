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
                            
                            self.lblTotalPoints.text = point == "" || point == nil ? "0" + " Points" : "\(point ?? "")" + " Points"
                            
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
        
        cell.lblTitle.text = (dicData.couponTitle?.isEmpty == false) ? dicData.couponTitle : "Loyalty Points Credited"
        cell.lblOrderId.text = "\(dicData.orderId ?? 0)"
        cell.lblTime.text = dicData.createdAt ?? ""
        cell.lblPoints.text = "\(dicData.points ?? "") Points"
        
        cell.selectionStyle = .none
        return cell
    }

}
