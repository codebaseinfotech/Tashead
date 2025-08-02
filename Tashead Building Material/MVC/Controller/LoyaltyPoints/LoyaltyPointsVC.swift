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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.register(UINib(nibName: "LoyaltyPointsTblCell", bundle: nil), forCellReuseIdentifier: "LoyaltyPointsTblCell")
        tblView.delegate = self
        tblView.dataSource = self
        // Do any additional setup after loading the view.
    }


    @IBAction func clickedBack(_ sender: Any) {
        appDelegate?.setUpHome()
    }
    

}

extension LoyaltyPointsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "LoyaltyPointsTblCell", for: indexPath) as! LoyaltyPointsTblCell
        
        cell.selectionStyle = .none
        return cell
    }

}
