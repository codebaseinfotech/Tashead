//
//  WelcomeVC.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 31/05/23.
// com.Tashead

import UIKit

class WelcomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var pageContreer: UIPageControl!
    @IBOutlet weak var collectionViewWelcome: UICollectionView!
    
    @IBOutlet weak var lblTRegister: UILabel!
    @IBOutlet weak var btnSkip: UIButton!
    
    let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let sitemsPerRow : CGFloat = 1
    var flowLayout: UICollectionViewFlowLayout {
        let _flowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.sectionInsets.left * (self.sitemsPerRow + 1)
            let availableWidth = self.collectionViewWelcome.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.sitemsPerRow
            
            _flowLayout.itemSize = CGSize(width: self.collectionViewWelcome.frame.width, height: self.collectionViewWelcome.frame.height)
            
            _flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            _flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
            _flowLayout.minimumInteritemSpacing = 0
            _flowLayout.minimumLineSpacing = 0
        }
        // edit properties here
        return _flowLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTRegister.text = "Register / log in".localizeString(string: Language.shared.currentAppLang)
        
        btnSkip.setTitle("Skip".localizeString(string: Language.shared.currentAppLang), for: .normal)
        
        collectionViewWelcome.delegate = self
        collectionViewWelcome.dataSource = self
        collectionViewWelcome.collectionViewLayout = flowLayout
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionViewWelcome.dequeueReusableCell(withReuseIdentifier: "WelcomeCollectionCell", for: indexPath) as! WelcomeCollectionCell
        
        return cell
    }
     
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
            if let collectionView = scrollView as? UICollectionView {
                let currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
                pageContreer.currentPage = Int(currentPage)
            } else{
                print("cant cast")
            }
        }
    
    @IBAction func clickedRegisterLogin(_ sender: Any) {
        
        UserDefaults.standard.set(true, forKey: "isFinishaWalcome")
        UserDefaults.standard.synchronize()
        
        appDelegate?.setUpLogin()
    }
    
    @IBAction func clickedSKip(_ sender: Any) {
        
        UserDefaults.standard.set(true, forKey: "isFinishaWalcome")
        UserDefaults.standard.synchronize()
        
        appDelegate?.setUpHome()
    }
    
    
}


class WelcomeCollectionCell: UICollectionViewCell {
    
}

extension String {
    func localizeString(string: String) -> String {
        let path = Bundle.main.path(forResource: string, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
