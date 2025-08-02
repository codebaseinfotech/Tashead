//
//  ToolsVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 02/06/23.
//

import UIKit
import LGSideMenuController
import MarqueeLabel
import ReadMoreTextView

class ToolsVC: UIViewController, CustomTableViewCellDelegate, ProdDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imgCartRightCont: NSLayoutConstraint! //20
    @IBOutlet weak var imgCart: UIImageView!
    @IBOutlet weak var imgWidthCont: NSLayoutConstraint! //22
    
    
    @IBOutlet weak var imgPro: UIImageView!
    
    @IBOutlet weak var viewCountItem: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblPName: UILabel!
    @IBOutlet weak var lblCartCount: UILabel!
    
    
    @IBOutlet weak var viewMainCar: UIView!
    @IBOutlet weak var viewCart: CartViewMain!
    @IBOutlet weak var heightCartView: NSLayoutConstraint!
    
    var arrInfluencersProductList: [TBInfluencerProductResult] = [TBInfluencerProductResult]()
    var objInfluencers = TBInfluencersListResult()
    
    var strCtgID = ""
    var strSubCtgID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.delegate = self
        tblView.dataSource = self
        
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
        
        
        lblPName.text = objInfluencers.name ?? ""
        
        var media_link_url = "\(objInfluencers.image ?? "")"
        // media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        imgPro.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
        
        callGetCartAPI()
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
        
        callInfluencersProductAPI(isShow: true)
        
        lblCartCount.text = appDelegate?.strTotalCount
        
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
        
        if Language.shared.isArabic {
            imgBack.image = UIImage(named: "Back_Ar")
        }
        else
        {
            imgBack.image = UIImage(named: "Back")
        }
        
        
        if let isUserLogin = appDelegate?.getIsUserLogin()
        {
            if isUserLogin == true
            {
                imgCartRightCont.constant = 0
                imgWidthCont.constant = 0
                imgCart.isHidden = true
                
            }
            else
            {
                imgCartRightCont.constant = 0
                imgWidthCont.constant = 0
                imgCart.isHidden = true
                self.viewCountItem.isHidden = true
                self.viewMainCar.isHidden = false
                self.heightCartView.constant = 95
            }
        }
        else
        {
            imgCartRightCont.constant = 0
            imgWidthCont.constant = 0
            imgCart.isHidden = true
            self.viewCountItem.isHidden = true
            self.viewMainCar.isHidden = true
            self.heightCartView.constant = 0
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
    @IBAction func clickedBack(_ sender: Any) {
        appDelegate?.setUpHome()
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
    
    
    
    
}

extension ToolsVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrInfluencersProductList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrInfluencersProductList[section].products.count
    }
    
    func reloadTableView(cuurentSection: Int, cuurentIndex: Int, suppliersInt: Int, pricesInt: Int) {
        
        let dicData = arrInfluencersProductList[cuurentSection].products[cuurentIndex]
        dicData.suppliersIndex = suppliersInt
        dicData.pricesIndex = pricesInt
        
        print("cuurentSection = \(cuurentSection), cuurentIndex = \(cuurentIndex), suppliersInt = \(suppliersInt), pricesInt = \(pricesInt), \(dicData.productNameEn ?? "")")
        
        
        arrInfluencersProductList[cuurentSection].products[cuurentIndex] = dicData
        
        
        print("cuurentSection = \(cuurentSection), cuurentIndex = \(cuurentIndex), suppliersInt = \(suppliersInt), pricesInt = \(pricesInt), \(dicData.productNameEn ?? "")")
        
        
        self.tblView.reloadRows(at: [IndexPath(row: cuurentIndex, section: cuurentSection)], with: .none)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "ToolsCell") as! ToolsCell
        
        let dicData = arrInfluencersProductList[indexPath.section].products[indexPath.row]
        
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
        
        if let isUserLogin = appDelegate?.getIsUserLogin()
        {
            if isUserLogin == true
            {
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
        
        if appDelegate?.getIsGuestLogin() == true
        {
            cell.topLableHesghtCon.constant = 20
            cell.imgFav.isHidden = true
            cell.btnFav.isHidden = true
        }
        else
        {
            cell.topLableHesghtCon.constant = 38
            cell.imgFav.isHidden = false
            cell.btnFav.isHidden = false
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
        cell.ObjCurrentCellSection = indexPath.section
        
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

                    if factoryQuantity == 0
                    {
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
        
        
        cell.btnAddCart.accessibilityValue = String(indexPath.section)
        cell.btnAddCart.tag = indexPath.row
        cell.btnAddCart.addTarget(self, action: #selector(clickedAddToCart(_:)), for: .touchUpInside)
        
        cell.btnAddQty.accessibilityValue = String(indexPath.section)
        cell.btnAddQty.tag = indexPath.row
        cell.btnAddQty.addTarget(self, action: #selector(clickedAddQty(_:)), for: .touchUpInside)
        
        cell.btnRemoveQty.accessibilityValue = String(indexPath.section)
        cell.btnRemoveQty.tag = indexPath.row
        cell.btnRemoveQty.addTarget(self, action: #selector(clickedRemoveQty(_:)), for: .touchUpInside)
        
        
        cell.btnDEs.accessibilityValue = String(indexPath.section)
        cell.btnDEs.tag = indexPath.row
        cell.btnDEs.addTarget(self, action: #selector(clickedProDe(_:)), for: .touchUpInside)
        
        
        cell.btnFav.accessibilityValue = String(indexPath.section)
        cell.btnFav.tag = indexPath.row
        cell.btnFav.addTarget(self, action: #selector(clickedProWishList(_:)), for: .touchUpInside)
        
        cell.txtQty.accessibilityValue = String(indexPath.section)
        cell.txtQty.tag = indexPath.row
        cell.txtQty.delegate = self
        cell.txtQty.addTarget(self, action: #selector(searchWorkersAsPerText(_:)), for: .editingChanged)
        
        return cell
    }
    
    
    @objc func searchWorkersAsPerText(_ textfield:UITextField) {
        
        let section = Int(textfield.accessibilityValue ?? "") ?? 0
        
        let indexPath = IndexPath(row: textfield.tag, section: section)
        
        let dicData = arrInfluencersProductList[section].products[indexPath.row]
        
        let cell = self.tblView.cellForRow(at: indexPath) as! ToolsCell
        
        var objQty = Int(dicData.suppliers[indexPath.row].prices[indexPath.row].quantity ?? 0)
        
        let minus_quantity = dicData.suppliers[textfield.tag].prices[textfield.tag].minusQuantity ?? 0
        
        let factoryQuantity = dicData.suppliers[textfield.tag].prices[textfield.tag].factoryQuantity ?? 0

        
        var objQty12 = Int(cell.txtQty.text ?? "") ?? 0
        
        let objMul = Double(dicData.suppliers[textfield.tag].prices[textfield.tag].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty12)
        
        let formattedNumber = String(format: "%.3f", objMul)
        cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
        
        if factoryQuantity == 1
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
                
                let objMul = Double(dicData.suppliers[textfield.tag].prices[textfield.tag].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty)
                
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("ToolsHeadrView", owner: self, options: [:])?.first as! ToolsHeadrView
        
        headerView.lblname.text = arrInfluencersProductList[section].name ?? ""
        
        if Language.shared.isArabic {
            
            headerView.viewMain.clipsToBounds = true
            headerView.viewMain.layer.cornerRadius = 17.5
            headerView.viewMain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            
        } else {
            
            headerView.viewMain.clipsToBounds = true
            headerView.viewMain.layer.cornerRadius = 17.5
            headerView.viewMain.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dicData = arrInfluencersProductList[indexPath.section].products[indexPath.row]
        
        let mainS = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        vc.strProductID = "\(dicData.id ?? 0)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Action
    @objc func clickedAddToCart(_ sender: UIButton)
    {
        
        if let isUserLogin = appDelegate?.getIsUserLogin()
        {
            if isUserLogin == true
            {
                let section = Int(sender.accessibilityValue ?? "") ?? 0
                
                let indexPath = IndexPath(row: sender.tag, section: section)
                
                let cell = self.tblView.cellForRow(at: indexPath) as! ToolsCell
                
                let objQty = Int(cell.txtQty.text ?? "") ?? 0
                
                if objQty == 0 || cell.txtQty.text == "" {
                    self.setUpMakeToast(msg: "Out of stock".localizeString(string: Language.shared.currentAppLang).localizeString(string: Language.shared.currentAppLang))
                } else {
                    cell.txtQty.text = "\(objQty)"
                    
                    let dicData = arrInfluencersProductList[section]
                    
                    if dicData.products[indexPath.row].suppliers.count > 1
                    {
                        dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].qty = objQty
                        arrInfluencersProductList[section] = dicData
                        
                        let productID =  "\(dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].productPriceId ?? 0)"
                        
                        let quantity = dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].quantity ?? 0
                        
                        let minus_quantity = dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].minusQuantity ?? 0
                        
                        let factoryQuantity = dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].factoryQuantity ?? 0

                        if factoryQuantity == 0{
                            if minus_quantity == 0 && quantity == 0 {
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
                        
                        if dicData.products[indexPath.row].suppliers.count > 0
                        {
                            
                            dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].qty = objQty
                            arrInfluencersProductList[section] = dicData
                            
                            let productID =  "\(dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].productPriceId ?? 0)"
                            
                            let quantity = dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].quantity ?? 0
                            
                            let minus_quantity = dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].minusQuantity ?? 0
                            
                            let factoryQuantity = dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].factoryQuantity ?? 0

                            if factoryQuantity == 0{
                                if minus_quantity == 0 && quantity == 0 {
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
        let section = Int(sender.accessibilityValue ?? "") ?? 0
        
        let indexPath = IndexPath(row: sender.tag, section: section)
        
        let dicData = arrInfluencersProductList[section]
        
        let cell = self.tblView.cellForRow(at: indexPath) as! ToolsCell
        
        var objQty = Int(cell.txtQty.text ?? "") ?? 0
        
        
        if dicData.products[indexPath.row].suppliers.count > 1
        {
            if dicData.products[indexPath.row].suppliers.count > 0 {
                
                let factoryQuantity = dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].factoryQuantity ?? 0

                if factoryQuantity == 1
                {
                    objQty = objQty + 1
                    
                    cell.txtQty.text = "\(objQty)"
                    
                    let objMul = Double(dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty)
                    
                    let formattedNumber = String(format: "%.3f", objMul)
                    cell.lblPrice.text = "\(formattedNumber) \(dicData.products[indexPath.row].currency ?? "")"
                    
                    dicData.products[sender.tag].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].qty = objQty
                    arrInfluencersProductList[section] = dicData
                }
                else
                {
                    if dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].quantity != objQty
                    {
                        
                        let quantity = dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].quantity ?? 0
                        
                        let minus_quantity = dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].minusQuantity ?? 0
                        
                        if minus_quantity == 0 && quantity == 0 {
                            
                        }
                        else
                        {
                            objQty = objQty + 1
                            
                            cell.txtQty.text = "\(objQty)"
                            
                            let objMul = Double(dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty)
                            
                            let formattedNumber = String(format: "%.3f", objMul)
                            cell.lblPrice.text = "\(formattedNumber) \(dicData.products[indexPath.row].currency ?? "")"
                            
                            dicData.products[sender.tag].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].qty = objQty
                            arrInfluencersProductList[section] = dicData
                        }
                        
                        
                    }
                }
                

            }
        }
        else
        {
            
            if dicData.products[indexPath.row].suppliers.count > 0
            {
                
                if dicData.products[indexPath.row].suppliers.count > 0 {
                    
                    
                    let factoryQuantity = dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].factoryQuantity ?? 0

                    if factoryQuantity == 1
                    {
                        objQty = objQty + 1
                        
                        cell.txtQty.text = "\(objQty)"
                        
                        let objMul = Double(dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty)
                        
                        let formattedNumber = String(format: "%.3f", objMul)
                        cell.lblPrice.text = "\(formattedNumber) \(dicData.products[indexPath.row].currency ?? "")"
                        
                        dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].qty = objQty
                        
                        arrInfluencersProductList[indexPath.section] = dicData
                    }
                    else
                    {
                        if dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].quantity != objQty
                        {
                            
                            let quantity = dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].quantity ?? 0
                            
                            let minus_quantity = dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].minusQuantity ?? 0
                            
                            if minus_quantity == 0 && quantity == 0 {
                                
                            }
                            else
                            {
                                objQty = objQty + 1
                                
                                cell.txtQty.text = "\(objQty)"
                                
                                let objMul = Double(dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty)
                                
                                let formattedNumber = String(format: "%.3f", objMul)
                                cell.lblPrice.text = "\(formattedNumber) \(dicData.products[indexPath.row].currency ?? "")"
                                
                                dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].qty = objQty
                                
                                arrInfluencersProductList[indexPath.section] = dicData
                            }
                            
                            
                        }
                    }
                    

                }
                
            }
            else
            {
                
            }
        }
        
    }
    
    @objc func clickedRemoveQty(_  sender: UIButton)
    {
        let section = Int(sender.accessibilityValue ?? "") ?? 0
        
        let indexPath = IndexPath(row: sender.tag, section: section)
        
        let cell = self.tblView.cellForRow(at: indexPath) as! ToolsCell
        
        var objQty = Int(cell.txtQty.text ?? "") ?? 0
        
        let dicData = arrInfluencersProductList[section]
        
        if dicData.products[indexPath.row].suppliers.count > 1
        {
            if dicData.products[indexPath.row].suppliers.count > 0 {
                if objQty != 1
                {
                    objQty = objQty - 1
                    
                    cell.txtQty.text = "\(objQty)"
                    
                    let objMul = Double(dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty)
                    
                    let formattedNumber = String(format: "%.3f", objMul)
                    cell.lblPrice.text = "\(formattedNumber) \(dicData.products[indexPath.row].currency ?? "")"
                }
                
                dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].qty = objQty
                arrInfluencersProductList[section] = dicData
            }
        }
        else
        {
            
            if dicData.products[indexPath.row].suppliers.count > 0
            {
                
                if dicData.products[indexPath.row].suppliers.count > 0 {
                    if objQty != 1
                    {
                        objQty = objQty - 1
                        
                        cell.txtQty.text = "\(objQty)"
                        
                        let objMul = Double(dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty)
                        
                        let formattedNumber = String(format: "%.3f", objMul)
                        cell.lblPrice.text = "\(formattedNumber) \(dicData.products[indexPath.row].currency ?? "")"
                    }
                    
                    dicData.products[indexPath.row].suppliers[dicData.products[indexPath.row].suppliersIndex].prices[dicData.products[indexPath.row].pricesIndex].qty = objQty
                    arrInfluencersProductList[section] = dicData
                }
                
            }
            else
            {
                
            }
        }
    }
    
    @objc func clickedProDe(_  sender: UIButton)
    {
        let section = Int(sender.accessibilityValue ?? "") ?? 0
        
        let indexPath = NSIndexPath(row: sender.tag, section: section)
        
        let dicData = arrInfluencersProductList[section].products[sender.tag]
        
        let mainS = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        vc.strProductID = "\(dicData.id ?? 0)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickedProWishList(_  sender: UIButton)
    {
        
        if let isUserLogin = appDelegate?.getIsUserLogin()
        {
            if isUserLogin == true
            {
                
                let section = Int(sender.accessibilityValue ?? "") ?? 0
                
                let indexPath = NSIndexPath(row: sender.tag, section: section)
                
                let dicData = arrInfluencersProductList[section].products[indexPath.row]
                
                if dicData.favouriteData != nil
                {
                    if dicData.favouriteData.isFavouriteProduct == 1
                    {
                        callRemovetoWishlistAPI(pro_Id: dicData.id ?? 0)
                    }
                    else
                    {
                        callAddtoWishlistAPI(pro_Id: dicData.id ?? 0)
                    }
                    
                }
                else
                {
                    callAddtoWishlistAPI(pro_Id: dicData.id ?? 0)
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
    
    // MARK: - calling API
    
    func callInfluencersProductAPI(isShow: Bool)
    {
        if isShow == true {
            APIClient.sharedInstance.showIndicator()
        }
        
        let param = ["influencer_id":"\(self.objInfluencers.id ?? 0)"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(INFLUENCERS_PRODUCT_LIST, parameters: param) { response, error, statusCode in
            
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
                        self.arrInfluencersProductList.removeAll()
                        
                        if let arrResult = response?.value(forKey: "result") as? NSArray
                        {
                            for obj in arrResult
                            {
                                let dicData = TBInfluencerProductResult(fromDictionary: obj as! NSDictionary)
                                
                                for (index,objQty) in dicData.products.enumerated()
                                {
                                    if dicData.products[index].suppliers.count > 0
                                    {
                                        for (index11,objQty11) in dicData.products[index].suppliers.enumerated()
                                        {
                                            for (index77,objQty7) in objQty11.prices.enumerated()
                                            {
                                                let quantity = dicData.products[index].suppliers[index11].prices[index77].quantity ?? 0
                                                
                                                let minus_quantity = dicData.products[index].suppliers[index11].prices[index77].minusQuantity ?? 0
                                                
                                                if minus_quantity == 0 && quantity == 0 {
                                                    dicData.products[index].suppliers[index11].prices[index77].qty = 0
                                                } else {
                                                    dicData.products[index].suppliers[index11].prices[index77].qty = 1
                                                }
                                            }
                                        }
                                    }
                                    
                                }
                                
                                self.arrInfluencersProductList.append(dicData)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.tblView.reloadData()
                        }
                        
                    }
                    else
                    {
                        self.arrInfluencersProductList.removeAll()
                        self.tblView.reloadData()
                        APIClient.sharedInstance.hideIndicator()
                        
                        self.setUpMakeToast(msg: message ?? "")
                    }
                }
                else
                {
                    self.arrInfluencersProductList.removeAll()
                    self.tblView.reloadData()
                    
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
    
    func callAddtoWishlistAPI(pro_Id: Int)
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["product_id":"\(pro_Id)"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(WISHLIST_ADD, parameters: param) { response, error, statusCode in
            
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
                        // self.setUpMakeToast(msg: message ?? "")
                        
                        self.callInfluencersProductAPI(isShow: false)
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
    
    func callRemovetoWishlistAPI(pro_Id: Int)
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["product_id":"\(pro_Id)"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderDelete(WISHLIST_REMOVE, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                //  APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        //self.setUpMakeToast(msg: message ?? "")
                        
                        self.callInfluencersProductAPI(isShow: false)
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


class ToolsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource
{
    
    @IBOutlet weak var topLableHesghtCon: NSLayoutConstraint!
    
    @IBOutlet weak var viewQtyHideShow: UIView!
    
    @IBOutlet weak var btnnMoree: UIButton!
    
    @IBOutlet weak var btnDEs: UIButton!
    
    @IBOutlet weak var txtReadDEs: ReadMoreTextView!
    
    @IBOutlet weak var proDe: UILabel!
    
    @IBOutlet weak var PriceMiddle: NSLayoutConstraint! //10
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: MarqueeLabel!
    @IBOutlet weak var lblUnitType: UILabel!
    @IBOutlet weak var lblSPrice: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var imgFav: UIImageView!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var btnAddQty: UIButton!
    @IBOutlet weak var btnRemoveQty: UIButton!
    @IBOutlet weak var btnAddCart: UIButton!
    @IBOutlet weak var collectionWeight: UICollectionView!
    
    @IBOutlet weak var lblstrike: UILabel!
    @IBOutlet weak var collectionSupplier: UICollectionView!
    
    @IBOutlet weak var collectionSuppierHeight: NSLayoutConstraint! //30
    @IBOutlet weak var lblSupplier_: UILabel!
    @IBOutlet weak var lblSupplierHeight: NSLayoutConstraint! //17
    
    @IBOutlet weak var lblSupplierTopcont: NSLayoutConstraint!//20
    
    @IBOutlet weak var lblTUnit: UILabel!
    @IBOutlet weak var lblTWeight: UILabel!
    
    
    @IBOutlet weak var txtQty: UITextField!
    
    let ConsectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let ConitemsPerRow: CGFloat = 3
    
    var ConflowLayout: UICollectionViewFlowLayout {
        let _ConflowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.ConsectionInsets.left * (self.ConitemsPerRow + 1)
            let availableWidth = self.collectionWeight.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.ConitemsPerRow
            
            _ConflowLayout.itemSize = CGSize(width: widthPerItem, height: 25)
            
            _ConflowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            _ConflowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
            _ConflowLayout.minimumInteritemSpacing = 10
            _ConflowLayout.minimumLineSpacing = 10
        }
        
        // edit properties here
        return _ConflowLayout
    }
    
    let ConsectionInsets1 = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let ConitemsPerRow1: CGFloat = 2.5
    
    var ConflowLayout1: UICollectionViewFlowLayout {
        let _ConflowLayout1 = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.ConsectionInsets1.left * (self.ConitemsPerRow1 + 1)
            let availableWidth = self.collectionSupplier.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.ConitemsPerRow1
            
            _ConflowLayout1.itemSize = CGSize(width: widthPerItem, height: 25)
            
            _ConflowLayout1.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            _ConflowLayout1.scrollDirection = UICollectionView.ScrollDirection.horizontal
            _ConflowLayout1.minimumInteritemSpacing = 10
            _ConflowLayout1.minimumLineSpacing = 10
        }
        
        // edit properties here
        return _ConflowLayout1
    }
    
    var arrWeight: [TBInfluencerProductPrice] = [TBInfluencerProductPrice]()
    var objProduct = TBInfluencerProductProduct()
    
    weak var delegate: CustomTableViewCellDelegate?
    
    var ObjCurrentCellIndex = 0
    var ObjCurrentCellSection = 0
    
    var selectedIndexW = 0
    var selectedIndexS = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionWeight.delegate = self
        collectionWeight.dataSource = self
        //   collectionWeight.collectionViewLayout = ConflowLayout
        
        collectionSupplier.delegate = self
        collectionSupplier.dataSource = self
        //  collectionSupplier.collectionViewLayout = ConflowLayout1
        
    }
    
    
    func someActionThatRequiresReload() {
        // Perform actions that require a reload
        
        // Call the delegate method to notify the view controller
        delegate?.reloadTableView(cuurentSection: ObjCurrentCellSection, cuurentIndex: ObjCurrentCellIndex, suppliersInt: objProduct.suppliersIndex, pricesInt: objProduct.pricesIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionWeight{
            return arrWeight.count
        }else{
            return objProduct.suppliers.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionWeight{
            let cell = self.collectionWeight.dequeueReusableCell(withReuseIdentifier: "ProductWeigthCell", for: indexPath) as! ProductWeigthCell
            
            let dicData = arrWeight[indexPath.row]
            
            if dicData.value == ""
            {
                cell.lblName.text = "null"
            }
            else
            {
                cell.lblName.text = "\(dicData.value ?? "null")"
            }
            
            cell.lblName.type = .continuous
            cell.lblName.speed = .duration(10.0)
            cell.lblName.trailingBuffer = 10
            
            if objProduct.pricesIndex == indexPath.row
            {
                cell.viewWieght.backgroundColor = UIColor(red: 187/255, green: 109/255, blue: 96/255, alpha: 1)
                cell.lblName.textColor = .white
            }
            else
            {
                cell.viewWieght.backgroundColor = .white
                cell.lblName.textColor = .black
            }
            
            return cell
        }else{
            let cell = self.collectionSupplier.dequeueReusableCell(withReuseIdentifier: "ProductWeigthCell", for: indexPath) as! ProductWeigthCell
            
            let dicData = objProduct.suppliers[indexPath.row]
            
            if dicData.supplier == ""
            {
                cell.lblName.text = "null"
            }
            else
            {
                cell.lblName.text = dicData.supplier ?? ""
            }
            
            cell.lblName.type = .continuous
            cell.lblName.speed = .duration(10.0)
            cell.lblName.trailingBuffer = 10
            
            
            if selectedIndexS == indexPath.row
            {
                cell.viewWieght.backgroundColor = UIColor(red: 187/255, green: 109/255, blue: 96/255, alpha: 1)
                cell.lblName.textColor = .white
            }
            else
            {
                cell.viewWieght.backgroundColor = .white
                cell.lblName.textColor = .black
            }
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionWeight
        {
            selectedIndexW = indexPath.row
            
            objProduct.pricesIndex = indexPath.row
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.collectionWeight.reloadData()
                self.someActionThatRequiresReload()
            }
            
        }
        else{
            
            objProduct.suppliersIndex = indexPath.row
            objProduct.pricesIndex = 0
            
            selectedIndexS = indexPath.row
            selectedIndexW = 0
            
            collectionSupplier.reloadData()
            collectionWeight.reloadData()
            
            self.someActionThatRequiresReload()
        }
    }
    
}

class ToolsWeightCollCell: UICollectionViewCell
{
    
    @IBOutlet weak var lblName: UILabel!
}
