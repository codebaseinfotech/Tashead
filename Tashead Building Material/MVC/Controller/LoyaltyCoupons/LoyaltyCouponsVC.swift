//
//  LoyaltyCouponsVC.swift
//  Tashead Building Material
//
//  Created by iMac on 04/08/25.
//

import UIKit

class LoyaltyCouponsVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblTotalPoints: UILabel!
    
    var dicLoyaltyCoupons = TBLoyaltyCouponsResult()
    var isApiCall = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.register(UINib(nibName: "LoyaltyCouponsTblCell", bundle: nil), forCellReuseIdentifier: "LoyaltyCouponsTblCell")
        tblView.delegate = self
        tblView.dataSource = self
        
        callLoyaltyCouponsAPI()
        // Do any additional setup after loading the view.
    }

    @IBAction func clickedBack(_ sender: Any) {
//        appDelegate?.setUpHome()
        self.navigationController?.popViewController(animated: true)
    }
    
    func callLoyaltyCouponsAPI() {
        APIClient.sharedInstance.showIndicator()

        let param = ["":""]
        print(param)

        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(LOYALTY_COUPONS, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200 {
                    if status == 1 {
                        
                        if let result = response?.value(forKey: "result") as? NSDictionary {
                            let dic = TBLoyaltyCouponsResult(fromDictionary: result)
                            self.dicLoyaltyCoupons = dic
                            
                            self.lblTotalPoints.text = dic.point == "" ? "0" + " Points" : "\(dic.point ?? "")" + " Points"
                            
                            DispatchQueue.main.async {
                                self.isApiCall = true
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

extension LoyaltyCouponsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isApiCall == true {
            return dicLoyaltyCoupons.coupons.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "LoyaltyCouponsTblCell", for: indexPath) as! LoyaltyCouponsTblCell
        
        if isApiCall == true {
            let dicData = dicLoyaltyCoupons.coupons[indexPath.row]
            cell.lblKD.text = "\(dicData.amount ?? "") KD"
            cell.lblPoints.text = "\(dicData.point ?? 0) Points"
            
            var media_link_url = "\(dicData.image ?? "")"
            media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            cell.imgCoupons.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
        }
        
        cell.selectionStyle = .none
        return cell
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
}
