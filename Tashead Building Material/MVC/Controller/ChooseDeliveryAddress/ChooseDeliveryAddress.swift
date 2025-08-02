//
//  ChooseDeliveryAddress.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 25/07/25.
//

import UIKit

protocol didOnChooseDelivery: AnyObject {
    func didTapOnNoDelivery(areaName: String)
}

class ChooseDeliveryAddress: UIViewController {

    @IBOutlet weak var lblTitleChooseAddress: UILabel! {
        didSet {
            lblTitleChooseAddress.text = "Choose delivery address".localizeString(string: Language.shared.currentAppLang)
        }
    }
    @IBOutlet weak var lblTitleSaveAddress: UILabel! {
        didSet {
            lblTitleSaveAddress.text = "Saved Addresses".localizeString(string: Language.shared.currentAppLang)
        }
    }
    @IBOutlet weak var tblViewList: UITableView! {
        didSet{
            tblViewList.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
            tblViewList.register(UINib(nibName: "ChooseDeliveryAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "ChooseDeliveryAddressTableViewCell")
            tblViewList.delegate = self
            tblViewList.dataSource = self
        }
    }
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var heightTblViewList: NSLayoutConstraint!
    @IBOutlet weak var viewMain: UIView! {
        didSet {
            viewMain.clipsToBounds = true
            viewMain.layer.cornerRadius = 15
            viewMain.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        }
    }
    @IBOutlet weak var lblDeliveryToDiffrent: UILabel! {
        didSet {
            lblDeliveryToDiffrent.text = "Deliver to a different location".localizeString(string: Language.shared.currentAppLang)
        }
    }
    @IBOutlet weak var lblChooseLocal: UILabel! {
        didSet {
            lblChooseLocal.text = "Choose location on map".localizeString(string: Language.shared.currentAppLang)
        }
    }
    
    var arrAddressList : [TBAddressResult] = [TBAddressResult]()
    var selectedAddress = -1

    var delegateChooseDelivery: didOnChooseDelivery?
    var delegateAddress: onUpdateAddress?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callGetAddressAPI()
        print("savedAddress: - \(String(describing: appDelegate?.getUserSelectedAddress().address))")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callGetAddressAPI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Open
          
        self.viewMain.slideIn(from: kFTAnimationBottom, in: self.viewMain.superview, duration: 0.6, delegate: self, start: Selector("temp"), stop: Selector("temp"))
    }

    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                let newsize  = newvalue as! CGSize
                heightTblViewList.constant = newsize.height
            }
        }
    }
    

    @IBAction func clickedClose(_ sender: Any) {
        // Close
         self.viewMain.slideOut(to: kFTAnimationBottom, in: self.viewMain.superview, duration: 0.4, delegate: self, start: Selector("temp"), stop: Selector("temp"))
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.dismiss(animated: false)
        }
        
    }
    
    @IBAction func clickedDeliveryDiffrentLocation(_ sender: Any) {
        let vc = AddNewAddress1VC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func clickedDeliveryCurrentLocation(_ sender: Any) {
    }
   
    // MARK: - calling API
    func callGetAddressAPI()
    {
//        APIClient.sharedInstance.showIndicator()
        
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
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        self.arrAddressList.removeAll()
                        
                        if let arrResult = response?.value(forKey: "result") as? NSArray
                        {
                            for (index,objDic) in arrResult.enumerated()
                            {
                                let dicData = TBAddressResult(fromDictionary: (objDic as? NSDictionary)!)
                                
                                if appDelegate?.is_default == dicData.id
                                {
                                    self.selectedAddress = index
                                }
                                
                                self.arrAddressList.append(dicData)
                            }
                        }
                        
                        appDelegate?.saveUserAllAddress(dic: self.arrAddressList)
                        self.tblViewList.reloadData()
                    }
                    else
                    {
                        self.arrAddressList.removeAll()
                        self.tblViewList.reloadData()
                        appDelegate?.saveUserAllAddress(dic: self.arrAddressList)
                        
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
                    
                    self.arrAddressList.removeAll()
                    self.tblViewList.reloadData()
                    appDelegate?.saveUserAllAddress(dic: self.arrAddressList)
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
                
                self.arrAddressList.removeAll()
                self.tblViewList.reloadData()
                appDelegate?.saveUserAllAddress(dic: self.arrAddressList)
            }
        }
    }
}

extension ChooseDeliveryAddress: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAddressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseDeliveryAddressTableViewCell") as! ChooseDeliveryAddressTableViewCell
        
        let dicData = arrAddressList[indexPath.row]
        
        let address = dicData.address ?? ""
        let block = dicData.block ?? ""
        let street = dicData.street ?? ""
        let avenue = dicData.avenue ?? ""
        let building_number = dicData.buildingNumber ?? ""
        let floor = dicData.floor ?? ""
        let apartment = dicData.apartment ?? ""
        
        cell.lblType.text = dicData.address ?? ""
        
        let Block_lan = "Block".localizeString(string: Language.shared.currentAppLang)
        let Street_lan = "Street".localizeString(string: Language.shared.currentAppLang)
        let Building_lan = "Building".localizeString(string: Language.shared.currentAppLang)
        
        cell.lblAddress.text = "\(Block_lan) \(block),\(Street_lan) \(street),\(Building_lan) \(building_number)"
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            cell.imgSelect.isHidden = appDelegate?.getUserSelectedAddress().id == dicData.id ? false : true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dicData = arrAddressList[indexPath.row]
        
        if dicData.isDeliveryAvailable == 1
        {
            selectedAddress = indexPath.row
            self.tblViewList.reloadData()

            appDelegate?.saveUserSelectedAddress(dic: dicData)
            
            appDelegate?.is_default = dicData.id ?? 0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.delegateAddress?.updateAddress(isUpdate: false, id: dicData.id ?? 0)
                self.clickedClose(self)
            }
        }
        else
        {
            let areaName = "\"\(dicData.areaName ?? "")\""

//            delegateChooseDelivery?.didTapOnNoDelivery(areaName: areaName)
//            self.clickedClose(self)
            let mainS =  UIStoryboard(name: "Home", bundle: nil)
            let vc = mainS.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
            vc.modalPresentationStyle = .overFullScreen
            vc.isAreYou = true
            vc.strTitle = "\("Unfortunately, currently delivery services not available for".localizeString(string: Language.shared.currentAppLang)) \(areaName)"
            self.present(vc, animated: false)
        }
 
    }
    
}
