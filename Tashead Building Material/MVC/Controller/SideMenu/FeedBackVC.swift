//
//  FeedBackVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 05/06/23.
//

import UIKit
import HCSStarRatingView
import LGSideMenuController
import MobileCoreServices

class FeedBackVC: UIViewController, UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var lblAtt: UILabel!
    @IBOutlet weak var imgAtt: UIImageView!
    
    @IBOutlet weak var imgAttUpload: UIImageView!
    
   // @IBOutlet weak var imgCart: UIImageView!
    
    //@IBOutlet weak var viewCountItem: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var viewRating: HCSStarRatingView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtView: UITextView!
    
    @IBOutlet weak var lblTFeedback: UILabel!
    @IBOutlet weak var lblTTell: UILabel!
    
    @IBOutlet weak var btnTSend: UIButton!
    @IBOutlet weak var txtAtt: UITextField!
    
    @IBOutlet weak var btnChooseFile: UIButton!
    
    var imagePickerNew = UIImagePickerController()
    var isSelectedImg = false
    var selectedImg: String?
    
    var rateingUser = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtMobile.maxLength = 8
        txtMobile.keyboardType = .phonePad

        lblTFeedback.text = "FEEDBACK".localizeString(string: Language.shared.currentAppLang)
        lblTTell.text = "TELL US YOUR FEEDBACK".localizeString(string: Language.shared.currentAppLang)
        
        txtName.placeholder = "Name".localizeString(string: Language.shared.currentAppLang)
        txtMobile.placeholder = "Mobile Number".localizeString(string: Language.shared.currentAppLang)
        
        btnChooseFile.setTitle("Choose File".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        
        txtAtt.placeholder = "Attachment".localizeString(string: Language.shared.currentAppLang)
        txtAtt.textAlignment = Language.shared.isArabic ? .right : .left
        
        btnTSend.setTitle("Send".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        txtView.placeholder = "Text".localizeString(string: Language.shared.currentAppLang)
 
        if Language.shared.isArabic {
            txtView.placeholderTextView.textAlignment = .right
            txtView.textAlignment = .right
            txtName.textAlignment = .right
            txtMobile.textAlignment = .right
        } else {
            txtView.textAlignment = .left
            txtName.textAlignment = .left
            txtMobile.textAlignment = .left
            txtView.placeholderTextView.textAlignment = .left

        }
        
        // Do any additional setup after loading the view.
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        
        lblCartCount.text = appDelegate?.strTotalCount ?? ""
        
//        if appDelegate?.strTotalCount == "0"
//        {
//            self.viewCountItem.isHidden = true
//            imgCart.isHidden = true
//            viewCountItem.isHidden = true
//
//        }
//        else
//        {
//            self.viewCountItem.isHidden = true
//            imgCart.isHidden = true
//            viewCountItem.isHidden = true
//
//        }
//        
//        self.viewCountItem.isHidden = true
//        imgCart.isHidden = true
//        viewCountItem.isHidden = true
        
        if Language.shared.isArabic {
            imgBack.image = UIImage(named: "Back_Ar")
        }
        else
        {
            imgBack.image = UIImage(named: "Back")
        }
        
//        if let isUserLogin = appDelegate?.getIsUserLogin()
//        {
//            if isUserLogin == true
//            {
//                imgCart.isHidden = false
//                viewCountItem.isHidden = false
//                
//            }
//            else
//            {
//                imgCart.isHidden = true
//                viewCountItem.isHidden = true
//            }
//        }
//        else
//        {
//            imgCart.isHidden = true
//            viewCountItem.isHidden = true
//        }
        
    }
    
    @IBAction func ratingView(_ sender: HCSStarRatingView) {
        rateingUser = Int(sender.value)
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
    @IBAction func clickedSend(_ sender: Any) {
        
        /*if rateingUser == 0 {
            self.setUpMakeToast(msg: "Please givean rate")
        } else*/ if txtName.text == "" {
            self.setUpMakeToast(msg: "Please enter your name".localizeString(string: Language.shared.currentAppLang))
        } else if txtMobile.text == "" {
            self.setUpMakeToast(msg: "Please enter mobile number".localizeString(string: Language.shared.currentAppLang))
        }
        else if (txtMobile.text?.count ?? 0) != 8
        {
            self.setUpMakeToast(msg: "Please enter valid mobile number".localizeString(string: Language.shared.currentAppLang))
        }
        else if txtView.text == "" {
            self.setUpMakeToast(msg: "Please enter your comment".localizeString(string: Language.shared.currentAppLang))
        } else {
            if isSelectedImg == true {
                myImageUploadRequest(imageToUpload: self.imgAtt.image!, imgKey: "attachment_\(randomString(of: 4))")
            } else {
                callFeedbackAPI()
            }
        }
    }
    
    @IBAction func clickedUploadAtt(_ sender: Any) {
        let alert1 = UIAlertController(title: nil , message: nil, preferredStyle: .actionSheet)
        
        alert1.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert1.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        
        alert1.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert1, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePickerNew.delegate = self
            imagePickerNew.sourceType = UIImagePickerController.SourceType.camera
            imagePickerNew.allowsEditing = true
            imagePickerNew.mediaTypes = [kUTTypeImage as String]
            self.present(imagePickerNew, animated: true, completion: nil)
        }
        else
        {
            
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("You don't have camera")
        }
    }
    
    func openGallary()
    {
        
        imagePickerNew.delegate = self
        imagePickerNew.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerNew.allowsEditing = true
        imagePickerNew.mediaTypes = ["public.image"]
        self.present(imagePickerNew, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.imageURL] as? URL
            //            selectedImg = imageurl?.lastPathComponent
            
            if let data = image.jpegData(compressionQuality: 0.8) {
                let filename = UUID().uuidString + ".jpg"
                let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)
                try? data.write(to: tempURL)
                
                selectedImg = filename
                
                DispatchQueue.main.async {
                    self.txtAtt.text = self.selectedImg
                    self.isSelectedImg = true
                    self.imgAtt.image = image
                    self.imgAtt.isHidden = false
                    self.imgAttUpload.isHidden = true
                }
            }
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.imageURL] as? URL
            
            //            selectedImg = imageurl?.lastPathComponent
            
            if let data = image.jpegData(compressionQuality: 0.8) {
                let filename = UUID().uuidString + ".jpg"
                let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)
                try? data.write(to: tempURL)
                
                selectedImg = filename
                
                DispatchQueue.main.async {
                    self.txtAtt.text = self.selectedImg
                    self.isSelectedImg = true
                    self.imgAtt.image = image
                    self.imgAtt.isHidden = false
                    self.imgAttUpload.isHidden = true
                }
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func myImageUploadRequest(imageToUpload: UIImage, imgKey: String) {
        
        APIClient.sharedInstance.showIndicator()
        
        let dicD = NSMutableDictionary()
 
        let cleanedString = "\(BASE_URL + FEEDBACK_FORM)".trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .controlCharacters).joined()
        
        guard let myUrl = URL(string:cleanedString ) else {
            print("Invalid URL: \(cleanedString)")
            return
        }
        
        let request = NSMutableURLRequest(url:myUrl as URL);
        request.httpMethod = "POST";
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let boundary = generateBoundaryString()
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("123", forHTTPHeaderField: "apiToken")
        request.addValue(Language.shared.currentAppLang, forHTTPHeaderField: "language")

        dicD.setValue(self.txtName.text ?? "", forKey: "name")
        dicD.setValue(self.txtMobile.text ?? "", forKey: "mobile_number")
        dicD.setValue(appDelegate?.dicCurrentLoginUser.email ?? "", forKey: "email")
        dicD.setValue(self.txtView.text ?? "", forKey: "comment")
        dicD.setValue("\(rateingUser)", forKey: "rating")
        dicD.setValue("1", forKey: "device_type")
        dicD.setValue("1.0", forKey: "version")
        dicD.setValue("1234", forKey: "device_id")
        dicD.setValue(Language.shared.currentAppLang, forKey: "language")
        
        print(dicD)
        
        let imageData = imageToUpload.jpegData(compressionQuality: 1)
        if imageData == nil  {
            return
        }
        
        request.httpBody = createBodyWithParameters(parameters: dicD as! [String : String], filePathKey: imgKey, imageDataKey: imageData! as NSData, boundary: boundary, imgKey: imgKey) as Data
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            DispatchQueue.main.async {
                APIClient.sharedInstance.hideIndicator()
            }
            if error != nil {
                print("error=\(error!)")
                
                return
            }
            
            // print reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("response data = \(responseString!)")
            
            do{
                
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    
                    // try to read out a string array
                    if let msg = json["message"] as? String
                    {
                        if let status = json["status"] as? Int, status == 1 {
                            DispatchQueue.main.async {
                                self.setUpMakeToast(msg: msg)
                                
                                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.5, execute: {
                                    appDelegate?.setUpHome()
                                })
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.setUpMakeToast(msg: msg)
                            }
                        }
                        
                    }
                }
            }catch{
                
            }
        }
        task.resume()
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String, imgKey: String) -> NSData {
        
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filename = "\(imgKey).jpg"
        let mimetype = "image/jpeg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\("images[0]")\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")
        
        
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func randomString(of length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var s = ""
        for _ in 0 ..< length {
            s.append(letters.randomElement()!)
        }
        return s
    }
    
    func callFeedbackAPI() {
        let dicD = NSMutableDictionary()
        dicD.setValue(self.txtName.text ?? "", forKey: "name")
        dicD.setValue(self.txtMobile.text ?? "", forKey: "mobile_number")
        dicD.setValue(appDelegate?.dicCurrentLoginUser.email ?? "", forKey: "email")
        dicD.setValue(self.txtView.text ?? "", forKey: "comment")
        dicD.setValue("\(rateingUser)", forKey: "rating")
        dicD.setValue("1", forKey: "device_type")
        dicD.setValue("1.0", forKey: "version")
        dicD.setValue("1234", forKey: "device_id")
        dicD.setValue(Language.shared.currentAppLang, forKey: "language")
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(FEEDBACK_FORM, parameters: dicD as! [String : Any]) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 201
                {
                    if status == 1
                    {
                        self.setUpMakeToast(msg: message ?? "")
                        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.5, execute: {
                            appDelegate?.setUpHome()
                        })
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                        self.setUpMakeToast(msg: message ?? "")
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
}

extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
