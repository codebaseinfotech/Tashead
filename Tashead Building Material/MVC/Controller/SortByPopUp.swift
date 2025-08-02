//
//  SortByPopUp.swift
//  Tashead Building Material
//
//  Created by iMac on 01/07/25.
//

import UIKit

protocol onSelectFilter {
    func selectFilterType(type: String)
}

class SortByPopUp: UIViewController {

    @IBOutlet weak var TblView: UITableView!
    @IBOutlet weak var viewMain: UIView!
    
    var arrList = ["Newest First", "A to Z", "Z to A", "Price: Low to High", "Price: High to Low"]
    
    var selectedIndex: Int? = nil
    
    var delegateFilterType: onSelectFilter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TblView.delegate = self
        TblView.dataSource = self
        TblView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        viewMain.clipsToBounds = true
        viewMain.layer.cornerRadius = 30
        viewMain.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func clickedClosePopup(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension SortByPopUp: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.TblView.dequeueReusableCell(withIdentifier: "TblViewCell") as! TblViewCell
        
        if selectedIndex == indexPath.row {
            cell.imgCheck.image = UIImage(named: "ic_Checkbox")
        } else {
            cell.imgCheck.image = UIImage(named: "ic_UnCheckbox")
        }
        
        cell.lblListName.text = arrList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        TblView.reloadData()

        var type = ""
        
        if indexPath.item == 0 {
            type = "newest"
        } else if indexPath.item == 1 {
            type = "name_asc"
        } else if indexPath.item == 2 {
            type = "name_desc"
        } else if indexPath.item == 3 {
            type = "price_asc"
        } else if indexPath.item == 4 {
            type = "price_desc"
        }
        
        delegateFilterType?.selectFilterType(type: type)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

class TblViewCell: UITableViewCell {
    
    @IBOutlet weak var lblListName: UILabel!
    @IBOutlet weak var imgCheck: UIImageView!
    
}
