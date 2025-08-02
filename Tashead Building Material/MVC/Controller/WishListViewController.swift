//
//  WishListViewController.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 08/05/24.
//

import UIKit

class WishListViewController: UIViewController, CustomTableViewCellDelegate, ProdDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var viewCountItem: UIView!
    @IBOutlet weak var lblNoDataFound: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblSubCateName: UILabel!
    @IBOutlet weak var lblCartCount: UILabel!
    
    @IBOutlet weak var viewMainCar: UIView!
    @IBOutlet weak var viewCart: CartViewMain!
    @IBOutlet weak var heightCartView: NSLayoutConstraint!
    
    var arrProducts: [TBProductResult] = [TBProductResult]()
    
    var strCtgID = ""
    var strSubCtgID = 0
    
    var selectIndex = 0
    
    var isStepWise = false
    
    var isTabChange = false
    
    var strTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewCart.tapedCart = {
            if appDelegate?.delivery_slot_allowed == 1 {
                let vc = SelectDeliveryTimeVC()
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "MyCartVC") as! MyCartVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        lblSubCateName.text = "MY FAVORITE".localizeString(string: Language.shared.currentAppLang)
        
        tblView.delegate = self
        tblView.dataSource = self
        
        callProductAPI(isShow: true)
        
        // Do any additional setup after loading the view.
    }
    
    func onProdReady(type: String) {
        
        lblCartCount.text = appDelegate?.strTotalCount ?? ""
        
        if appDelegate?.strTotalCount == "0"
        {
            self.viewCountItem.isHidden = true
            self.viewMainCar.isHidden = true
            self.heightCartView.constant = 0
        }
        else
        {
            self.viewCountItem.isHidden = true
            self.viewMainCar.isHidden = false
            self.heightCartView.constant = 95
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblCartCount.text = appDelegate?.strTotalCount ?? ""
        
        if appDelegate?.strTotalCount == "0"
        {
            self.viewCountItem.isHidden = true
            self.viewMainCar.isHidden = true
            self.heightCartView.constant = 0
        }
        else
        {
            self.viewCountItem.isHidden = true
            self.viewMainCar.isHidden = false
            self.heightCartView.constant = 95
        }
       
        
        if appDelegate?.dicCurrentLoginUser.id != nil
        {
            callGetCartAPI()
        }
        
        
    }
    
    @IBAction func clickedMenu(_ sender: Any) {
        if Language.shared.isArabic {
            self.sideMenuController?.showRightView(animated: true, completion: nil)
        }
        else
        {
            self.sideMenuController?.showLeftView(animated: true, completion: nil)
        }
    }
   
    
    @IBAction func clickedSearch(_ sender: Any) {
        let mains = UIStoryboard(name: "Home", bundle: nil)
        let vc = mains.instantiateViewController(withIdentifier: "SearchProductVC") as! SearchProductVC
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    func reloadTableView(cuurentSection: Int, cuurentIndex: Int, suppliersInt: Int, pricesInt: Int) {
        
        let dicData = arrProducts[cuurentIndex]
        dicData.suppliersIndex = suppliersInt
        dicData.pricesIndex = pricesInt
        
        arrProducts[cuurentIndex] = dicData
        
        tblView.reloadRows(at: [IndexPath(row: cuurentIndex, section: 0)], with: .none)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.tblView.reloadRows(at: [IndexPath(row: cuurentIndex, section: 0)], with: .none)
        }
        
    }
    
}


extension WishListViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
        
        let dicData = arrProducts[indexPath.row]
        
        if Language.shared.isArabic {
            cell.lblProductName.textAlignment = .right
            
            cell.proDe.textAlignment = .right
            
            cell.proDe.text = dicData.productDescriptionAr ?? ""
            cell.proDe.isHidden = true
            
            cell.txtReadDEs.textAlignment = .left
            cell.txtReadDEs.text = dicData.productDescriptionAr ?? ""
            
            cell.txtReadDEs.isHidden = true
            cell.proDe.isHidden = false
            
            cell.btnnMoree.isHidden = false
            
        } else {
            
            cell.btnnMoree.isHidden = true
            
            cell.lblProductName.textAlignment = .left
            
            cell.proDe.textAlignment = .left
            
            cell.proDe.text = dicData.productDescriptionEn ?? ""
            cell.proDe.isHidden = true
            
            cell.txtReadDEs.textAlignment = .left
            cell.txtReadDEs.text = dicData.productDescriptionEn ?? ""
            
            let customFont = UIFont(name: "HelveticaNeue", size: 13)
            
            let readMoreTextAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor: UIColor(red: 187/255, green: 109/255, blue: 96/255, alpha: 1),
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.font: customFont
            ]
            
            cell.txtReadDEs.attributedReadMoreText = NSAttributedString(string: " More", attributes: readMoreTextAttributes)
            cell.txtReadDEs.maximumNumberOfLines = 1
            cell.txtReadDEs.shouldTrim = true
        }
        
        cell.delegate = self
        
        if dicData.favouriteData != nil
        {
            if dicData.favouriteData.isFavouriteProduct == 1
            {
                cell.imgFav.image = UIImage(named: "ic_Fav")
            }
            else
            {
                cell.imgFav.image = UIImage(named: "ic_UnFav")
            }
            
        }
        else
        {
            cell.imgFav.image = UIImage(named: "ic_UnFav")
        }
        
        cell.btnAddCart.setTitle("Add to cart".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        cell.lblSupplier_.text = "Supplier:".localizeString(string: Language.shared.currentAppLang)
        cell.lblTUnit.text = "Weight:".localizeString(string: Language.shared.currentAppLang)
        cell.lblTWeight.text = "\(dicData.unitType ?? ""):"
        
        cell.lblProductName.text = dicData.name ?? ""
        
        cell.lblProductName.type = .continuous
        cell.lblProductName.speed = .duration(10.0)
        cell.lblProductName.trailingBuffer = 10
        
        cell.lblUnitType.text = dicData.unitType ?? ""
        
        let arrImg = dicData.productImages
        
        if (arrImg?.count ?? 0) > 0
        {
            let strImg = arrImg?[0].image ?? ""
            
            var media_link_url = strImg
            media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            cell.imgProduct.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
        }
        
        
        cell.objProduct = dicData
        cell.ObjCurrentCellIndex = indexPath.row
        
        if dicData.isSupplierDetailShow == 1
        {
            cell.collectionSupplier.isHidden = false
            cell.collectionSuppierHeight.constant = 30
            cell.lblSupplier_.isHidden = false
            cell.lblSupplierHeight.constant = 17
            cell.lblSupplierTopcont.constant = 20
            
            if dicData.suppliers.count > 0
            {
                cell.arrWeight = dicData.suppliers[0].prices
                
                if dicData.suppliers[dicData.suppliersIndex].prices.count > 0
                {
                    
                    cell.txtQty.text = "\(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty ?? 0)"
                    
                    let quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].quantity ?? 0
                    
                    let minus_quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].minusQuantity ?? 0
                    
                    let factoryQuantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].factoryQuantity ?? 0

                    if factoryQuantity == 0 {
                        if minus_quantity == 0 && quantity == 0
                        {
                            cell.btnAddCart.setTitle("Out of stock".localizeString(string: Language.shared.currentAppLang), for: .normal)
                            cell.btnAddCart.backgroundColor = .systemGray2
                            cell.viewQtyHideShow.isHidden = true
                        }
                        else
                        {
                            cell.btnAddCart.setTitle("Add to cart".localizeString(string: Language.shared.currentAppLang), for: .normal)
                            cell.btnAddCart.backgroundColor = UIColor(red: 70/255, green: 68/255, blue: 85/255, alpha: 1)
                            cell.viewQtyHideShow.isHidden = false
                        }
                    }
                    else {
                        cell.btnAddCart.setTitle("Add to cart".localizeString(string: Language.shared.currentAppLang), for: .normal)
                        cell.btnAddCart.backgroundColor = UIColor(red: 70/255, green: 68/255, blue: 85/255, alpha: 1)
                        cell.viewQtyHideShow.isHidden = false
                    }
                    
                   
                    
                    if cell.txtQty.text == "0" {
                        cell.txtQty.text = "1"
                    }
                    
                    let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") )! * (Double(cell.txtQty.text ?? "") ?? 0.0)
                    
                    let formattedNumber = String(format: "%.3f", objMul)
                    cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
                    
                    cell.lblSPrice.attributedText = "\(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].originalPrice.replacingOccurrences(of: ",", with: "") ) \(dicData.currency ?? "")".strikeThrough()
                    
                    if dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") == dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].originalPrice.replacingOccurrences(of: ",", with: "")
                    {
                        cell.lblSPrice.isHidden = true
                        cell.lblstrike.isHidden = true
                        cell.PriceMiddle.constant = 0
                    }
                    else
                    {
                        cell.lblSPrice.isHidden = false
                        cell.lblstrike.isHidden = false
                        cell.PriceMiddle.constant = 10
                    }
                }
                else
                {
                    cell.lblSPrice.isHidden = true
                    cell.lblstrike.isHidden = true
                    cell.PriceMiddle.constant = 0
                }
                
            }
            
        }
        else
        {
            
            cell.collectionSupplier.isHidden = true
            cell.collectionSuppierHeight.constant = 0
            cell.lblSupplier_.isHidden = true
            cell.lblSupplierHeight.constant = 0
            cell.lblSupplierTopcont.constant = 0
            
            if dicData.suppliers.count > 0
            {
                cell.arrWeight = dicData.suppliers[0].prices
                
                if dicData.suppliers[dicData.suppliersIndex].prices.count > 0
                {
                    cell.txtQty.text = "\(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty ?? 0)"
                    
                    let quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].quantity ?? 0
                    
                    let minus_quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].minusQuantity ?? 0
                    
                    let factoryQuantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].factoryQuantity ?? 0

                    if factoryQuantity == 0 {
                        if minus_quantity == 0 && quantity == 0
                        {
                            cell.btnAddCart.setTitle("Out of stock".localizeString(string: Language.shared.currentAppLang), for: .normal)
                            cell.btnAddCart.backgroundColor = .systemGray2
                            cell.viewQtyHideShow.isHidden = true
                        }
                        else
                        {
                            cell.btnAddCart.setTitle("Add to cart".localizeString(string: Language.shared.currentAppLang), for: .normal)
                            cell.btnAddCart.backgroundColor = UIColor(red: 70/255, green: 68/255, blue: 85/255, alpha: 1)
                            cell.viewQtyHideShow.isHidden = false
                        }
                    }
                    else {
                        cell.btnAddCart.setTitle("Add to cart".localizeString(string: Language.shared.currentAppLang), for: .normal)
                        cell.btnAddCart.backgroundColor = UIColor(red: 70/255, green: 68/255, blue: 85/255, alpha: 1)
                        cell.viewQtyHideShow.isHidden = false
                    }
                    
                    
                    
                    if cell.txtQty.text == "0" {
                        cell.txtQty.text = "1"
                    }
                    
                    let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") )! * (Double(cell.txtQty.text ?? "") ?? 0.0)
                    
                    let formattedNumber = String(format: "%.3f", objMul)
                    cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
                    
                    cell.lblSPrice.attributedText = "\(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].originalPrice.replacingOccurrences(of: ",", with: "") ) \(dicData.currency ?? "")".strikeThrough()
                    
                    if dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") == dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].originalPrice.replacingOccurrences(of: ",", with: "")
                    {
                        cell.lblSPrice.isHidden = true
                        cell.lblstrike.isHidden = true
                        cell.PriceMiddle.constant = 0
                    }
                    else
                    {
                        cell.lblSPrice.isHidden = false
                        cell.lblstrike.isHidden = false
                        cell.PriceMiddle.constant = 10
                    }
                }
                else
                {
                    cell.lblSPrice.isHidden = true
                    cell.lblstrike.isHidden = true
                    cell.PriceMiddle.constant = 0
                }
                
            }
        }
        
        cell.collectionWeight.reloadData()
        cell.collectionSupplier.reloadData()
        
        
        cell.btnAddCart.tag = indexPath.row
        cell.btnAddCart.addTarget(self, action: #selector(clickedAddToCart(_:)), for: .touchUpInside)
        
        cell.btnAddQty.tag = indexPath.row
        cell.btnAddQty.addTarget(self, action: #selector(clickedAddQty(_:)), for: .touchUpInside)
        
        cell.btnRemoveQty.tag = indexPath.row
        cell.btnRemoveQty.addTarget(self, action: #selector(clickedRemoveQty(_:)), for: .touchUpInside)
        
        cell.btnDEs.tag = indexPath.row
        cell.btnDEs.addTarget(self, action: #selector(clickedProDe(_:)), for: .touchUpInside)
        
        cell.btnFav.tag = indexPath.row
        cell.btnFav.addTarget(self, action: #selector(clickedProWishList(_:)), for: .touchUpInside)
        
        cell.txtQty.tag = indexPath.row
        cell.txtQty.delegate = self
        cell.txtQty.addTarget(self, action: #selector(searchWorkersAsPerText(_:)), for: .editingChanged)
        
        return cell
    }
    
    @objc func searchWorkersAsPerText(_ textfield:UITextField) {
        
        let dicData = arrProducts[textfield.tag]
        
        let indexPath = NSIndexPath(row: textfield.tag, section: 0)
        
        let cell = self.tblView.cellForRow(at: indexPath as IndexPath) as! ProductCell
        
        let objQty = Int(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].quantity ?? 0)
        
        let minus_quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].minusQuantity ?? 0
        
        let factoryProduct = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].factoryProduct ?? 0

        
        var objQty12 = Int(cell.txtQty.text ?? "") ?? 0
        
        let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty12)
        
        let formattedNumber = String(format: "%.3f", objMul)
        cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
        
        if factoryProduct == 1
        {
            cell.btnAddCart.isUserInteractionEnabled = true
        }
        else
        {
            if Double(objQty) < (Double(textfield.text ?? "") ?? 0.0) {
                
                cell.btnAddCart.isUserInteractionEnabled = false
                
                self.setUpMakeToast(msg: "You can add only \(objQty) product(s).")
                
                if objQty == 0 && minus_quantity == 0 {
                    cell.txtQty.text = "0"
                } else {
                    cell.txtQty.text = String(objQty)
                }
                
                let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty)
                
                let formattedNumber = String(format: "%.3f", objMul)
                cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
            } else {
                cell.btnAddCart.isUserInteractionEnabled = true
            }
        }
        
        
        
        
        // Handle when text field editing ends
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dicData = arrProducts[indexPath.row]
        
        let mainS = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        vc.strProductID = "\(dicData.id ?? 0)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickedAddToCart(_ sender: UIButton)
    {
        
        if let isUserLogin = appDelegate?.getIsUserLogin()
        {
            if isUserLogin == true
            {
                
                let indexPath = NSIndexPath(row: sender.tag, section: 0)
                
                let cell = self.tblView.cellForRow(at: indexPath as IndexPath) as! ProductCell
                
                let objQty = Int(cell.txtQty.text ?? "") ?? 0
                
                cell.txtQty.text = "\(objQty)"
                
                if objQty == 0 || cell.txtQty.text == ""
                {
                    self.setUpMakeToast(msg: "Out of stock".localizeString(string: Language.shared.currentAppLang).localizeString(string: Language.shared.currentAppLang))
                } else
                {
                    let dicData = arrProducts[sender.tag]
                    
                    if dicData.suppliers.count > 1
                    {
                        dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty = objQty
                        arrProducts[sender.tag] = dicData
                        
                        let productID =  "\(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].productPriceId ?? 0)"
                        
                        let quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].quantity ?? 0
                        
                        let minus_quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].minusQuantity ?? 0
                        
                        let factoryQuantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].factoryQuantity ?? 0

                        if factoryQuantity == 0
                        {
                            if minus_quantity == 0 && quantity == 0
                            {
                                self.setUpMakeToast(msg: "Out of stock".localizeString(string: Language.shared.currentAppLang).localizeString(string: Language.shared.currentAppLang))
                            } else
                            {
                                /*if appDelegate?.strTotalCount == "0"
                                {
                                    let mains = UIStoryboard(name: "Home", bundle: nil)
                                    let vc = mains.instantiateViewController(withIdentifier: "AddressVC") as! AddressVC
                                    vc.delegatePro = self
                                    vc.isAddProfileAddress = false
                                    vc.isUpdateProfile = false
                                    vc.isModify = true
                                    vc.strQty = objQty
                                    vc.strpro_Id = Int(productID) ?? 0
                                    let homeNavigation = UINavigationController(rootViewController: vc)
                                    homeNavigation.navigationBar.isHidden = true
                                    homeNavigation.modalPresentationStyle = .overFullScreen
                                    self.present(homeNavigation, animated: false)
                                }
                                else
                                {
                                    callAddtoCartAPI(qty: objQty, pro_Id: Int(productID) ?? 0)
                                }*/
                                callAddtoCartAPI(qty: objQty, pro_Id: Int(productID) ?? 0)
                                
                            }
                        }
                        else {
                            /*if appDelegate?.strTotalCount == "0"
                            {
                                let mains = UIStoryboard(name: "Home", bundle: nil)
                                let vc = mains.instantiateViewController(withIdentifier: "AddressVC") as! AddressVC
                                vc.delegatePro = self
                                vc.isAddProfileAddress = false
                                vc.isUpdateProfile = false
                                vc.isModify = true
                                vc.strQty = objQty
                                vc.strpro_Id = Int(productID) ?? 0
                                let homeNavigation = UINavigationController(rootViewController: vc)
                                homeNavigation.navigationBar.isHidden = true
                                homeNavigation.modalPresentationStyle = .overFullScreen
                                self.present(homeNavigation, animated: false)
                            }
                            else
                            {
                                callAddtoCartAPI(qty: objQty, pro_Id: Int(productID) ?? 0)
                            }*/
                            callAddtoCartAPI(qty: objQty, pro_Id: Int(productID) ?? 0)
                        }
                        
                    }
                    else
                    {
                        
                        if dicData.suppliers.count > 0
                        {
                            
                            //                        if dicData.is_supplier_detail_show == 0
                            //                        {
                            //                            self.setUpMakeToast(msg: "Please select supplier")
                            //                        }
                            //                        else
                            //                        {
                            dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty = objQty
                            arrProducts[sender.tag] = dicData
                            
                            let productID =  "\(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].productPriceId ?? 0)"
                            
                            let quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].quantity ?? 0
                            
                            let minus_quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].minusQuantity ?? 0
                            
                            let factoryQuantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].factoryQuantity ?? 0

                            if factoryQuantity == 0{
                                if minus_quantity == 0 && quantity == 0
                                {
                                    self.setUpMakeToast(msg: "Out of stock".localizeString(string: Language.shared.currentAppLang).localizeString(string: Language.shared.currentAppLang))
                                } else {
                                    
                                    /*if appDelegate?.strTotalCount == "0"
                                    {
                                        let mains = UIStoryboard(name: "Home", bundle: nil)
                                        let vc = mains.instantiateViewController(withIdentifier: "AddressVC") as! AddressVC
                                        vc.delegatePro = self
                                        vc.isAddProfileAddress = false
                                        vc.isUpdateProfile = false
                                        vc.isModify = true
                                        vc.strQty = objQty
                                        vc.strpro_Id = Int(productID) ?? 0
                                        let homeNavigation = UINavigationController(rootViewController: vc)
                                        homeNavigation.navigationBar.isHidden = true
                                        homeNavigation.modalPresentationStyle = .overFullScreen
                                        self.present(homeNavigation, animated: false)
                                    }
                                    else
                                    {
                                        callAddtoCartAPI(qty: objQty, pro_Id: Int(productID) ?? 0)
                                    }*/
                                    callAddtoCartAPI(qty: objQty, pro_Id: Int(productID) ?? 0)
                                }
                            }
                            else {
                                /*if appDelegate?.strTotalCount == "0"
                                {
                                    let mains = UIStoryboard(name: "Home", bundle: nil)
                                    let vc = mains.instantiateViewController(withIdentifier: "AddressVC") as! AddressVC
                                    vc.delegatePro = self
                                    vc.isAddProfileAddress = false
                                    vc.isUpdateProfile = false
                                    vc.isModify = true
                                    vc.strQty = objQty
                                    vc.strpro_Id = Int(productID) ?? 0
                                    let homeNavigation = UINavigationController(rootViewController: vc)
                                    homeNavigation.navigationBar.isHidden = true
                                    homeNavigation.modalPresentationStyle = .overFullScreen
                                    self.present(homeNavigation, animated: false)
                                }
                                else
                                {
                                    callAddtoCartAPI(qty: objQty, pro_Id: Int(productID) ?? 0)
                                }*/
                                callAddtoCartAPI(qty: objQty, pro_Id: Int(productID) ?? 0)
                            }
                            
                            
                        }
                        else
                        {
                            self.setUpMakeToast(msg: "Please select supplier".localizeString(string: Language.shared.currentAppLang))
                        }
                    }
                }
                
                
            }
            else
            {
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: LoginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                vc.isFromHome = true
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
        else
        {
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: LoginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            vc.isFromHome = true
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
    }
    
    @objc func clickedAddQty(_  sender: UIButton)
    {
        let dicData = arrProducts[sender.tag]
        
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        
        let cell = self.tblView.cellForRow(at: indexPath as IndexPath) as! ProductCell
        
        var objQty = Int(cell.txtQty.text ?? "") ?? 0
        
        
        if dicData.suppliers.count > 1
        {
            if dicData.suppliers.count > 0 {
                
                let factoryQuantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].factoryQuantity ?? 0

                if factoryQuantity == 1
                {
                    objQty = objQty + 1
                    
                    cell.txtQty.text = "\(objQty)"
                    
                    let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty)
                    
                    let formattedNumber = String(format: "%.3f", objMul)
                    cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
                    
                    dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty = objQty
                    arrProducts[sender.tag] = dicData
                }
                else
                {
                    if dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].quantity != objQty
                    {
                        
                        let quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].quantity ?? 0
                        
                        let minus_quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].minusQuantity ?? 0
                        
                        if minus_quantity == 0 && quantity == 0
                        {
                            
                        }
                        else
                        {
                            objQty = objQty + 1
                            
                            cell.txtQty.text = "\(objQty)"
                            
                            let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty)
                            
                            let formattedNumber = String(format: "%.3f", objMul)
                            cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
                            
                            dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty = objQty
                            arrProducts[sender.tag] = dicData
                        }
                        
                        
                    }
                }
                
                
            }
        }
        else
        {
            
            if dicData.suppliers.count > 0
            {
                
                //                if dicData.is_supplier_detail_show == 0
                //                {
                //
                //                }
                //                else
                //                {
                if dicData.suppliers.count > 0 {
                    
                    let factoryQuantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].factoryQuantity ?? 0

                    if factoryQuantity == 1
                    {
                        objQty = objQty + 1
                        
                        cell.txtQty.text = "\(objQty)"
                        
                        let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty)
                        
                        let formattedNumber = String(format: "%.3f", objMul)
                        cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
                        
                        dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty = objQty
                        arrProducts[sender.tag] = dicData
                    }
                    else
                    {
                        if dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].quantity != objQty
                        {
                            
                            let quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].quantity ?? 0
                            
                            let minus_quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].minusQuantity ?? 0
                            
                            if minus_quantity == 0 && quantity == 0
                            {
                                
                            }
                            else
                            {
                                objQty = objQty + 1
                                
                                cell.txtQty.text = "\(objQty)"
                                
                                let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty)
                                
                                let formattedNumber = String(format: "%.3f", objMul)
                                cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
                                
                                dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty = objQty
                                arrProducts[sender.tag] = dicData
                            }
                            
                            
                        }
                    }
                    
                    
                }
                //                }
                
            }
            else
            {
                
            }
            
            
        }
        
    }
    
    @objc func clickedProWishList(_  sender: UIButton)
    {
        
        let dicData = arrProducts[sender.tag]
 
        callRemovetoWishlistAPI(pro_Id: dicData.id ?? 0, index: sender.tag)
        
    }
    
    @objc func clickedProDe(_  sender: UIButton)
    {
        let dicData = arrProducts[sender.tag]
        
        let mainS = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        vc.strProductID = "\(dicData.id ?? 0)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickedRemoveQty(_  sender: UIButton)
    {
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        
        let cell = self.tblView.cellForRow(at: indexPath as IndexPath) as! ProductCell
        
        var objQty = Int(cell.txtQty.text ?? "") ?? 0
        
        let dicData = arrProducts[sender.tag]
        
        if dicData.suppliers.count > 1
        {
            if dicData.suppliers.count > 0 {
                if objQty != 1
                {
                    objQty = objQty - 1
                    
                    cell.txtQty.text = "\(objQty)"
                    
                    let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty)
                    
                    let formattedNumber = String(format: "%.3f", objMul)
                    cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
                }
                
                dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty = objQty
                arrProducts[sender.tag] = dicData
            }
        }
        else
        {
            
            if dicData.suppliers.count > 0
            {
                if dicData.suppliers.count > 0 {
                    if objQty != 1
                    {
                        objQty = objQty - 1
                        
                        cell.txtQty.text = "\(objQty)"
                        
                        let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty)
                        
                        let formattedNumber = String(format: "%.3f", objMul)
                        cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
                    }
                    
                    dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty = objQty
                    arrProducts[sender.tag] = dicData
                }
                
            }
            else
            {
                
            }
            
            
        }
        
        
        
        
    }
    
    func callProductAPI(isShow: Bool)
    {
        if isShow == true {
            APIClient.sharedInstance.showIndicator()
        }
 
        let param = ["user_id": "\(appDelegate?.dicCurrentLoginUser.id ?? 0)"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(WISHLIST_LIST, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                self.arrProducts.removeAll()
                
                if statusCode == 200
                {
                    self.arrProducts.removeAll()
                    
                    if status == 1
                    {
                        
                        if let arrResult = response?.value(forKey: "result") as? NSArray
                        {
                            for obj in arrResult
                            {
                                let dicData = TBProductResult(fromDictionary: obj as! NSDictionary)
                                
                                if dicData.suppliers.count > 0 {
                                    for (index11,objQty11)  in dicData.suppliers.enumerated()
                                    {
                                        for (index,objQty)  in objQty11.prices.enumerated()
                                        {
                                            dicData.suppliers[index11].prices[index].qty = 1
                                        }
                                    }
                                }
                                
                                self.arrProducts.append(dicData)
                            }
                        }
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                    }
                    
                    if self.arrProducts.count == 0
                    {
                        self.lblNoDataFound.isHidden = false
                    }
                    else
                    {
                        self.lblNoDataFound.isHidden = true
                    }
                    
                    self.tblView.reloadData()
                }
                else
                {
                    self.tblView.reloadData()
                    self.lblNoDataFound.isHidden = false
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
                self.lblNoDataFound.isHidden = false
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
                
                var arrCart: [TBCartListCartItem] = [TBCartListCartItem]()
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        if let dicResult = response?.value(forKey: "result") as? NSDictionary
                        {
                            self.viewCart.cartData = TBCartListResult(fromDictionary: dicResult)
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
                        self.lblCartCount.text = "\(arrCart.count)"
                        
                        if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCountItem.isHidden = true
                            self.viewMainCar.isHidden = true
                            self.heightCartView.constant = 0
                        }
                        else
                        {
                            self.viewCountItem.isHidden = true
                            self.viewMainCar.isHidden = false
                            self.heightCartView.constant = 95
                        }
                        
                    }
                    else
                    {
                        self.lblCartCount.text = "0"
                        appDelegate?.strTotalCount = "0"
                        
                        if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCountItem.isHidden = true
                            self.viewMainCar.isHidden = true
                            self.heightCartView.constant = 0
                        }
                        else
                        {
                            self.viewCountItem.isHidden = true
                            self.viewMainCar.isHidden = false
                            self.heightCartView.constant = 95
                        }
                        
                        APIClient.sharedInstance.hideIndicator()
                    }
                    
                }
                else
                {
                    self.lblCartCount.text = "0"
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
                self.lblCartCount.text = "0"
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    func callRemovetoWishlistAPI(pro_Id: Int, index: Int)
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["product_id":"\(pro_Id)"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderDelete(WISHLIST_REMOVE, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        self.callProductAPI(isShow: false)
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
    
    func callAddtoCartAPI(qty: Int,pro_Id: Int)
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["product_price_id":"\(pro_Id)","quantity":"\(qty)","device_id":"12323213","ip":"202.200.20.23"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(CREATE_CART, parameters: param) { response, error, statusCode in
            
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
                        
                        self.callGetCartAPI()
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
   
    
}
