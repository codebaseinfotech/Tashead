//
//  SearchProductVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 22/07/24.
//

import UIKit
import Speech
import AVFoundation

class SearchProductVC: UIViewController, CustomTableViewCellDelegate, ProdDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var imgCart: UIImageView!
    
    @IBOutlet weak var viewTopCtgCont: NSLayoutConstraint! // 10
    @IBOutlet weak var viewCate: UIView!
    @IBOutlet weak var viewBottomCtgCont: NSLayoutConstraint! // 10
    @IBOutlet weak var collectionViwCate: UICollectionView!
    
    @IBOutlet weak var collectionViewHighst: NSLayoutConstraint! // 65
    
    @IBOutlet weak var proTopCont: NSLayoutConstraint! //10
    
    
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var btnCancel: SFButton!
    @IBOutlet weak var imgCancel: UIImageView!
    
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var viewCountItem: UIView!
    @IBOutlet weak var lblNoDataFound: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblSubCateName: UILabel!
    @IBOutlet weak var lblCartCount: UILabel!
    
    @IBOutlet weak var lblTCategories: UILabel!
    @IBOutlet weak var lblTProduct: UILabel!
    
    
    @IBOutlet weak var viewProduct: UIView!
    
    @IBOutlet weak var viewMainCar: UIView!
    @IBOutlet weak var viewCart: CartViewMain!
    @IBOutlet weak var heightCartView: NSLayoutConstraint!
    
    
    var arrProducts: [TBProductResult] = [TBProductResult]()
    
    var arrCategorie: [TBProductDetailsCategory] = [TBProductDetailsCategory]()
    
    var strCtgID = ""
    var strSubCtgID = 0
    
    var selectIndex = 0
    
    var isStepWise = false
    
    var isTabChange = false
    
    var strTitle = ""
    
    var currentPageCrops = 1
    var isLoadingCrops = false
    var hasMoreDataCrops = true
    
    var activityIndicatorCrops = UIActivityIndicatorView(style: .medium)
    
    let ConsectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let ConitemsPerRow: CGFloat = 3
    
    var ConflowLayout: UICollectionViewFlowLayout {
        let _ConflowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.ConsectionInsets.left * (self.ConitemsPerRow + 1)
            let availableWidth = self.collectionViwCate.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.ConitemsPerRow
            
            _ConflowLayout.itemSize = CGSize(width: widthPerItem, height: 60)
            
            _ConflowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            _ConflowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
            _ConflowLayout.minimumInteritemSpacing = 0
            _ConflowLayout.minimumLineSpacing = 10
        }
        
        // edit properties here
        return _ConflowLayout
    }
    
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
        
        self.txtSearch.becomeFirstResponder()
        
        if Language.shared.isArabic {
            
            txtSearch.textAlignment = .right
            imgBack.image = UIImage(named: "Back_Ar")
            
            viewCate.clipsToBounds = true
            viewCate.layer.cornerRadius = viewCate.frame.height/2
            viewCate.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            
            viewProduct.clipsToBounds = true
            viewProduct.layer.cornerRadius = viewProduct.frame.height/2
            viewProduct.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        } else {
            
            txtSearch.textAlignment = .left
            
            imgBack.image = UIImage(named: "Back")
            
            viewCate.clipsToBounds = true
            viewCate.layer.cornerRadius = viewCate.frame.height/2
            viewCate.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            
            viewProduct.clipsToBounds = true
            viewProduct.layer.cornerRadius = viewProduct.frame.height/2
            viewProduct.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
        
        self.imgCancel.image = UIImage(named: "mic_Search")
        
        lblSubCateName.text = "SEARCH".localizeString(string: Language.shared.currentAppLang)
        
        txtSearch.placeholder = "Search".localizeString(string: Language.shared.currentAppLang)
        
        lblTProduct.text = "PRODUCT".localizeString(string: Language.shared.currentAppLang)
        
        lblTCategories.text = "CATEGORIES".localizeString(string: Language.shared.currentAppLang)
        
        tblView.delegate = self
        tblView.dataSource = self
        
        callProductAPI(isShow: true, productSearch: self.txtSearch.text ?? "", firstTimeAPI: true)
        
        self.txtSearch.delegate = self
        self.txtSearch.addTarget(self, action: #selector(searchWorkersAsPerTextSearch(_ :)), for: .editingChanged)
        
        setupActivityIndicatorCrops()
        
        collectionViwCate.delegate = self
        collectionViwCate.dataSource = self
        collectionViwCate.collectionViewLayout = ConflowLayout
        
        setUpVoice()
        // Do any additional setup after loading the view.
    }
    
    @objc func searchWorkersAsPerTextSearch(_ textfield:UITextField) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            if textfield.text == ""
            {
                self.currentPageCrops = 1
                self.hasMoreDataCrops = true
                self.arrProducts.removeAll()
                self.tblView.reloadData()
                
                self.isLoadingCrops = true
                self.imgCancel.image = UIImage(named: "mic_Search")
 
                self.callProductAPI(isShow: false, productSearch: "", firstTimeAPI: true)
            }
            else
            {
                self.currentPageCrops = 1
                
                self.isLoadingCrops = true
                self.arrProducts.removeAll()
                self.tblView.reloadData()
                
                self.imgCancel.image = UIImage(named: "cancel")

                DispatchQueue.main.async {
                    self.callProductAPI(isShow: false, productSearch: textfield.text ?? "", firstTimeAPI: true)
                }
            }
        }
        
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
        
        if let isUserLogin = appDelegate?.getIsUserLogin()
        {
            if isUserLogin == true
            {
                imgCart.isHidden = true
                
            }
            else
            {
                imgCart.isHidden = true
            }
        }
        else
        {
            imgCart.isHidden = true
        }
        
        
    }
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedCance(_ sender: Any) {
        
        if self.imgCancel.image == UIImage(named: "cancel")
        {
            self.txtSearch.text = ""
            
            self.currentPageCrops = 1
            self.hasMoreDataCrops = true
            
            self.arrProducts.removeAll()
            tblView.reloadData()
            
            self.isLoadingCrops = true
            self.imgCancel.image = UIImage(named: "mic_Search")
            
            self.callProductAPI(isShow: false, productSearch: "", firstTimeAPI: true)
        }
        else
        {
            
        }
        
    }
    
    func setUpVoice()
    {
 
        //button.authorizationErrorHandling = .openSettings(completion: nil)
        btnCancel.resultHandler = {
            self.txtSearch.text = "\($1?.bestTranscription.formattedString ?? "")"
            //self.button.play()
        }
        btnCancel.errorHandler = {
            guard let error = $0 else {
                //self.txtWriteMessage.text = "Unknown error."
                self.txtSearch.text = ""
                return
            }
            switch error {
            case .authorization(let reason):
                switch reason {
                case .denied:
                   // self.txtWriteMessage.text = "Authorization denied."
                    self.txtSearch.text = ""
                case .restricted:
                  //  self.txtWriteMessage.text = "Authorization restricted."
                    self.txtSearch.text = ""
                case .usageDescription(let key):
                   // self.txtWriteMessage.text = "Info.plist \"\(key)\" key is missing."
                    self.txtSearch.text = ""
                }
            case .cancelled(let reason):
                switch reason {
                case .notFound:
                   // self.txtWriteMessage.text = "Cancelled, not found."
                    self.txtSearch.text = ""
                case .user:
                   // self.txtWriteMessage.text = "Cancelled by user."
                    self.txtSearch.text = ""
                }
            case .invalid(let locale):
                //self.txtWriteMessage.text = "Locale \"\(locale)\" not supported."
                self.txtSearch.text = ""
            case .unknown(let unknownError):
              //  self.txtWriteMessage.text = unknownError?.localizedDescription
                self.txtSearch.text = ""
            default:
               // self.txtWriteMessage.text = error.localizedDescription
                self.txtSearch.text = ""
            }
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


extension SearchProductVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
        
        let dicData = arrProducts[indexPath.row]
        
        if appDelegate?.getIsGuestLogin() == true
        {
            cell.topHiesghtContName.constant = 20
            cell.imgFav.isHidden = true
            cell.btnFav.isHidden = true
        }
        else
        {
            cell.topHiesghtContName.constant = 38
            cell.imgFav.isHidden = false
            cell.btnFav.isHidden = false
        }
        
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
                if dicData.favourite == 1
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
                    
                    let factory_product = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].factoryProduct ?? 0

                    if factory_product == 0 {
                        
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
                    
                    let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: ""))! * (Double(cell.txtQty.text ?? "") ?? 0.0).rounded(toPlaces: 3)
                    
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
                    
                    let factory_product = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].factoryProduct ?? 0
                    
                    if factory_product == 0 {
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
    
    /*
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
     if isTabChange == true
     {
     if self.selectIndex == indexPath.row{
     cell.selectedIndexS = 0
     cell.selectedIndexW = 0
     }
     
     isTabChange = false
     }
     //
     
     
     cell.delegate = self
     
     cell.collectionWeight.reloadData()
     
     cell.collectionSupplier.reloadData()
     
     if dicData.suppliers.count > 1
     {
     cell.arrWeight = dicData.suppliers[dicData.suppliersIndex].prices
     
     cell.collectionSupplier.isHidden = false
     cell.collectionSuppierHeight.constant = 30
     cell.lblSupplier_.isHidden = false
     cell.lblSupplierHeight.constant = 17
     cell.lblSupplierTopcont.constant = 20
     
     //cell.collectionSupplier.reloadData()
     }
     else
     {
     
     if dicData.suppliers.count > 0
     {
     
     if dicData.isSupplierDetailShow == 0
     {
     cell.arrWeight = dicData.suppliers[dicData.suppliersIndex].prices
     
     cell.collectionSupplier.isHidden = true
     cell.collectionSuppierHeight.constant = 0
     cell.lblSupplier_.isHidden = true
     cell.lblSupplierHeight.constant = 0
     cell.lblSupplierTopcont.constant = 0
     }
     else
     {
     cell.arrWeight = dicData.suppliers[dicData.suppliersIndex].prices
     
     cell.collectionSupplier.isHidden = false
     cell.collectionSuppierHeight.constant = 30
     cell.lblSupplier_.isHidden = false
     cell.lblSupplierHeight.constant = 17
     cell.lblSupplierTopcont.constant = 20
     
     //  cell.collectionSupplier.reloadData()
     }
     
     }
     else
     {
     
     cell.collectionSupplier.isHidden = true
     cell.collectionSuppierHeight.constant = 0
     cell.lblSupplier_.isHidden = true
     cell.lblSupplierHeight.constant = 0
     cell.lblSupplierTopcont.constant = 0
     
     // cell.collectionSupplier.reloadData()
     }
     
     
     }
     
     
     if cell.productID == dicData.id
     {
     if dicData.suppliers.count > 0
     {
     cell.lblPrice.text = "\(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice ?? "") \(dicData.currency ?? "")"
     cell.lblSPrice.attributedText = "\(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].originalPrice ?? "") \(dicData.currency ?? "")".strikeThrough()
     
     cell.txtQty.text = "\(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty ?? 0)"
     
     if dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice == dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].originalPrice
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
     else
     {
     if dicData.suppliers.count > 0
     {
     if dicData.suppliers[dicData.suppliersIndex].prices.count > 0
     {
     cell.lblPrice.text = "\(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice ?? "") \(dicData.currency ?? "")"
     cell.lblSPrice.attributedText = "\(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].originalPrice ?? "") \(dicData.currency ?? "")".strikeThrough()
     
     cell.txtQty.text = "\(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty ?? 0)"
     
     if dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice == dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].originalPrice
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
     }
     else
     {
     cell.lblSPrice.isHidden = true
     cell.lblstrike.isHidden = true
     cell.PriceMiddle.constant = 0
     }
     
     }
     
     
     return cell
     }
     */
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        print("lastElement = \(arrProducts.count - 1)")
        print("indexPath.row = \(indexPath.row)")
        
        let lastElement = arrProducts.count - 1
        if indexPath.row == lastElement && hasMoreDataCrops {
            callProductAPI(isShow: false, productSearch: self.txtSearch.text ?? "", firstTimeAPI: false)
        }
    }
    
    
    @objc func searchWorkersAsPerText(_ textfield:UITextField) {
        
        let dicData = arrProducts[textfield.tag]
        
        let indexPath = NSIndexPath(row: textfield.tag, section: 0)
        
        let cell = self.tblView.cellForRow(at: indexPath as IndexPath) as! ProductCell
        
        let objQty = Int(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].quantity ?? 0)
        
        let minus_quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].minusQuantity ?? 0
        
        let factoryProduct = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].factoryProduct ?? 0

        
        let objQty12 = Int(cell.txtQty.text ?? "") ?? 0
        
        let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty12)
        
        let formattedNumber = String(format: "%.3f", objMul)
        cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
        
        if factoryProduct == 1 {
            cell.btnAddCart.isUserInteractionEnabled = true
            
        }
        else {
            if Double(objQty) < (Double(textfield.text ?? "") ?? 0.0) {
                
                cell.btnAddCart.isUserInteractionEnabled = false
                
                self.setUpMakeToast(msg: "You can add only \(objQty) product(s).")
                
                if objQty == 0 && minus_quantity == 0 {
                    cell.txtQty.text = "0"
                } else {
                    cell.txtQty.text = String(objQty)
                }
                
                let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty).rounded(toPlaces: 3)
                
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
                
                if objQty == 0 || cell.txtQty.text == "" {
                    self.setUpMakeToast(msg: "Out of stock".localizeString(string: Language.shared.currentAppLang).localizeString(string: Language.shared.currentAppLang))
                } else {
                    let dicData = arrProducts[sender.tag]
                    
                    if dicData.suppliers.count > 1
                    {
                        dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty = objQty
                        arrProducts[sender.tag] = dicData
                        
                        let productID =  "\(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].productPriceId ?? 0)"
                        
                        let quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].quantity ?? 0
                        
                        let minus_quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].minusQuantity ?? 0
                        
                        let factory_product = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].factoryProduct ?? 0
                        
                        if factory_product == 0 {
                            
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
                        
                        if dicData.suppliers.count > 0
                        {
                            
                            dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty = objQty
                            arrProducts[sender.tag] = dicData
                            
                            let productID =  "\(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].productPriceId ?? 0)"
                            
                            let quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].quantity ?? 0
                            
                            let minus_quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].minusQuantity ?? 0
                            
                            let factory_product = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].factoryProduct ?? 0
                            
                            if factory_product == 0
                            {
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
        let dicData = arrProducts[sender.tag]
        
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        
        let cell = self.tblView.cellForRow(at: indexPath as IndexPath) as! ProductCell
        
        var objQty = Int(cell.txtQty.text ?? "") ?? 0
        
        
        if dicData.suppliers.count > 1
        {
            if dicData.suppliers.count > 0 {
                
                let factoryProduct = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].factoryProduct ?? 0
                
                if factoryProduct == 1
                {
                    objQty = objQty + 1
                    
                    cell.txtQty.text = "\(objQty)"
                    
                    let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") )! * Double(objQty).rounded(toPlaces: 3)
                    
                    let formattedNumber = String(format: "%.3f", objMul)
                    cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
                    
                    dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty = objQty
                    arrProducts[sender.tag] = dicData
                }
                else {
                    
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
                            
                            let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") )! * Double(objQty).rounded(toPlaces: 3)
                            
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
                    
                    let factoryProduct = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].factoryProduct ?? 0

                    if factoryProduct == 1 {
                        objQty = objQty + 1
                        
                        cell.txtQty.text = "\(objQty)"
                        
                        let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty).rounded(toPlaces: 3)
                        
                        let formattedNumber = String(format: "%.3f", objMul)
                        cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
                        
                        dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty = objQty
                        arrProducts[sender.tag] = dicData
                    }
                    else {
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
                                
                                let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty).rounded(toPlaces: 3)
                                
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
        if let isUserLogin = appDelegate?.getIsUserLogin()
        {
            if isUserLogin == true
            {
                let dicData = arrProducts[sender.tag]
                
                if dicData.favourite == 1
                {
                    callRemovetoWishlistAPI(pro_Id: dicData.id ?? 0, index: sender.tag)
                }
                else
                {
                    callAddtoWishlistAPI(pro_Id: dicData.id ?? 0, index: sender.tag)
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
                    
                    let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty).rounded(toPlaces: 3)
                    
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
                        
                        let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty).rounded(toPlaces: 3)
                        
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
    
    func callAddtoWishlistAPI(pro_Id: Int, index: Int)
    {
        //  APIClient.sharedInstance.showIndicator()
        
        let param = ["product_id":"\(pro_Id)"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(WISHLIST_ADD, parameters: param) { response, error, statusCode in
            
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
                        
                        let dicData = self.arrProducts[index]
                        dicData.favourite = 1
                        
                        self.arrProducts[index] = dicData
                        
                        let indexPath = IndexPath(row: index, section: 0)
                        self.tblView.reloadRows(at: [indexPath], with: .none)
                        
                    }
                    else
                    {
                        self.setUpMakeToast(msg: message ?? "")
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
                        appDelegate?.saveCmsAdverd(dic: TBCmsAdverdResult())
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
    
    
    func callRemovetoWishlistAPI(pro_Id: Int, index: Int)
    {
        //   APIClient.sharedInstance.showIndicator()
        
        let param = ["product_id":"\(pro_Id)"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderDelete(WISHLIST_REMOVE, parameters: param) { response, error, statusCode in
            
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
                        let dicData = self.arrProducts[index]
                        dicData.favourite = 0
                        
                        self.arrProducts[index] = dicData
                        
                        let indexPath = IndexPath(row: index, section: 0)
                        self.tblView.reloadRows(at: [indexPath], with: .none)
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
                        appDelegate?.saveCmsAdverd(dic: TBCmsAdverdResult())
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
    
    func callProductAPI(isShow: Bool, productSearch: String, firstTimeAPI: Bool)
    {
        
        if isShow == true {
            APIClient.sharedInstance.showIndicator()
        }
        else
        {
            showActivityIndicatorCrops()
        }
        
        let param = ["product_name": productSearch]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(GET_PRODUCTS_SEARCH + "\(self.currentPageCrops)", parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if firstTimeAPI == true {
                    self.arrProducts.removeAll()
                }
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        
                        if let dicResult = response?.value(forKey: "result") as? NSDictionary
                        {
                            if let arrResult = dicResult.value(forKey: "data") as? NSArray
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
                                
                                let last_page = dicResult.value(forKey: "last_page") as? Int
                                
                                if self.currentPageCrops == last_page
                                {
                                    self.isLoadingCrops = false
                                    self.hasMoreDataCrops = false
                                }
                                else
                                {
                                    self.currentPageCrops += 1
                                    self.hasMoreDataCrops = true
                                }
                                
                                self.hideActivityIndicatorCrops()
                                self.tblView.reloadData()
                            }
                            
                            self.arrCategorie.removeAll()
                            if let arr_categoire = dicResult.value(forKey: "categories") as? NSArray {
                                
                                for obj in arr_categoire {
                                    let dicData = TBProductDetailsCategory(fromDictionary: obj as! NSDictionary)
                                    self.arrCategorie.append(dicData)
                                }
                                self.collectionViwCate.reloadData()
                            }
                            
                            if self.arrCategorie.count > 0
                            {
                                self.proTopCont.constant = 10
                                self.collectionViewHighst.constant = 65
                                self.viewTopCtgCont.constant = 10
                                self.viewCate.isHidden = false
                                self.viewBottomCtgCont.constant = 10
                                self.collectionViwCate.isHidden = false
                            }
                            else
                            {
                                self.proTopCont.constant = 0
                                self.collectionViewHighst.constant = 0
                                self.viewTopCtgCont.constant = 0
                                self.viewCate.isHidden = true
                                self.viewBottomCtgCont.constant = 0
                                self.collectionViwCate.isHidden = true
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
                    
                    if self.arrCategorie.count > 0
                    {
                        self.proTopCont.constant = 10
                        self.collectionViewHighst.constant = 65
                        self.viewTopCtgCont.constant = 10
                        self.viewCate.isHidden = false
                        self.viewBottomCtgCont.constant = 10
                        self.collectionViwCate.isHidden = false
                    }
                    else
                    {
                        self.proTopCont.constant = 0
                        self.collectionViewHighst.constant = 0
                        self.viewTopCtgCont.constant = 0
                        self.viewCate.isHidden = true
                        self.viewBottomCtgCont.constant = 0
                        self.collectionViwCate.isHidden = true
                    }
                    
                    self.tblView.reloadData()
                }
                else
                {
                    self.proTopCont.constant = 0
                    self.collectionViewHighst.constant = 0
                    self.viewTopCtgCont.constant = 0
                    self.viewCate.isHidden = true
                    self.viewBottomCtgCont.constant = 0
                    self.collectionViwCate.isHidden = true
                    
                    self.tblView.reloadData()
                    self.lblNoDataFound.isHidden = false
                    APIClient.sharedInstance.hideIndicator()
                    
                    if message?.contains("Unauthenticated.") == true
                    {
                        appDelegate?.strTotalCount = "0"
                        
                        appDelegate?.saveCuurentUserData(dic: TBLoginUserResult())
                        appDelegate?.dicCurrentLoginUser = TBLoginUserResult()
                        appDelegate?.saveCmsAdverd(dic: TBCmsAdverdResult())
                        appDelegate?.saveIsUserLogin(dic: false)
                    }
                }
            }
            else
            {
                self.proTopCont.constant = 0
                self.collectionViewHighst.constant = 0
                self.viewTopCtgCont.constant = 0
                self.viewCate.isHidden = true
                self.viewBottomCtgCont.constant = 0
                self.collectionViwCate.isHidden = true
                
                self.lblNoDataFound.isHidden = false
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    func showActivityIndicatorCrops() {
        activityIndicatorCrops.startAnimating()
    }
    
    func hideActivityIndicatorCrops() {
        activityIndicatorCrops.stopAnimating()
    }
    
    func setupActivityIndicatorCrops() {
        // Setup footer view with activity indicator
        let footerView = UIView(frame: CGRect(x: 0, y: -15, width: tblView.frame.width, height: 50))
        activityIndicatorCrops.center = footerView.center
        activityIndicatorCrops.color = .gray
        footerView.addSubview(activityIndicatorCrops)
        tblView.tableFooterView = footerView
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
                        appDelegate?.saveCmsAdverd(dic: TBCmsAdverdResult())
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
                        appDelegate?.saveCmsAdverd(dic: TBCmsAdverdResult())
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


extension SearchProductVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.arrCategorie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionViwCate.dequeueReusableCell(withReuseIdentifier: "TopCell", for: indexPath) as! TopCell
        
        let dicData =  self.arrCategorie[indexPath.row]
        
        cell.lblName.text = dicData.name ?? ""
        
        var media_link_url = dicData.categoryImage ?? ""
        media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        cell.imgPic.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dicData = arrCategorie[indexPath.row]
        
        let mains = UIStoryboard(name: "Home", bundle: nil)
        let vc = mains.instantiateViewController(withIdentifier: "ProductListVC") as! ProductListVC
        vc.strCtgID = "\(dicData.id ?? 0)"
        
        if dicData.isStepCategory == 1 {
            vc.isStepWise = true
        }
        else
        {
            vc.isStepWise = false
        }
        
        vc.strTitle = dicData.name ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
