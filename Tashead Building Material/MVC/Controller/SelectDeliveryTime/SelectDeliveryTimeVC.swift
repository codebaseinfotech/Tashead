//
//  SelectDeliveryTimeVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 21/07/25.
//

import UIKit
import SVProgressHUD

protocol didTapOnDeliveryTime: AnyObject {
    func didOnConfirm()
    func didOnSkip()
}

class SelectDeliveryTimeVC: UIViewController {
    
    @IBOutlet weak var collectionViewList: UICollectionView! {
        didSet {
            collectionViewList.register(UINib(nibName: "DeliveryTimeCell", bundle: nil), forCellWithReuseIdentifier: "DeliveryTimeCell")
            collectionViewList.register(UINib(nibName: "DeliveryTimeHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DeliveryTimeHeaderView")
            
            collectionViewList.delegate = self
            collectionViewList.dataSource = self
        }
    }
    @IBOutlet weak var lblTitleSelectDeliveryTime: UILabel! {
        didSet {
            lblTitleSelectDeliveryTime.text = "SELECT DELIVERY TIME".localizeString(string: Language.shared.currentAppLang)
        }
    }
    @IBOutlet weak var btnConfirm: UIButton! {
        didSet {
            btnConfirm.setTitle("Next".localizeString(string: Language.shared.currentAppLang), for: .normal)
        }
    }
    @IBOutlet weak var btnSkip: UIButton! {
        didSet {
            btnSkip.setTitle("Add Item".localizeString(string: Language.shared.currentAppLang), for: .normal)
        }
    }
    @IBOutlet weak var viewMain: UIView! {
        didSet {
            viewMain.clipsToBounds = true
            viewMain.layer.cornerRadius = 15
            viewMain.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        }
    }
    @IBOutlet weak var lblTitleCheckout: UILabel! {
        didSet {
            lblTitleCheckout.text = "CHECKOUT".localizeString(string: Language.shared.currentAppLang)
        }
    }
    @IBOutlet weak var viewCartCount: UIView!
    @IBOutlet weak var lblCartCoun: UILabel!
    @IBOutlet weak var imgBack: UIImageView! {
        didSet {
            imgBack.image = Language.shared.isArabic ? UIImage(named: "Back_Ar") : UIImage(named: "Back")
        }
    }
    
    var delegateAction: didTapOnDeliveryTime?
    var selectedIndexPath: IndexPath?
    
    var arrCart = TBCartListResult()
    var arrAllDeliverySolt: [TBDeliverySlotsResult] = []
    
    // MARK: - view Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        callGetDeliverySlotAPI()
        callGetCartAPI()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }

    @IBAction func clickedClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func clickedConfirm(_ sender: Any) {
        if selectedIndexPath == nil {
            self.setUpMakeToast(msg: "Please select delivery slot")
        } else {
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let home: MyCartVC = mainStoryboard.instantiateViewController(withIdentifier: "MyCartVC") as! MyCartVC
    //        home.objCart = self.arrCart
            self.navigationController?.pushViewController(home, animated: false)
        }
    }
    @IBAction func clickedSkip(_ sender: Any) {
        appDelegate?.setUpHome()
    }
    
    // MARK: - call cartAPI
    
    func callGetDeliverySlotAPI()
    {
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(GET_DELIVERY_SLOT, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        APIClient.sharedInstance.hideIndicator()
                        if let result = response?.value(forKey: "result") as? NSArray {
                            for obj in result {
                                let dicData = TBDeliverySlotsResult(fromDictionary: obj as! NSDictionary)
                                if dicData.slots.count > 0 {
                                    self.arrAllDeliverySolt.append(dicData)
                                }
                            }
                        }
                        
//                        if self.arrAllDeliverySolt.count > 0 {
//                            self.selectedIndexPath = IndexPath(item: 0, section: 0)
//                        }
                        self.collectionViewList.reloadData()
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                    }
                    
                }
                else
                {
                    APIClient.sharedInstance.hideIndicator()
                    if message?.contains("Unauthenticated.") == true
                    {
                        appDelegate?.strTotalCount = "0"
                        
                        appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
                        appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
                        
                        appDelegate?.saveIsUserLogin(dic: false)
                    }
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
        }
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
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        if let dicResult = response?.value(forKey: "result") as? NSDictionary
                        {
                            let dicData = TBCartListResult(fromDictionary: dicResult)
                            self.arrCart = dicData
                        }
                        
                        appDelegate?.strTotalCount = "\(self.arrCart.cartItems.count)"
                        self.lblCartCoun.text = appDelegate?.strTotalCount
                        /*if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCartCount.isHidden = true
                            
                        }
                        else
                        {
                            self.viewCartCount.isHidden = false
                        }*/
                    }
                    else
                    {
                        self.lblCartCoun.text = "0"
                        appDelegate?.strTotalCount = "0"
                        
                        /*if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCartCount.isHidden = true
                        }
                        else
                        {
                            self.viewCartCount.isHidden = false
                        }*/
                        APIClient.sharedInstance.hideIndicator()
                    }
                    
                }
                else
                {
                    self.lblCartCoun.text = "0"
                    appDelegate?.strTotalCount = "0"
                    
                    /*if appDelegate?.strTotalCount == "0"
                    {
                        self.viewCartCount.isHidden = true
                    }
                    else
                    {
                        self.viewCartCount.isHidden = false
                    }*/
                    
                    APIClient.sharedInstance.hideIndicator()
                    
                    if message?.contains("Unauthenticated.") == true
                    {
                        appDelegate?.strTotalCount = "0"
                        
                        appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
                        appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
                        
                        appDelegate?.saveIsUserLogin(dic: false)
                    }
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
   

}

// MARK: - collectionView Delegate & DataSource
extension SelectDeliveryTimeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return arrAllDeliverySolt.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrAllDeliverySolt[section].slots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeliveryTimeCell", for: indexPath) as! DeliveryTimeCell
        
        let dicData = arrAllDeliverySolt[indexPath.section].slots[indexPath.item]
        
        cell.isUserInteractionEnabled = dicData.remaining_slots == 0 ? false : true
        
        cell.lblTime.text = dicData.startTime + "-" + dicData.endTime
        cell.lblTime.textColor = dicData.remaining_slots == 0 ? .lightGray : #colorLiteral(red: 0.2779999971, green: 0.2669999897, blue: 0.3330000043, alpha: 1)
        
        cell.viewMain.borderColor = dicData.remaining_slots == 0 ? .lightGray : #colorLiteral(red: 0.9529411765, green: 0.7960784314, blue: 0.5921568627, alpha: 1)
        
        cell.viewMain.backgroundColor = selectedIndexPath == indexPath ? #colorLiteral(red: 0.9529411765, green: 0.7960784314, blue: 0.5921568627, alpha: 1) : .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        let dicData = arrAllDeliverySolt[indexPath.section].slots[indexPath.item]
        
        if selectedIndexPath == indexPath {
            AppManager.shared.delivery_day_slot_id = dicData.id ?? 0
            AppManager.shared.booked_slot_time = dicData.startTime + " To " + dicData.endTime
            AppManager.shared.delivery_date = arrAllDeliverySolt[indexPath.section].date
            
        }
        
        print(AppManager.shared.booked_slot_time)
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DeliveryTimeHeaderView", for: indexPath) as! DeliveryTimeHeaderView
            
            let dicData = arrAllDeliverySolt[indexPath.section]
            
            let dateString = dicData.date ?? ""
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.locale = Locale(identifier: "en_US_POSIX")

            var date23 = ""
            if let date = formatter.date(from: dateString) {
                formatter.dateFormat = "dd MMM"
                let shortDate = formatter.string(from: date)
                date23 = dicData.day + ", " + shortDate
                print(shortDate)  // Output: 04 Aug
            } else {
                print("Invalid date format")
            }
            
            header.lblMonthName.text = dicData.day == "Today" ? dicData.day : date23
            
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 35) // Adjust height as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sitemsPerRow : CGFloat = 3
        let availableWidth = collectionView.frame.width - 16
        let widthPerItem = availableWidth / sitemsPerRow
        
        return CGSize(width: widthPerItem, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
