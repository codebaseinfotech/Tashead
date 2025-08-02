//
//  ProductDetailVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 02/06/23.
//

import UIKit
import LGSideMenuController
import SDWebImage
import MarqueeLabel
import ImageSlideshow

struct Model {
    let image: UIImage
    
    var inputSource: InputSource {
        return ImageSource(image: image)
    }
}

class ProductDetailVC: UIViewController, CustomTableViewCellDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var imgCartRightCont: NSLayoutConstraint! //20
    @IBOutlet weak var imgCart: UIImageView!
    @IBOutlet weak var imgWidthCont: NSLayoutConstraint! //22
    
    
    
    @IBOutlet weak var viewCountItem: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblPName: MarqueeLabel!
    @IBOutlet weak var lblCartCount: UILabel!
    
    @IBOutlet weak var viewMainCar: UIView!
    @IBOutlet weak var viewCart: CartViewMain!
    @IBOutlet weak var heightCartView: NSLayoutConstraint!
    
    var strProductID = ""
    
    var dicProductDetails = TBProductDetailsData()
    
    var arrRelatedProduct = NSMutableArray()
    
    var isAPICall = false
    
    var models = [Model(image: UIImage(named: "Back_Ar") ?? UIImage())]
    
    var slideshowTransitioningDelegate: ZoomAnimatedTransitioningDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.delegate = self
        tblView.dataSource = self
        
        callProductDetailsAPI(isShow: true)
        callGetCartAPI()
        
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
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
                self.viewMainCar.isHidden = true
                self.heightCartView.constant = 0
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
        NotificationCenter.default.post(name: NSNotification.Name("OpenProductDetail"), object: "")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedProductPicZom(_ sender: Any) {
        
        let fullScreenController = FullScreenSlideshowViewController()
        fullScreenController.inputs = models.map { $0.inputSource }
        fullScreenController.initialPage = 0
        
        let imgg = UIImageView()
        
        var media_link_url = dicProductDetails.productImages[0].image ?? ""
        media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        imgg.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
        
        let indexPath_ = IndexPath(row: 0, section: 0)
        
        slideshowTransitioningDelegate = ZoomAnimatedTransitioningDelegate(imageView: imgg, slideshowController: fullScreenController)
        fullScreenController.modalPresentationStyle = .custom
        fullScreenController.transitioningDelegate = slideshowTransitioningDelegate
        
        //        fullScreenController.slideshow.currentPageChanged = { [weak self] page in
        //            if let cell = self?.collectionProductPic.cellForItem(at: IndexPath(row: page, section: 0)) as? ProductPicCell, let imageView = cell.imgPic {
        //                self?.slideshowTransitioningDelegate?.referenceImageView = imageView
        //            }
        //        }
        
        present(fullScreenController, animated: true, completion: nil)
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
            //                self.navigationController?.pushViewController(vc, animated: true)
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
        
        let dicData = dicProductDetails
        dicData.suppliersIndex = suppliersInt
        dicData.pricesIndex = pricesInt
        
        dicProductDetails = dicData
        
        
        
        tblView.reloadRows(at: [IndexPath(row: cuurentIndex, section: 0)], with: .none)
        
    }
    
    @objc func clickedProWishList(_  sender: UIButton)
    {
        
        if let isUserLogin = appDelegate?.getIsUserLogin()
        {
            if isUserLogin == true
            {
                if dicProductDetails.favourite == true
                {
                    callRemovetoWishlistAPI(pro_Id: dicProductDetails.id ?? 0)
                }
                else
                {
                    callAddtoWishlistAPI(pro_Id: dicProductDetails.id ?? 0)
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
                // APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        // self.setUpMakeToast(msg: message ?? "")
                        
                        self.callProductDetailsAPI(isShow: false)
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
                // APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        //   self.setUpMakeToast(msg: message ?? "")
                        
                        self.callProductDetailsAPI(isShow: false)
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
    
    
    func callProductDetailsAPI(isShow: Bool)
    {
        if isShow == true {
            APIClient.sharedInstance.showIndicator()
        }
        
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(GET_PRODUCTS_DETAILS + self.strProductID, parameters: param) { response, error, statusCode in
            
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
                            if let dicProduct = dicResult.value(forKey: "product") as? NSDictionary
                            {
                                let dicData = TBProductDetailsData(fromDictionary: dicProduct)
                                
                                if dicData.suppliers.count > 0
                                {
                                    for (index11,objQty11)  in dicData.suppliers.enumerated()
                                    {
                                        for (index,objQty)  in objQty11.prices.enumerated()
                                        {
                                            dicData.suppliers[index11].prices[index].qty = 1
                                        }
                                    }
                                }
                                
                                self.dicProductDetails = dicData
                                
                                self.lblPName.text = self.dicProductDetails.name.uppercased()
                                
                                self.isAPICall = true
                                
                                self.tblView.reloadData()
                            }
                            
                            if let arr_related_products = dicResult.value(forKey: "related_products") as? NSArray {
                                
                                self.arrRelatedProduct = (arr_related_products.mutableCopy() as! NSMutableArray)
                                
                                self.isAPICall = true
                                
                                self.tblView.reloadData()
                            }
                        }
                        
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                        
                        self.setUpMakeToast(msg: message ?? "")
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

extension ProductDetailVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if isAPICall == true
        {
            return 2
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "ProductDetailCell") as! ProductDetailCell
            
            if Language.shared.isArabic {
                cell.lblName.textAlignment = .right
                cell.lblDes.textAlignment = .right
                
                cell.lblDes.text = self.dicProductDetails.productDescriptionAr ?? ""
            } else {
                cell.lblName.textAlignment = .left
                cell.lblDes.textAlignment = .left
                
                cell.lblDes.text = self.dicProductDetails.productDescriptionEn ?? ""
            }
            
            if self.dicProductDetails.catelog == ""
            {
                cell.viewCatg.isHidden = true
            }
            else
            {
                cell.viewCatg.isHidden = false
            }
            
            cell.btnViewPDf.tag = indexPath.row
            cell.btnViewPDf.addTarget(self, action: #selector(clickedOpenPDf(_ :)), for: .touchUpInside)
            
            cell.delegate = self
            
            cell.lblName.text = self.dicProductDetails.name ?? ""
            
            cell.lblName.type = .continuous
            cell.lblName.speed = .duration(10.0)
            cell.lblName.trailingBuffer = 10
            
            cell.lvlCatgow.text = "Catalogue:".localizeString(string: Language.shared.currentAppLang)

            
            cell.lblsupp.text = "Supplier:".localizeString(string: Language.shared.currentAppLang)
            cell.lblTWeight.text = "\(self.dicProductDetails.unitType ?? ""):"
            
            cell.btnAddtoCart.setTitle("Add to cart".localizeString(string: Language.shared.currentAppLang), for: .normal)
            
            if appDelegate?.getIsGuestLogin() == true
            {
                cell.imgFav.isHidden = true
                cell.btnFav.isHidden = true
            }
            else
            {
                cell.imgFav.isHidden = false
                cell.btnFav.isHidden = false
            }
 
            if self.dicProductDetails.favourite == true
            {
                cell.imgFav.image = UIImage(named: "ic_Fav")
            }
            else
            {
                cell.imgFav.image = UIImage(named: "ic_UnFav")
            }
            
            cell.btnProZoomSlider.tag = indexPath.row
            cell.btnProZoomSlider.addTarget(self, action: #selector(clickedPicZoom(_:)), for: .touchUpInside)
            
            cell.btnFav.tag = indexPath.row
            cell.btnFav.addTarget(self, action: #selector(clickedProWishList(_:)), for: .touchUpInside)
            
            if self.dicProductDetails.productImages.count > 0
            {
                
                if self.dicProductDetails.productImages.count == 1
                {
                    cell.RefreceImgWidhCont.constant = 0
                    
                    cell.viewTop_.isHidden = true
                    cell.viewBottom_.isHidden = true
                    cell.viewLine_.isHidden = true
                    
                    cell.viewTwoPro.isHidden = true
                    
                    
                    cell.imgOnePro.isHidden = true
                    cell.btnOnePro.isHidden = true
                    
                    cell.imgTwoPro.isHidden = true
                    cell.btnTwoPro.isHidden = true
                }
                else if self.dicProductDetails.productImages.count == 2
                {
                    cell.RefreceImgWidhCont.constant = 80
                    
                    cell.viewTop_.isHidden = true
                    cell.viewBottom_.isHidden = true
                    cell.viewLine_.isHidden = false
                    
                    cell.viewTwoPro.isHidden = false
                    
                    
                    cell.imgOnePro.isHidden = false
                    cell.btnOnePro.isHidden = false
                    
                    cell.imgTwoPro.isHidden = false
                    cell.btnTwoPro.isHidden = false
                    
                    
                    let img1 = self.dicProductDetails.productImages[0].image ?? ""
                    var media_link_url1 = img1
                    media_link_url1 = (media_link_url1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                    cell.imgOnePro.sd_setImage(with: URL.init(string: media_link_url1),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
                    
                    let img = self.dicProductDetails.productImages[1].image ?? ""
                    var media_link_url = img
                    media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                    cell.imgTwoPro.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
                    
                    
                    cell.btnOnePro.tag = indexPath.row
                    cell.btnOnePro.addTarget(self, action: #selector(clickedShowOnePro(_ :)), for: .touchUpInside)
                    
                    cell.btnTwoPro.tag = indexPath.row
                    cell.btnTwoPro.addTarget(self, action: #selector(clickedShowTwoPro(_ :)), for: .touchUpInside)
                    
                    
                }
                else
                {
                    cell.RefreceImgWidhCont.constant = 80
                    
                    cell.viewTop_.isHidden = false
                    cell.viewBottom_.isHidden = false
                    cell.viewLine_.isHidden = false
                    
                    cell.viewTwoPro.isHidden = true
                    
                    
                    cell.imgOnePro.isHidden = true
                    cell.btnOnePro.isHidden = true
                    
                    cell.imgTwoPro.isHidden = true
                    cell.btnTwoPro.isHidden = true
                }
                
                let img1 = self.dicProductDetails.productImages[0].image ?? ""
                
                var media_link_url = img1
                media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                cell.imgProduct.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
            }
            else
            {
                cell.RefreceImgWidhCont.constant = 0
                
                cell.viewTop_.isHidden = true
                cell.viewBottom_.isHidden = true
                cell.viewLine_.isHidden = true
                
                cell.viewTwoPro.isHidden = true
                
                cell.imgOnePro.isHidden = true
                cell.btnOnePro.isHidden = true
                
                cell.imgTwoPro.isHidden = true
                cell.btnTwoPro.isHidden = true
            }
            
            cell.dicProductDetails = self.dicProductDetails
            cell.ObjCurrentCellIndex = indexPath.row
            
            
            if dicProductDetails.isSupplierDetailShow == 1
            {
                cell.lblsupp.isHidden = false
                cell.collectionSupplier.isHidden = false
                
                cell.lbltopsubCon.constant = 20
                cell.lblSubHeightcon.constant = 25
                cell.collectionsubHeightcon.constant = 30
                
                if dicProductDetails.suppliers.count > 0
                {
                    cell.arrWeight = dicProductDetails.suppliers[0].prices
                    
                    if dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices.count > 0
                    {
                        cell.txtQty.text = "\(dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].qty ?? 0)"
                        
                        let quantity = dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].quantity ?? 0
                        
                        let minus_quantity = dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].minusQuantity ?? 0
                        
                        let factory_product = dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].factoryProduct ?? 0

                        if factory_product == 0 {
                            if minus_quantity == 0 && quantity == 0
                            {
                                cell.btnAddtoCart.setTitle("Out of stock".localizeString(string: Language.shared.currentAppLang), for: .normal)
                                cell.btnAddtoCart.backgroundColor = .systemGray2
                                cell.viewQtyHideShow.isHidden = true
                            }
                            else
                            {
                                cell.btnAddtoCart.setTitle("Add to cart".localizeString(string: Language.shared.currentAppLang), for: .normal)
                                cell.btnAddtoCart.backgroundColor = UIColor(red: 70/255, green: 68/255, blue: 85/255, alpha: 1)
                                cell.viewQtyHideShow.isHidden = false
                            }
                        }
                        else {
                            cell.btnAddtoCart.setTitle("Add to cart".localizeString(string: Language.shared.currentAppLang), for: .normal)
                            cell.btnAddtoCart.backgroundColor = UIColor(red: 70/255, green: 68/255, blue: 85/255, alpha: 1)
                            cell.viewQtyHideShow.isHidden = false
                        }
                      
                        
                        if cell.txtQty.text == "0" {
                            cell.txtQty.text = "1"
                        }
                        
                        let objMul = Double(dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") )! * (Double(cell.txtQty.text ?? "") ?? 0.0)
                        
                        let formattedNumber = String(format: "%.3f", objMul)
                        cell.lblPrice.text = "\(formattedNumber) \(dicProductDetails.currency ?? "")"
                        
                        
                        
                        cell.lblSPrice.attributedText = "\(dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].originalPrice.replacingOccurrences(of: ",", with: "") ) \(dicProductDetails.currency ?? "")".strikeThrough()
                        
                        if dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") == dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].originalPrice.replacingOccurrences(of: ",", with: "")
                        {
                            cell.lblSPrice.isHidden = true
                            cell.lblStrike.isHidden = true
                            
                        }
                        else
                        {
                            cell.lblSPrice.isHidden = false
                            cell.lblStrike.isHidden = false
                        }
                    }
                    else
                    {
                        cell.lblSPrice.isHidden = true
                        cell.lblStrike.isHidden = true
                    }
                }
                else
                {
                    cell.lblsupp.isHidden = true
                    cell.collectionSupplier.isHidden = true
                    
                    cell.lblSPrice.isHidden = true
                    cell.lblStrike.isHidden = true
                }
                
            }
            else
            {
                cell.lblsupp.isHidden = true
                cell.collectionSupplier.isHidden = true
                
                
                cell.lbltopsubCon.constant = 0
                cell.lblSubHeightcon.constant = 0
                cell.collectionsubHeightcon.constant = 0
                
                if dicProductDetails.suppliers.count > 0
                {
                    cell.arrWeight = dicProductDetails.suppliers[0].prices
                    
                    if dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices.count > 0
                    {
                        cell.txtQty.text = "\(dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].qty ?? 0)"
                        
                        let quantity = dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].quantity ?? 0
                        
                        let minus_quantity = dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].minusQuantity ?? 0
                        
                        let factory_product = dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].factoryProduct ?? 0

                        if factory_product == 0 {
                            if minus_quantity == 0 && quantity == 0
                            {
                                cell.btnAddtoCart.setTitle("Out of stock".localizeString(string: Language.shared.currentAppLang), for: .normal)
                                cell.btnAddtoCart.backgroundColor = .systemGray2
                                cell.viewQtyHideShow.isHidden = true
                            }
                            else
                            {
                                cell.btnAddtoCart.setTitle("Add to cart".localizeString(string: Language.shared.currentAppLang), for: .normal)
                                cell.btnAddtoCart.backgroundColor = UIColor(red: 70/255, green: 68/255, blue: 85/255, alpha: 1)
                                cell.viewQtyHideShow.isHidden = false
                            }
                        }
                        else {
                            cell.btnAddtoCart.setTitle("Add to cart".localizeString(string: Language.shared.currentAppLang), for: .normal)
                            cell.btnAddtoCart.backgroundColor = UIColor(red: 70/255, green: 68/255, blue: 85/255, alpha: 1)
                            cell.viewQtyHideShow.isHidden = false
                        }
                       
                        
                        if cell.txtQty.text == "0" {
                            cell.txtQty.text = "1"
                        }
                        
                        
                        let objMul = Double(dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") )! * (Double(cell.txtQty.text ?? "") ?? 0.0)
                        
                        let formattedNumber = String(format: "%.3f", objMul)
                        cell.lblPrice.text = "\(formattedNumber) \(dicProductDetails.currency ?? "")"
                        
                        cell.lblSPrice.attributedText = "\(dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].originalPrice.replacingOccurrences(of: ",", with: "") ) \(dicProductDetails.currency ?? "")".strikeThrough()
                        
                        if dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") == dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].originalPrice.replacingOccurrences(of: ",", with: "")
                        {
                            cell.lblSPrice.isHidden = true
                            cell.lblStrike.isHidden = true
                            
                        }
                        else
                        {
                            cell.lblSPrice.isHidden = false
                            cell.lblStrike.isHidden = false
                        }
                    }
                    else
                    {
                        cell.lblSPrice.isHidden = true
                        cell.lblStrike.isHidden = true
                    }
                }
                else
                {
                    cell.lblsupp.isHidden = true
                    cell.collectionSupplier.isHidden = true
                    
                    cell.lblSPrice.isHidden = true
                    cell.lblStrike.isHidden = true
                }
            }
            
            cell.collectionViewWeight.reloadData()
            cell.collectionSupplier.reloadData()
            
            
            cell.btnAddtoCart.tag = indexPath.row
            cell.btnAddtoCart.addTarget(self, action: #selector(clickedAddToCart(_:)), for: .touchUpInside)
            
            cell.btnAdd.tag = indexPath.row
            cell.btnAdd.addTarget(self, action: #selector(clickedAddQty(_:)), for: .touchUpInside)
            
            cell.btnRemove.tag = indexPath.row
            cell.btnRemove.addTarget(self, action: #selector(clickedRemoveQty(_:)), for: .touchUpInside)
            
            cell.txtQty.tag = indexPath.row
            cell.txtQty.delegate = self
            cell.txtQty.addTarget(self, action: #selector(searchWorkersAsPerText(_:)), for: .editingChanged)
            
            //            cell.dicProductDetails = self.dicProductDetails
            
            //            if dicProductDetails.suppliers.count > 1
            //            {
            //                cell.lblPrice.text = "\(dicProductDetails.suppliers[cell.selectedIndexS].prices[cell.selectedIndexW].discountPrice.replacingOccurrences(of: ",", with: "") ?? "") \(dicProductDetails.currency ?? "")"
            //                cell.lblSPrice.attributedText = "\(dicProductDetails.suppliers[cell.selectedIndexS].prices[cell.selectedIndexW].originalPrice.replacingOccurrences(of: ",", with: "") ?? "") \(dicProductDetails.currency ?? "")".strikeThrough()
            //
            //                cell.lblsupp.isHidden = false
            //                cell.collectionSupplier.isHidden = false
            //
            //                if dicProductDetails.suppliers[cell.selectedIndexS].prices[cell.selectedIndexW].discountPrice.replacingOccurrences(of: ",", with: "") == dicProductDetails.suppliers[cell.selectedIndexS].prices[cell.selectedIndexW].originalPrice.replacingOccurrences(of: ",", with: "")
            //                {
            //                    cell.lblSPrice.isHidden = true
            //                    cell.lblStrike.isHidden = true
            //                }
            //                else
            //                {
            //                    cell.lblSPrice.isHidden = false
            //                    cell.lblStrike.isHidden = false
            //                }
            //            }
            //            else
            //            {
            //                if dicProductDetails.suppliers.count > 0
            //                {
            //
            //                    if dicProductDetails.isSupplierDetailShow == 0
            //                    {
            //                        cell.lblsupp.isHidden = true
            //                        cell.collectionSupplier.isHidden = true
            //
            //
            //                        cell.lbltopsubCon.constant = 0
            //                        cell.lblSubHeightcon.constant = 0
            //                        cell.collectionsubHeightcon.constant = 0
            //
            //                    }
            //                    else
            //                    {
            //                        cell.lblsupp.isHidden = false
            //                        cell.collectionSupplier.isHidden = false
            //
            //                        cell.lbltopsubCon.constant = 20
            //                        cell.lblSubHeightcon.constant = 25
            //                        cell.collectionsubHeightcon.constant = 30
            //                    }
            //
            //
            //                    cell.lblPrice.text = "\(dicProductDetails.suppliers[cell.selectedIndexS].prices[cell.selectedIndexW].discountPrice.replacingOccurrences(of: ",", with: "") ?? "") \(dicProductDetails.currency ?? "")"
            //                    cell.lblSPrice.attributedText = "\(dicProductDetails.suppliers[cell.selectedIndexS].prices[cell.selectedIndexW].originalPrice.replacingOccurrences(of: ",", with: "") ?? "") \(dicProductDetails.currency ?? "")".strikeThrough()
            //
            //
            //
            //                    if dicProductDetails.suppliers[0].prices[cell.selectedIndexW].discountPrice.replacingOccurrences(of: ",", with: "") == dicProductDetails.suppliers[0].prices[cell.selectedIndexW].originalPrice.replacingOccurrences(of: ",", with: "")
            //                    {
            //                        cell.lblSPrice.isHidden = true
            //                        cell.lblStrike.isHidden = true
            //                    }
            //                    else
            //                    {
            //                        cell.lblSPrice.isHidden = false
            //                        cell.lblStrike.isHidden = false
            //                    }
            //
            //                }
            //                else
            //                {
            //                    cell.lblsupp.isHidden = true
            //                    cell.collectionSupplier.isHidden = true
            //
            //                    cell.lblSPrice.isHidden = true
            //                    cell.lblStrike.isHidden = true
            //                }
            //
            //            }
            
            
            //            if cell.productID == dicProductDetails.id
            //            {
            //                if dicProductDetails.suppliers.count > 0
            //                {
            //
            //                    cell.lblPrice.text = "\(dicProductDetails.suppliers[cell.selectedIndexS].prices[cell.selectedIndexW].discountPrice.replacingOccurrences(of: ",", with: "") ?? "") \(dicProductDetails.currency ?? "")"
            //                    cell.lblSPrice.attributedText = "\(dicProductDetails.suppliers[cell.selectedIndexS].prices[cell.selectedIndexW].originalPrice.replacingOccurrences(of: ",", with: "") ?? "") \(dicProductDetails.currency ?? "")".strikeThrough()
            //
            //                    if dicProductDetails.suppliers[cell.selectedIndexS].prices[cell.selectedIndexW].discountPrice.replacingOccurrences(of: ",", with: "") == dicProductDetails.suppliers[cell.selectedIndexS].prices[cell.selectedIndexW].originalPrice.replacingOccurrences(of: ",", with: "")
            //                    {
            //                        cell.lblSPrice.isHidden = true
            //                        cell.lblStrike.isHidden = true
            //                    }
            //                    else
            //                    {
            //                        cell.lblSPrice.isHidden = false
            //                        cell.lblStrike.isHidden = false
            //                    }
            //
            //                }
            //                else
            //                {
            //                    cell.lblsupp.isHidden = true
            //                    cell.collectionSupplier.isHidden = true
            //                }
            //
            //            }
            //            else
            //            {
            //                if dicProductDetails.suppliers.count > 0
            //                {
            //                    if dicProductDetails.suppliers[cell.selectedIndexS].prices.count > 0
            //                    {
            //
            //                        cell.lblPrice.text = "\(dicProductDetails.suppliers[cell.selectedIndexS].prices[cell.selectedIndexW].discountPrice.replacingOccurrences(of: ",", with: "") ?? "") \(dicProductDetails.currency ?? "")"
            //                        cell.lblSPrice.attributedText = "\(dicProductDetails.suppliers[cell.selectedIndexS].prices[cell.selectedIndexW].originalPrice.replacingOccurrences(of: ",", with: "") ?? "") \(dicProductDetails.currency ?? "")".strikeThrough()
            //
            //                        if dicProductDetails.suppliers[cell.selectedIndexS].prices[cell.selectedIndexW].discountPrice.replacingOccurrences(of: ",", with: "") == dicProductDetails.suppliers[cell.selectedIndexS].prices[cell.selectedIndexW].originalPrice.replacingOccurrences(of: ",", with: "")
            //                        {
            //                            cell.lblSPrice.isHidden = true
            //                            cell.lblStrike.isHidden = true
            //                        }
            //                        else
            //                        {
            //                            cell.lblSPrice.isHidden = false
            //                            cell.lblStrike.isHidden = false
            //                        }
            //
            //                    }
            //                    else
            //                    {
            //                        cell.lblsupp.isHidden = true
            //                        cell.collectionSupplier.isHidden = true
            //
            //                        cell.lblSPrice.isHidden = true
            //                        cell.lblStrike.isHidden = true
            //                    }
            //
            //
            //                }
            //                else
            //                {
            //                    cell.lblsupp.isHidden = true
            //                    cell.collectionSupplier.isHidden = true
            //                }
            //            }
            
            
            //            cell.collectionSupplier.reloadData()
            
            
            
            
            return cell
        }
        else
        {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "RelatedCell") as! RelatedCell
            
            cell.lblTRekated.text = "Related products".localizeString(string: Language.shared.currentAppLang)
            
            if self.arrRelatedProduct.count > 0 {
                cell.arrRelatedProduct = self.arrRelatedProduct
                cell.lblTRekated.isHidden = false
            }
            else
            {
                cell.lblTRekated.isHidden = true
            }
            
            cell.delegateVC = self
            
            cell.collectionViewRelated.reloadData()
            
            return cell
        }
    }
    
    @objc func clickedOpenPDf(_ sender: UIButton) {
        
        if let url = URL(string: self.dicProductDetails.catelog ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                if success {
                } else {
                    self.view.makeToast("Failed to open PDF in Safari")
                }
            })
        }
        
    }
    
    @objc func clickedPicZoom(_ sender: UIButton) {
        
        models.removeAll()
        
        for obj in self.dicProductDetails.productImages
        {
            let imgg = UIImageView()
            
            var media_link_url = obj.image ?? ""
            media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            imgg.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
            
            let objModel = Model(image: imgg.image!)
            
            models.append(objModel)
        }
        
        
        let fullScreenController = FullScreenSlideshowViewController()
        fullScreenController.inputs = models.map { $0.inputSource }
        fullScreenController.initialPage = 0
        
        let imgg = UIImageView()
        
        var media_link_url = dicProductDetails.productImages[0].image ?? ""
        media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        imgg.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
        
        let indexPath_ = IndexPath(row: 0, section: 0)
        
        slideshowTransitioningDelegate = ZoomAnimatedTransitioningDelegate(imageView: imgg, slideshowController: fullScreenController)
        fullScreenController.modalPresentationStyle = .custom
        fullScreenController.transitioningDelegate = slideshowTransitioningDelegate
        
        //        fullScreenController.slideshow.currentPageChanged = { [weak self] page in
        //            if let cell = self?.collectionProductPic.cellForItem(at: IndexPath(row: page, section: 0)) as? ProductPicCell, let imageView = cell.imgPic {
        //                self?.slideshowTransitioningDelegate?.referenceImageView = imageView
        //            }
        //        }
        
        present(fullScreenController, animated: true, completion: nil)
    }
    
    
    @objc func searchWorkersAsPerText(_ textfield:UITextField) {
        
        let dicData = dicProductDetails
        
        let indexPath = NSIndexPath(row: textfield.tag, section: 0)
        
        let cell = self.tblView.cellForRow(at: indexPath as IndexPath) as! ProductDetailCell
        
        let objQty = Int(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].quantity ?? 0)
        
        let minus_quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].minusQuantity ?? 0
        
        var objQty12 = Int(cell.txtQty.text ?? "") ?? 0
        
        let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty12)
        
        let formattedNumber = String(format: "%.3f", objMul)
        cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
        
        let factoryProduct = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].factoryProduct ?? 0

        if factoryProduct == 1
        {
            cell.btnAddtoCart.isUserInteractionEnabled = true
        }
        else
        {
            if Double(objQty) < (Double(textfield.text ?? "") ?? 0.0) {
                
                cell.btnAddtoCart.isUserInteractionEnabled = false
                
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
                cell.btnAddtoCart.isUserInteractionEnabled = true
            }
        }
 
        
        // Handle when text field editing ends
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        return true
    }
    
    @objc func clickedShowOnePro(_ sender: UIButton) {
        
        let cell = self.tblView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! ProductDetailCell
        
        let img1 = self.dicProductDetails.productImages[0].image ?? ""
        var media_link_url1 = img1
        media_link_url1 = (media_link_url1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        cell.imgProduct.sd_setImage(with: URL.init(string: media_link_url1),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
        
    }
    
    @objc func clickedShowTwoPro(_ sender: UIButton) {
        
        let cell = self.tblView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! ProductDetailCell
        
        
        let img = self.dicProductDetails.productImages[1].image ?? ""
        var media_link_url = img
        media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        cell.imgProduct.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return UITableView.automaticDimension
        }
        else
        {
            return 220
        }
    }
    
    @objc func clickedAddToCart(_  sender: UIButton)
    {
        if appDelegate?.dicCurrentLoginUser.id != nil
        {
            let indexPath = NSIndexPath(row: sender.tag, section: 0)
            
            let cell = self.tblView.cellForRow(at: indexPath as IndexPath) as! ProductDetailCell
            
            let objQty = Int(cell.txtQty.text ?? "") ?? 0
            
            cell.txtQty.text = "\(objQty)"
            
            
            if objQty == 0 || cell.txtQty.text == ""
            {
                self.setUpMakeToast(msg: "Out of stock".localizeString(string: Language.shared.currentAppLang).localizeString(string: Language.shared.currentAppLang))
            }
            else
            {
                let dicData = dicProductDetails
                
                if dicData.suppliers.count > 1
                {
                    dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty = objQty
                    dicProductDetails = dicData
                    
                    let productID =  "\(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].productPriceId ?? 0)"
                    
                    let quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].quantity ?? 0
                    
                    let minus_quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].minusQuantity ?? 0
                    
                    let factory_product = dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].factoryProduct ?? 0
                    
                    if factory_product == 0 {
                        if minus_quantity == 0 && quantity == 0
                        {
                            self.setUpMakeToast(msg: "Out of stock".localizeString(string: Language.shared.currentAppLang).localizeString(string: Language.shared.currentAppLang))
                        }
                        else
                        {
                            let pro_id = "\(dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].productPriceId ?? 0)"
                            callAddtoCartAPI(qty: objQty, pro_Id: Int(pro_id) ?? 0)
                        }
                    }
                    else {
                        let pro_id = "\(dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].productPriceId ?? 0)"
                        callAddtoCartAPI(qty: objQty, pro_Id: Int(pro_id) ?? 0)
                    }
                    
                  
                }
                else
                {
                    if dicData.suppliers.count > 0
                    {
                        dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty = objQty
                        dicProductDetails = dicData
                        
                        let productID =  "\(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].productPriceId ?? 0)"
                        
                        let quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].quantity ?? 0
                        
                        let minus_quantity = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].minusQuantity ?? 0
                        
                        let factory_product = dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].factoryProduct ?? 0

                        if factory_product == 0 {
                            if minus_quantity == 0 && quantity == 0
                            {
                                self.setUpMakeToast(msg: "Out of stock".localizeString(string: Language.shared.currentAppLang).localizeString(string: Language.shared.currentAppLang))
                            }
                            else
                            {
                                let pro_id = "\(dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].productPriceId ?? 0)"
                                callAddtoCartAPI(qty: objQty, pro_Id: Int(pro_id) ?? 0)
                            }
                        }
                        else {
                            let pro_id = "\(dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].productPriceId ?? 0)"
                            callAddtoCartAPI(qty: objQty, pro_Id: Int(pro_id) ?? 0)
                        }
                        
                    }
                }
            }
            
            
            //            if objQty == 0 || cell.txtQty.text == "" {
            //                self.setUpMakeToast(msg: "Out of stock".localizeString(string: Language.shared.currentAppLang).localizeString(string: Language.shared.currentAppLang))
            //            } else {
            //                let quantity = dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].quantity ?? 0
            //
            //                let minus_quantity = dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].minusQuantity ?? 0
            //
            //                if dicProductDetails.suppliers.count > 1
            //                {
            //                    if minus_quantity == 0 && quantity == 0 {
            //                        self.setUpMakeToast(msg: "Out of stock".localizeString(string: Language.shared.currentAppLang).localizeString(string: Language.shared.currentAppLang))
            //                    } else {
            //                        if cell.productID == dicProductDetails.id
            //                        {
            //                            let pro_id = "\(dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].productPriceId ?? 0)"
            //                            callAddtoCartAPI(qty: objQty, pro_Id: Int(pro_id) ?? 0)
            //                        }
            //                        else
            //                        {
            //                            let pro_id = "\(dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].productPriceId ?? 0)"
            //                            callAddtoCartAPI(qty: objQty, pro_Id: Int(pro_id) ?? 0)
            //                        }
            //                    }
            //                }
            //                else
            //                {
            //
            //                    if dicProductDetails.suppliers.count > 0
            //                    {
            //                        if minus_quantity == 0 && quantity == 0 {
            //                            self.setUpMakeToast(msg: "Out of stock".localizeString(string: Language.shared.currentAppLang).localizeString(string: Language.shared.currentAppLang))
            //                        } else {
            //                            if cell.productID == dicProductDetails.id
            //                            {
            //                                let pro_id = "\(dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].productPriceId ?? 0)"
            //                                callAddtoCartAPI(qty: objQty, pro_Id: Int(pro_id) ?? 0)
            //                            }
            //                            else
            //                            {
            //                                let pro_id = "\(dicProductDetails.suppliers[dicProductDetails.suppliersIndex].prices[dicProductDetails.pricesIndex].productPriceId ?? 0)"
            //                                callAddtoCartAPI(qty: objQty, pro_Id: Int(pro_id) ?? 0)
            //                            }
            //                        }
            //
            //                    }
            //                    else
            //                    {
            //                        self.setUpMakeToast(msg: "Please select supplier".localizeString(string: Language.shared.currentAppLang))
            //                    }
            //                }
            //            }
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
        let dicData = dicProductDetails
        
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        
        let cell = self.tblView.cellForRow(at: indexPath as IndexPath) as! ProductDetailCell
        
        var objQty = Int(cell.txtQty.text ?? "") ?? 0
        
        if dicData.suppliers.count > 1
        {
            if dicData.suppliers.count > 0 {
                
                let factoryProduct = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].factoryProduct ?? 0
                
                if factoryProduct == 1
                {
                    objQty = objQty + 1
                    
                    cell.txtQty.text = "\(objQty)"
                    
                    let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty)
                    
                    let formattedNumber = String(format: "%.3f", objMul)
                    cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
                    
                    dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty = objQty
                    dicProductDetails = dicData
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
                            
                            let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty)
                            
                            let formattedNumber = String(format: "%.3f", objMul)
                            cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
                            
                            dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty = objQty
                            dicProductDetails = dicData
                        }
                    }
                    
                }
                

            }
        }
        else
        {
            
            if dicData.suppliers.count > 0
            {
                
                if dicData.suppliers.count > 0 {
                    
                    let factoryProduct = dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].factoryProduct ?? 0
                    
                    if factoryProduct == 1
                    {
                        objQty = objQty + 1
                        
                        cell.txtQty.text = "\(objQty)"
                        
                        let objMul = Double(dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].discountPrice.replacingOccurrences(of: ",", with: "") ?? "")! * Double(objQty)
                        
                        let formattedNumber = String(format: "%.3f", objMul)
                        cell.lblPrice.text = "\(formattedNumber) \(dicData.currency ?? "")"
                        
                        dicData.suppliers[dicData.suppliersIndex].prices[dicData.pricesIndex].qty = objQty
                        dicProductDetails = dicData
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
                                dicProductDetails = dicData
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
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        
        let cell = self.tblView.cellForRow(at: indexPath as IndexPath) as! ProductDetailCell
        
        var objQty = Int(cell.txtQty.text ?? "") ?? 0
        
        let dicData = dicProductDetails
        
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
                dicProductDetails = dicData
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
                    dicProductDetails = dicData
                }
                
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
                        self.callGetCartAPI()
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
    
}

class ProductDetailCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    @IBOutlet weak var lvlCatgow: UILabel!
    
    @IBOutlet weak var btnViewPDf: UIButton!
    
    @IBOutlet weak var viewCatg: UIView!
    
    @IBOutlet weak var btnProZoomSlider: UIButton!
    
    
    @IBOutlet weak var lbltopsubCon: NSLayoutConstraint!//20
    
    @IBOutlet weak var lblSubHeightcon: NSLayoutConstraint!//25
    
    @IBOutlet weak var collectionsubHeightcon: NSLayoutConstraint! //30
    
    @IBOutlet weak var viewTwoPro: UIView!
    @IBOutlet weak var imgOnePro: UIImageView!
    @IBOutlet weak var imgTwoPro: UIImageView!
    
    
    @IBOutlet weak var btnOnePro: UIButton!
    @IBOutlet weak var btnTwoPro: UIButton!
    
    
    @IBOutlet weak var viewTop_: UIView!
    @IBOutlet weak var viewBottom_: UIView!
    @IBOutlet weak var viewLine_: UIView!
    
    
    @IBOutlet weak var RefreceImgWidhCont: NSLayoutConstraint! //80
    
    @IBOutlet weak var lblsupp: UILabel!
    
    
    @IBOutlet weak var viewQtyHideShow: UIView!
    
    @IBOutlet weak var btnAddtoCart: UIButton!
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var collectionProductPic: UICollectionView!
    @IBOutlet weak var collectionViewWeight: UICollectionView!
    @IBOutlet weak var lblName: MarqueeLabel!
    
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var imgFav: UIImageView!
    
    @IBOutlet weak var lblDes: UILabel!
    @IBOutlet weak var lblSPrice: UILabel!
    @IBOutlet weak var lblStrike: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var collectionSupplier: UICollectionView!
    
    @IBOutlet weak var lblTWeight: UILabel!
    
    @IBOutlet weak var txtQty: UITextField!
    
    let ConsectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let ConitemsPerRow: CGFloat = 3
    
    var ConflowLayout: UICollectionViewFlowLayout {
        let _ConflowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.ConsectionInsets.left * (self.ConitemsPerRow + 1)
            let availableWidth = self.collectionViewWeight.frame.width - paddingSpace
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
    
    let PicsectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let PicitemsPerRow: CGFloat = 3
    
    var PicflowLayout: UICollectionViewFlowLayout {
        let _PicflowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.PicsectionInsets.left * (self.PicitemsPerRow + 1)
            let availableWidth = self.collectionProductPic.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.PicitemsPerRow
            
            _PicflowLayout.itemSize = CGSize(width: 60, height: 60)
            
            _PicflowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            _PicflowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
            _PicflowLayout.minimumInteritemSpacing = 10
            _PicflowLayout.minimumLineSpacing = 10
        }
        
        // edit properties here
        return _PicflowLayout
    }
    
    var dicProductDetails = TBProductDetailsData()
    
    var ObjCurrentCellIndex = 0
    var arrWeight: [TBProductDetailsPrice] = [TBProductDetailsPrice]()
    
    
    weak var delegate: CustomTableViewCellDelegate?
    
    var selectedIndexW = 0
    var selectedIndexS = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionViewWeight.delegate = self
        collectionViewWeight.dataSource = self
        //   collectionViewWeight.collectionViewLayout = ConflowLayout
        
        collectionSupplier.delegate = self
        collectionSupplier.dataSource = self
        //   collectionSupplier.collectionViewLayout = ConflowLayout1
        
        collectionProductPic.delegate = self
        collectionProductPic.dataSource = self
        collectionProductPic.collectionViewLayout = PicflowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionProductPic
        {
            return dicProductDetails.productImages.count
        }
        else if collectionView == collectionViewWeight
        {
            
            
            if dicProductDetails.suppliers.count > 1
            {
                return dicProductDetails.suppliers[selectedIndexS].prices.count
            }
            else
            {
                
                if dicProductDetails.suppliers.count > 0
                {
                    
                    //                    if dicProductDetails.is_supplier_detail_show == 0
                    //                    {
                    //                        return 0
                    //                    }
                    //                    else
                    //      {
                    return dicProductDetails.suppliers[selectedIndexS].prices.count
                    //       }
                    
                }
                else
                {
                    return 0
                }
                
                
            }
            
            
        }
        else{
            
            //            if dicProductDetails.suppliers.count > 0
            //            {
            //
            //                if dicProductDetails.isSupplierDetailShow == 0
            //                {
            //                    return 0
            //                }
            //                else
            //                {
            //                    return dicProductDetails.suppliers.count
            //                }
            //
            //            }
            //            else
            //            {
            //                return 0
            //            }
            
            return  dicProductDetails.suppliers.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionProductPic
        {
            let cell = self.collectionProductPic.dequeueReusableCell(withReuseIdentifier: "ProductPicCell", for: indexPath) as! ProductPicCell
            
            if indexPath.row == 0
            {
                cell.yopView.isHidden = true
            }
            else
            {
                cell.yopView.isHidden = false
            }
            
            var media_link_url = "\(self.dicProductDetails.productImages[indexPath.row].image ?? "")"
            media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            cell.imgPic.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
            
            return cell
        }
        else if collectionView == collectionViewWeight
        {
            let cell = self.collectionViewWeight.dequeueReusableCell(withReuseIdentifier: "DetailWeightCell", for: indexPath) as! DetailWeightCell
            
            if self.dicProductDetails.suppliers[selectedIndexS].prices[indexPath.row].value == ""
            {
                cell.lblName.text = "null"
            }
            else
            {
                cell.lblName.text = "\(self.dicProductDetails.suppliers[selectedIndexS].prices[indexPath.row].value ?? "null")"
            }
            
            
            if dicProductDetails.pricesIndex == indexPath.row
            {
                cell.viewWirght.backgroundColor = UIColor(red: 187/255, green: 109/255, blue: 96/255, alpha: 1)
                cell.lblName.textColor = .white
            }
            else
            {
                cell.viewWirght.backgroundColor = .white
                cell.lblName.textColor = .black
            }
            
            return cell
        }
        else
        {
            let cell = self.collectionSupplier.dequeueReusableCell(withReuseIdentifier: "DetailWeightCell", for: indexPath) as! DetailWeightCell
            
            let dicData = dicProductDetails.suppliers[indexPath.row]
            
            cell.lblName.text = dicData.supplier ?? ""
            
            if selectedIndexS == indexPath.row
            {
                cell.viewWirght.backgroundColor = UIColor(red: 187/255, green: 109/255, blue: 96/255, alpha: 1)
                cell.lblName.textColor = .white
            }
            else
            {
                cell.viewWirght.backgroundColor = .white
                cell.lblName.textColor = .black
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewWeight
        {
            dicProductDetails.pricesIndex = indexPath.row
            
            selectedIndexW = indexPath.row
            collectionViewWeight.reloadData()
            
            someActionThatRequiresReload()
        }else if collectionView == collectionSupplier
        {
            
            dicProductDetails.suppliersIndex = indexPath.row
            
            selectedIndexS = indexPath.row
            collectionSupplier.reloadData()
            collectionViewWeight.reloadData()
            
            someActionThatRequiresReload()
        }
        
    }
    
    func someActionThatRequiresReload() {
        
        delegate?.reloadTableView(cuurentSection: 0, cuurentIndex: ObjCurrentCellIndex, suppliersInt: dicProductDetails.suppliersIndex, pricesInt: dicProductDetails.pricesIndex)
    }
    
    
}

class ProductPicCell: UICollectionViewCell
{
    @IBOutlet weak var imgPic: UIImageView!
    
    @IBOutlet weak var yopView: UIView!
    
}

class RelatedCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    
    @IBOutlet weak var collectionViewRelated: UICollectionView!
    @IBOutlet weak var lblTRekated: UILabel!
    
    let PicsectionInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    let PicitemsPerRow: CGFloat = 3
    
    var PicflowLayout: UICollectionViewFlowLayout {
        let _PicflowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.PicsectionInsets.left * (self.PicitemsPerRow + 1)
            let availableWidth = self.collectionViewRelated.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.PicitemsPerRow
            
            _PicflowLayout.itemSize = CGSize(width: 80, height: 150)
            
            _PicflowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            _PicflowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
            _PicflowLayout.minimumInteritemSpacing = 10
            _PicflowLayout.minimumLineSpacing = 10
        }
        
        // edit properties here
        return _PicflowLayout
    }
    
    var arrRelatedProduct = NSMutableArray()
    
    var delegateVC = UIViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionViewRelated.delegate = self
        collectionViewRelated.dataSource = self
        collectionViewRelated.collectionViewLayout = PicflowLayout
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrRelatedProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionViewRelated.dequeueReusableCell(withReuseIdentifier: "RelatedProductCell", for: indexPath) as! RelatedProductCell
        
        let dicData = arrRelatedProduct[indexPath.row] as? NSDictionary
        
        let name = dicData?.value(forKey: "name") as? String
        let net_price = dicData?.value(forKey: "net_price") as? String
        let product_image = dicData?.value(forKey: "product_image") as? String
        
        cell.lblNmae.text = name ?? ""
        
        cell.lblPrice.text = "\(net_price ?? "") KD"
        
        var media_link_url = product_image ?? ""
        media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        cell.imgPIc.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dicData = arrRelatedProduct[indexPath.row] as? NSDictionary
        
        let id = dicData?.value(forKey: "id") as? Int
        
        let mainS = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        vc.strProductID = "\(id ?? 0)"
        delegateVC.navigationController?.pushViewController(vc, animated: true)
    }
    
}

class RelatedProductCell: UICollectionViewCell
{
    @IBOutlet weak var imgPIc: UIImageView!
    @IBOutlet weak var lblNmae: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
}

class DetailWeightCell: UICollectionViewCell
{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewWirght: UIView!
    
}
