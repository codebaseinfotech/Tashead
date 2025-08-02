//
//  SubCategoriesVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 01/06/23.
//

import UIKit
import LGSideMenuController
import SDWebImage

class SubCategoriesVC: UIViewController {
    
    @IBOutlet weak var imgCart: UIImageView!
    @IBOutlet weak var imgCartWidth: NSLayoutConstraint! //22
    @IBOutlet weak var imgRightCont: NSLayoutConstraint! //20
    
    
    @IBOutlet weak var viewCountItem: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var lblSubCateName: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblCartCount: UILabel!
    
    let ConsectionInsets = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    let ConitemsPerRow: CGFloat = 2
    
    var ConflowLayout: UICollectionViewFlowLayout {
        let _ConflowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.ConsectionInsets.left * (self.ConitemsPerRow + 1)
            let availableWidth = self.collectionView.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.ConitemsPerRow
            
            _ConflowLayout.itemSize = CGSize(width: widthPerItem, height: widthPerItem - 20)
            
            _ConflowLayout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
            _ConflowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
            _ConflowLayout.minimumInteritemSpacing = 10
            _ConflowLayout.minimumLineSpacing = 10
        }
        
        // edit properties here
        return _ConflowLayout
    }
    
    var arrCategories: [TBCategoriesResult] = [TBCategoriesResult]()
    
    var strCategoryID = ""
    
    var isStepWise = false
    
    var strTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblSubCateName.text = strTitle
      
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = ConflowLayout
        
        if isStepWise == false
        {
            callCategoriesAPI()
        }
        else
        {
            callStepWiseCategoriesAPI()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblCartCount.text = appDelegate?.strTotalCount ?? ""
        
        
        if appDelegate?.strTotalCount == "0"
        {
            self.viewCountItem.isHidden = true
        }
        else
        {
            self.viewCountItem.isHidden = true
        }
        
        if appDelegate?.dicCurrentLoginUser.id != nil
        {
            lblName.text = "Welcome \(appDelegate?.dicCurrentLoginUser.name ?? "")"
            
            callGetCartAPI()
            
            imgCart.isHidden = true
            imgCartWidth.constant = 0
            imgRightCont.constant = 0

        }
        else
        {
            lblName.text = "Welcome Guest"
            
            imgCart.isHidden = true
            imgCartWidth.constant = 0
            imgRightCont.constant = 0
            self.viewCountItem.isHidden = true
        }
        
        
        
        if Language.shared.isArabic {
            imgBack.image = UIImage(named: "Back_Ar")
        }
        else
        {
            imgBack.image = UIImage(named: "Back")
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
    
    @IBAction func clickedProfile(_ sender: Any) {
        
        if let isUserLogin = appDelegate?.getIsUserLogin()
        {
            if isUserLogin == true
            {
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let vc: ProfileViewController = mainStoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                self.navigationController?.pushViewController(vc, animated: false)
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
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func callCategoriesAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderGet(GET_CATEGORIES + "\(self.strCategoryID)", parameters: param) { response, error, statusCode in
            
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
                        if let arrResult = response?.value(forKey: "result") as? NSArray
                        {
                            for obj in arrResult
                            {
                                let dicData = TBCategoriesResult(fromDictionary: obj as! NSDictionary)
                                self.arrCategories.append(dicData)
                            }
                        }
                        
                        self.collectionView.reloadData()
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
    
    func callStepWiseCategoriesAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderGet(GET_STEP_WISE_CATEGORIES + "\(self.strCategoryID)", parameters: param) { response, error, statusCode in
            
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
                        if let arrResult = response?.value(forKey: "result") as? NSArray
                        {
                            for obj in arrResult
                            {
                                let dicData = TBCategoriesResult(fromDictionary: obj as! NSDictionary)
                                self.arrCategories.append(dicData)
                            }
                        }
                        
                        self.collectionView.reloadData()
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
                        }
                        else
                        {
                            self.viewCountItem.isHidden = true
                        }
                        
                    }
                    else
                    {
                        self.lblCartCount.text = "0"
                        appDelegate?.strTotalCount = "0"
                        if appDelegate?.strTotalCount == "0"
                        {
                            self.viewCountItem.isHidden = true
                        }
                        else
                        {
                            self.viewCountItem.isHidden = true
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
}

extension SubCategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCategories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "SubCateCell", for: indexPath) as! SubCateCell
        
        let dicData = arrCategories[indexPath.row]
        
        cell.lblName.text = dicData.name ?? ""

        var media_link_url = "\(dicData.image ?? "")"
        media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        cell.imgPic.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: UIImage(named: "App_Logo"), options: [], completed: nil)
        
        DispatchQueue.main.async {
            cell.viewBottom.layer.cornerRadius = cell.viewBottom.frame.height / 2
            cell.viewBottom.clipsToBounds = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dicData = arrCategories[indexPath.row]
        
        let mains = UIStoryboard(name: "Home", bundle: nil)
        let vc = mains.instantiateViewController(withIdentifier: "ProductListVC") as! ProductListVC
        vc.strCtgID = "\(dicData.id ?? 0)"
        vc.isStepWise = self.isStepWise
        vc.strTitle = dicData.name ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

class SubCateCell: UICollectionViewCell
{
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imgPic: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgBottom: UIImageView!
    @IBOutlet weak var viewBottom: UIView!

}

extension UIBezierPath {
    
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGFloat, topRightRadius: CGFloat, bottomLeftRadius: CGFloat, bottomRightRadius: CGFloat){
        
        self.init()
        
        let path = CGMutablePath()
        
        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        
        if topLeftRadius != 0 {
            path.move(to: CGPoint(x: topLeft.x + topLeftRadius, y: topLeft.y))
        } else {
            path.move(to: topLeft)
        }
        
        if topRightRadius != 0 {
            path.addLine(to: CGPoint(x: topRight.x - topRightRadius, y: topRight.y))
            path.addArc(tangent1End: topRight, tangent2End: CGPoint(x: topRight.x, y: topRight.y + topRightRadius), radius: topRightRadius)
        }
        else {
            path.addLine(to: topRight)
        }
        
        if bottomRightRadius != 0 {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - bottomRightRadius))
            path.addArc(tangent1End: bottomRight, tangent2End: CGPoint(x: bottomRight.x - bottomRightRadius, y: bottomRight.y), radius: bottomRightRadius)
        }
        else {
            path.addLine(to: bottomRight)
        }
        
        if bottomLeftRadius != 0 {
            path.addLine(to: CGPoint(x: bottomLeft.x + bottomLeftRadius, y: bottomLeft.y))
            path.addArc(tangent1End: bottomLeft, tangent2End: CGPoint(x: bottomLeft.x, y: bottomLeft.y - bottomLeftRadius), radius: bottomLeftRadius)
        }
        else {
            path.addLine(to: bottomLeft)
        }
        
        if topLeftRadius != 0 {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y + topLeftRadius))
            path.addArc(tangent1End: topLeft, tangent2End: CGPoint(x: topLeft.x + topLeftRadius, y: topLeft.y), radius: topLeftRadius)
        }
        else {
            path.addLine(to: topLeft)
        }
        
        path.closeSubpath()
        cgPath = path
    }
}



@IBDesignable
open class VariableCornerRadiusView: UIView  {
    
    private func applyRadiusMaskFor() {
        let path = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        layer.mask = shape
    }
    
    @IBInspectable
    open var topLeftRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }
    
    @IBInspectable
    open var topRightRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }
    
    @IBInspectable
    open var bottomLeftRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }
    
    @IBInspectable
    open var bottomRightRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        applyRadiusMaskFor()
    }
}
