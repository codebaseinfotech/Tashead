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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.register(UINib(nibName: "LoyaltyCouponsTblCell", bundle: nil), forCellReuseIdentifier: "LoyaltyCouponsTblCell")
        tblView.delegate = self
        tblView.dataSource = self
        // Do any additional setup after loading the view.
    }

    @IBAction func clickedBack(_ sender: Any) {
        appDelegate?.setUpHome()
    }
    

}

extension LoyaltyCouponsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "LoyaltyCouponsTblCell", for: indexPath) as! LoyaltyCouponsTblCell
        
        cell.selectionStyle = .none
        return cell
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
}
