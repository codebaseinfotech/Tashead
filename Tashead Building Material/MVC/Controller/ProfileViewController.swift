//
//  ProfileViewController.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 11/12/23.
//

import UIKit

protocol onUpdateAddress{
    func updateAddress(isUpdate: Bool, id: Int)
}

class ProfileViewController: UIViewController, onUpdateAddress, UITextViewDelegate {
    
    @IBOutlet weak var ViewAlrtt: UIView!
    
    @IBOutlet weak var mainViewPopp: UIView!
    @IBOutlet weak var lblAlert: UILabel!
    @IBOutlet weak var lblDeleteAdd: UILabel!
    
    @IBOutlet weak var btnYesDelete: UIButton!
    @IBOutlet weak var btnNoDelete: UIButton!
    
    
    
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var viewCountItem: UIView!
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtComment: UITextView!
    
    @IBOutlet weak var lblTProfiele: UILabel!
    @IBOutlet weak var lblTMyAddrss: UILabel!
    
    @IBOutlet weak var btnTUpdate: UIButton!
    @IBOutlet weak var btnTChangePass: UIButton!
    @IBOutlet weak var btnTLogout: UIButton!
    @IBOutlet weak var btnDeleteAccount: UIButton!
    
    
    @IBOutlet weak var collectionViewAddress: UICollectionView!
    
    @IBOutlet weak var imgBack: UIImageView!
    
    let sectionInsets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    let sitemsPerRow : CGFloat = 1
    var flowLayout: UICollectionViewFlowLayout {
        let _flowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.sectionInsets.left * (self.sitemsPerRow + 1)
            let availableWidth = self.collectionViewAddress.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.sitemsPerRow
            
            _flowLayout.itemSize = CGSize(width: widthPerItem, height: 100)
            
            _flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
            _flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
            _flowLayout.minimumInteritemSpacing = 0
            _flowLayout.minimumLineSpacing = 10
        }
        // edit properties here
        return _flowLayout
    }
    
    var dicProfileDetail = TBLoginUserResult()
    
    var arrAddressList : [TBAddressResult] = [TBAddressResult]()
    
    var isAPICall = false
    
    var strAddressID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblAlert.text = "Alert".localizeString(string: Language.shared.currentAppLang)
        lblDeleteAdd.text = "Would you like to delete this address?".localizeString(string: Language.shared.currentAppLang)
        btnYesDelete.setTitle("YES".localizeString(string: Language.shared.currentAppLang), for: .normal)
        btnNoDelete.setTitle("NO".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        ViewAlrtt.clipsToBounds = true
        ViewAlrtt.layer.cornerRadius = 15
        ViewAlrtt.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        
        if Language.shared.isArabic {
            imgBack.image = UIImage(named: "Back_Ar")
            
            collectionViewAddress.semanticContentAttribute = .forceRightToLeft
        }
        else
        {
            imgBack.image = UIImage(named: "Back")
            
            collectionViewAddress.semanticContentAttribute = .forceLeftToRight
        }
        
        lblTProfiele.text = "MY PROFILE".localizeString(string: Language.shared.currentAppLang)
        lblTMyAddrss.text = "My Addresses".localizeString(string: Language.shared.currentAppLang)
        
        btnTUpdate.setTitle("Update".localizeString(string: Language.shared.currentAppLang), for: .normal)
        btnTChangePass.setTitle("Change Password".localizeString(string: Language.shared.currentAppLang), for: .normal)
        btnTLogout.setTitle("Logout".localizeString(string: Language.shared.currentAppLang), for: .normal)
        btnDeleteAccount.setTitle("Delete Account".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        txtFName.text = "Full name*".localizeString(string: Language.shared.currentAppLang)
        txtEmail.text = "Email".localizeString(string: Language.shared.currentAppLang)
        
        collectionViewAddress.delegate = self
        collectionViewAddress.dataSource = self
        collectionViewAddress.collectionViewLayout = flowLayout
        
        callProfileDetailAPI(governorate_id: appDelegate?.dicCurrentLoginUser.id ?? 0)
        
        callGetAddressAPI()
        
        txtComment.delegate = self
        txtComment.placeholder = "Comment (optional)".localizeString(string: Language.shared.currentAppLang)
        
        if Language.shared.isArabic {
            txtComment.placeholderTextView.textAlignment = .right
            txtFName.textAlignment = .right
            txtEmail.textAlignment = .right
            txtComment.textAlignment = .right
        } else {
            txtComment.placeholderTextView.textAlignment = .left
            txtFName.textAlignment = .left
            txtEmail.textAlignment = .left
            txtComment.textAlignment = .left
        }
        
        // Do any additional setup after loading the view.
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        lblCartCount.text = appDelegate?.strTotalCount
        
        if appDelegate?.strTotalCount == "0"
        {
            self.viewCountItem.isHidden = true
        }
        else
        {
            self.viewCountItem.isHidden = true
        }
    }
    
    func updateAddress(isUpdate: Bool, id: Int) {
        if isUpdate == true{
            callGetAddressAPI()
        }
    }
    
    @IBAction func clickedYesDelete(_ sender: Any) {
        
        self.mainViewPopp.isHidden = true
        callDeleteAddressAPI(addressId: "\(self.strAddressID)")
        
    }
    
    
    @IBAction func clickedNoDelete(_ sender: Any) {
        mainViewPopp.isHidden = true
    }
    
    
    @IBAction func clickedSideMenu(_ sender: Any) {
        if Language.shared.isArabic {
            self.sideMenuController?.showRightView(animated: true, completion: nil)
        }
        else
        {
            self.sideMenuController?.showLeftView(animated: true, completion: nil)
        }
    }
    @IBAction func clickedBack(_ sender: Any) {
        appDelegate?.setUpHome()
    }
    @IBAction func clickedCart(_ sender: Any) {
    }
    
    @IBAction func clickedUpdate(_ sender: Any) {
        
        if txtFName.text == ""
        {
            self.setUpMakeToast(msg: "Please enter full name".localizeString(string: Language.shared.currentAppLang))
        }
        else if txtEmail.text == ""
        {
            self.setUpMakeToast(msg: "Please enter email".localizeString(string: Language.shared.currentAppLang))
        }
        else
        {
            callUpdateProfileAPI()
        }
    }
    
    @IBAction func clickedChangePass(_ sender: Any) {
        let mainS = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func clickedLogout(_ sender: Any) {
        
        
        if let isUserLogin = appDelegate?.getIsUserLogin()
        {
            if isUserLogin == true
            {
                let mainS =  UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
                vc.isLogout = true
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: false)
            }
            
        }
        
    }
    @IBAction func clickedDeleteAccount(_ sender: Any) {
        
        if let isUserLogin = appDelegate?.getIsUserLogin()
        {
            if isUserLogin == true
            {
                let mainS =  UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
                vc.isDeleteAccount = true
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: false)
            }
            
        }
        
        
    }
    
    // MARK: - calling API
    
    func callProfileDetailAPI(governorate_id: Int)
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["governorate_id":governorate_id]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(GET_PROFILE, parameters: param) { response, error, statusCode in
            
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
                        if let dic = response?.value(forKey: "result") as? NSDictionary
                        {
                            let dicData = TBLoginUserResult(fromDictionary: dic)
                            
                            self.txtFName.text = dicData.name ?? ""
                            self.txtEmail.text = dicData.email ?? ""
                            self.txtComment.text = dicData.comment ?? ""
                           
                            self.dicProfileDetail = dicData
                            appDelegate?.saveCuurentUserData(dic: dicData)
                            appDelegate?.dicCurrentLoginUser = dicData
                         }
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                        
                    }
                }
                else
                {
                    if message?.contains("Unauthenticated.") == true
                    {
                        appDelegate?.strTotalCount = "0"
                        
                        appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
                        appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
                        
                        appDelegate?.saveIsUserLogin(dic: false)
                    }
                    APIClient.sharedInstance.hideIndicator()
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    func callUpdateProfileAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["country_code":"965","mobile_number":"\(appDelegate?.dicCurrentLoginUser.mobileNumber ?? 0)","email":self.txtEmail.text ?? "","name":self.txtFName.text ?? "","device_type":"1","device_token":"1234567890dfdsfdfdffdgd","version":"1"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(GET_PROFILE, parameters: param) { response, error, statusCode in
            
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
                        if let dic = response?.value(forKey: "result") as? NSDictionary
                        {
                            self.setUpMakeToast(msg: message ?? "")
                            let dicData = TBLoginUserResult(fromDictionary: dic)
                            appDelegate?.saveCuurentUserData(dic: dicData)
                            appDelegate?.dicCurrentLoginUser = dicData
                            
                        }
                    }
                    else
                    {
                        self.setUpMakeToast(msg: message ?? "")
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
    
    func callDeleteAddressAPI(addressId: String)
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["address_id":addressId]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(DELETE_ADDRESS, parameters: param) { response, error, statusCode in
            
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
                        self.setUpMakeToast(msg: message ?? "")
                        
                        self.callGetAddressAPI()
                    }
                    else
                    {
                        self.setUpMakeToast(msg: message ?? "")
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
    
    func callGetAddressAPI()
    {
        // APIClient.sharedInstance.showIndicator()
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(GET_ADDRESS + "\(appDelegate?.dicCurrentLoginUser.id ?? 0)", parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                self.arrAddressList.removeAll()
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        self.arrAddressList.removeAll()
                        
                        if let arrResult = response?.value(forKey: "result") as? NSArray
                        {
                            for objDic in arrResult
                            {
                                let dicData = TBAddressResult(fromDictionary: (objDic as? NSDictionary)!)
                                self.arrAddressList.append(dicData)
                            }
                        }
                        self.isAPICall = true
                        
                        appDelegate?.saveUserAllAddress(dic: self.arrAddressList)
                        self.collectionViewAddress.reloadData()
                        
                        if self.arrAddressList.count > 0
                        {
                            if Language.shared.isArabic {
                                guard self.collectionViewAddress.numberOfItems(inSection: 0) > 0 else { return }
                                let indexPath = IndexPath(item: 0, section: 0)
                                self.collectionViewAddress.scrollToItem(at: indexPath, at: .right, animated: false)
                                
                                self.collectionViewAddress.delegate = self
                                self.collectionViewAddress.dataSource = self
                                self.collectionViewAddress.collectionViewLayout = self.flowLayout
                                
                                self.collectionViewAddress.semanticContentAttribute = .forceRightToLeft
                                
                                DispatchQueue.main.async {
                                    self.collectionViewAddress.reloadData()
                                }
                            }
                            else
                            {
                                guard self.collectionViewAddress.numberOfItems(inSection: 0) > 0 else { return }
                                let indexPath = IndexPath(item: 0, section: 0)
                                self.collectionViewAddress.scrollToItem(at: indexPath, at: .left, animated: false)
                                
                                self.collectionViewAddress.delegate = self
                                self.collectionViewAddress.dataSource = self
                                self.collectionViewAddress.collectionViewLayout = self.flowLayout
                                
                                self.collectionViewAddress.semanticContentAttribute = .forceLeftToRight
                                
                                
                                DispatchQueue.main.async {
                                    self.collectionViewAddress.reloadData()
                                }
                            }
                        }
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                        self.arrAddressList.removeAll()
                        appDelegate?.saveUserAllAddress(dic: self.arrAddressList)
                        self.collectionViewAddress.reloadData()
                    }
                }
                else
                {
                    APIClient.sharedInstance.hideIndicator()
                    self.arrAddressList.removeAll()
                    appDelegate?.saveUserAllAddress(dic: self.arrAddressList)
                    self.collectionViewAddress.reloadData()
                    
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
                self.arrAddressList.removeAll()
                appDelegate?.saveUserAllAddress(dic: self.arrAddressList)
                self.collectionViewAddress.reloadData()
            }
        }
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.isAPICall == true{
            return arrAddressList.count + 1
        }
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionViewAddress.dequeueReusableCell(withReuseIdentifier: "MyAddressProfileCell", for: indexPath) as! MyAddressProfileCell
        
        cell.btnEdit.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(clickedEditAdd(_:)), for: .touchUpInside)
        cell.btnEdit.setTitle("Edit".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        cell.btnDeleteAccount.tag = indexPath.row
        cell.btnDeleteAccount.addTarget(self, action: #selector(clickedDeleteAddress(_:)), for: .touchUpInside)
        
        
        let lastRow = collectionViewAddress.numberOfItems(inSection: 0) - 1
        let indexPathLast = IndexPath(row: lastRow, section: 0)
        let lastCell = indexPathLast
        
        if indexPath == lastCell
        {
            cell.viewAddNew.isHidden = false
            cell.viewList.isHidden = true
            cell.lblAddNew.text = "Add new address".localizeString(string: Language.shared.currentAppLang)
        }
        else
        {
            
            if indexPath.row == 0
            {
                cell.viewAddNew.isHidden = true
                cell.viewList.isHidden = false
                let dicData = arrAddressList[indexPath.row]
                
                let address = dicData.address ?? ""
                let block = dicData.block ?? ""
                let street = dicData.street ?? ""
                let avenue = dicData.avenue ?? ""
                let building_number = dicData.buildingNumber ?? ""
                let floor = dicData.floor ?? ""
                let apartment = dicData.apartment ?? ""
                
                cell.lblName.text = dicData.areaName ?? ""
                
                cell.lblHome.text = dicData.address ?? ""
                
//                cell.lblAddress.text = "Block \(block),st. \(street),Building \(building_number)"
                
                let Block_lan = "Block".localizeString(string: Language.shared.currentAppLang)
                let Street_lan = "Street".localizeString(string: Language.shared.currentAppLang)
                let Building_lan = "Building".localizeString(string: Language.shared.currentAppLang)
                
                cell.lblAddress.text = "\(Block_lan) \(block),\(Street_lan) \(street),\(Building_lan) \(building_number)"
            }
            else
            {
                if arrAddressList.count != indexPath.row
                {
                    cell.viewAddNew.isHidden = true
                    cell.viewList.isHidden = false
                    let dicData = arrAddressList[indexPath.row]
                    
                    let address = dicData.address ?? ""
                    let block = dicData.block ?? ""
                    let street = dicData.street ?? ""
                    let avenue = dicData.avenue ?? ""
                    let building_number = dicData.buildingNumber ?? ""
                    let floor = dicData.floor ?? ""
                    let apartment = dicData.apartment ?? ""
                    
                    cell.lblName.text = dicData.areaName ?? ""
                    
                    cell.lblHome.text = dicData.address ?? ""
                    
//                    cell.lblAddress.text = "Block \(block),st. \(street),Building \(building_number)"
                    
                    let Block_lan = "Block".localizeString(string: Language.shared.currentAppLang)
                    let Street_lan = "Street".localizeString(string: Language.shared.currentAppLang)
                    let Building_lan = "Building".localizeString(string: Language.shared.currentAppLang)
                    
                    cell.lblAddress.text = "\(Block_lan) \(block),\(Street_lan) \(street),\(Building_lan) \(building_number)"
                    
                }
                
            }
            
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let lastRow = collectionViewAddress.numberOfItems(inSection: 0) - 1
        let indexPathLast = IndexPath(row: lastRow, section: 0)
        let lastCell = indexPathLast
        
        if indexPath == lastCell
        {
            let mainS = UIStoryboard(name: "Home", bundle: nil)
            let vc = mainS.instantiateViewController(withIdentifier: "AddressVC") as! AddressVC
            vc.isAddProfileAddress = true
            vc.isUpdateProfile = false
            vc.delegateAddress = self
            let home = UINavigationController(rootViewController: vc)
            home.modalPresentationStyle = .overFullScreen
            self.present(home, animated: false)
        }
        
    }
    
    @objc func clickedDeleteAddress(_ sender: UIButton){
        
        self.mainViewPopp.isHidden = false
        
        let dicData = arrAddressList[sender.tag]
        
        self.strAddressID = dicData.id ?? 0
    }
    
    
    
    @objc func clickedEditAdd(_ sender: UIButton){
        
        let dicData = arrAddressList[sender.tag]
        
        let mainS = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "AddressVC") as! AddressVC
        vc.isAddProfileAddress = true
        vc.isUpdateProfile = true
        vc.dicAddressDetail = dicData
        vc.delegateAddress = self
        let home = UINavigationController(rootViewController: vc)
        home.modalPresentationStyle = .overFullScreen
        self.present(home, animated: false)
    }
    
}

class MyAddressProfileCell: UICollectionViewCell{
    
    @IBOutlet weak var btnDeleteAccount: UIButton!
    
    
    @IBOutlet weak var viewAddNew: UIView!
    @IBOutlet weak var viewList: UIView!
    
    @IBOutlet weak var lblHome: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var lblAddNew: UILabel!
}
