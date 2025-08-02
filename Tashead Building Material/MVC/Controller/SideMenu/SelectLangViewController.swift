//
//  SelectLangViewController.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 13/09/23.
//

import UIKit
import LGSideMenuController

class SelectLangViewController: UIViewController {
    
    @IBOutlet weak var btnBack: UIImageView!
    
    @IBOutlet weak var viewEnglish: UIView!
    @IBOutlet weak var viewARabic: UIView!
    
    @IBOutlet weak var lblTPlease: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewEnglish.layer.borderColor = UIColor.black.cgColor
        viewARabic.layer.borderColor = UIColor.black.cgColor
        
        if Language.shared.isArabic == true
        {
            btnBack.image = UIImage(named: "Back_Ar")
            
            viewARabic.backgroundColor = UIColor(red: 247/255, green: 196/255, blue: 145/255, alpha: 1)
            viewEnglish.backgroundColor = .white
            
            viewARabic.layer.borderWidth = 0
            viewEnglish.layer.borderWidth = 1
        }
        else
        {
            viewEnglish.backgroundColor = UIColor(red: 247/255, green: 196/255, blue: 145/255, alpha: 1)
            viewARabic.backgroundColor = .white
            
            viewEnglish.layer.borderWidth = 0
            viewARabic.layer.borderWidth = 1
            
            btnBack.image = UIImage(named: "Back")
        }
 
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func clickedBck(_ sender: Any) {
        appDelegate?.setUpHome()
    }
    
    @IBAction func clickedArabic(_ sender: Any) {
        
        viewARabic.backgroundColor = UIColor(red: 247/255, green: 196/255, blue: 145/255, alpha: 1)
        viewEnglish.backgroundColor = .white
        
        viewARabic.layer.borderWidth = 0
        viewEnglish.layer.borderWidth = 1
        
        Language.shared.isArabic = true
        UserDefaults.standard.set(true, forKey: "ar")
        
        setSemantricFlow()
        
        if  appDelegate?.getIsUserLogin() == true
        {
            appDelegate?.setNotificaationTag()
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            appDelegate?.setUpHome()
        }
    }
    
    @IBAction func clickedEn(_ sender: Any) {
        
        viewEnglish.backgroundColor = UIColor(red: 247/255, green: 196/255, blue: 145/255, alpha: 1)
        viewARabic.backgroundColor = .white
        
        viewEnglish.layer.borderWidth = 0
        viewARabic.layer.borderWidth = 1
        
        Language.shared.isArabic = false
        UserDefaults.standard.set(false, forKey: "ar")
        
        setSemantricFlow()
        
        if  appDelegate?.getIsUserLogin() == true
        {
            appDelegate?.setNotificaationTag()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            appDelegate?.setUpHome()
        }
    }
    
    @IBAction func clickedMEnu(_ sender: Any) {
        if Language.shared.isArabic {
            self.sideMenuController?.showRightView(animated: true, completion: nil)
        }
        else
        {
            self.sideMenuController?.showLeftView(animated: true, completion: nil)
        }
    }
    
}

