//
//  AdsVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 09/07/25.
//

import UIKit

protocol didTapOnAds: AnyObject {
    func onTapClose()
}

class AdsVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var viewbg: UIView!
    @IBOutlet weak var imgAds: UIImageView!
    
    var delegateClose: didTapOnAds?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var media_link_url = appDelegate?.getCmsAdverd().image ?? ""
        media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        imgAds.sd_setImage(with: URL.init(string: media_link_url),placeholderImage: nil, options: [], completed: nil)
        
        var duration = Double(appDelegate?.getCmsAdverd().adDuration ?? "") ?? 0.0
        let ad_duration_unit = appDelegate?.getCmsAdverd().adDurationUnit ?? ""
        
        if ad_duration_unit.lowercased() == "minute" {
            duration = duration * 60
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.delegateClose?.onTapClose()
            self.dismiss(animated: false)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(openProductDetail(_:)), name: NSNotification.Name("OpenProductDetail"), object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func openProductDetail(_ notification: Notification) {
        self.dismiss(animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.delegateClose?.onTapClose()
        self.dismiss(animated: false)
    }
    
    @IBAction func clickedOutPut(_ sender: Any) {
        
        let type = appDelegate?.getCmsAdverd().type ?? ""
        let value = appDelegate?.getCmsAdverd().value ?? ""
        
        if type != "0" {
            if type == "2"
            {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
                vc.strProductID = "\(value)"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if type == "1"
            {
                self.dismiss(animated: false) {
                    if let url = URL(string: value) {
                        UIApplication.shared.open(url)
                    }
                }
            }
        }
    }
}
