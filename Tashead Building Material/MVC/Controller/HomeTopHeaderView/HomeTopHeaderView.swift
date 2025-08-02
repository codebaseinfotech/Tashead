//
//  HomeTopHeaderView.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 26/12/24.
//

import UIKit

class HomeTopHeaderView: UIView {

    @IBOutlet weak var collectionViewInfu: UICollectionView! 
    @IBOutlet weak var viewInfu1: UIView!
    @IBOutlet weak var viewInfu2: UIView!
    @IBOutlet weak var viewInfu3: UIView!
    @IBOutlet weak var imgInfu1: UIImageView!
    @IBOutlet weak var imgInfu2: UIImageView!
    @IBOutlet weak var imgInfu3: UIImageView!
    
    @IBOutlet weak var viewConstrucatiom: UIView!
    @IBOutlet weak var viewCategories: UIView!
    
    @IBOutlet weak var lblTConstrucation: UILabel!
    @IBOutlet weak var lblCategories: UILabel!
    @IBOutlet weak var lblTInfo: UILabel!
    @IBOutlet weak var viewInfuMain: UIView!
    @IBOutlet weak var widthInfu2: NSLayoutConstraint!
    
    let InsectionInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    let InitemsPerRow: CGFloat = 5
    
    var InflowLayout: UICollectionViewFlowLayout {
        let _InflowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.InsectionInsets.left * (self.InitemsPerRow + 1)
            let availableWidth = self.collectionViewInfu.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.InitemsPerRow
            
            _InflowLayout.itemSize = CGSize(width: 70, height: 70)
            
            _InflowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            _InflowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
            _InflowLayout.minimumInteritemSpacing = 12
            _InflowLayout.minimumLineSpacing = 12
        }
        
        // edit properties here
        return _InflowLayout
    }
    
    var arrInfluencersList: [TBInfluencersListResult] = [TBInfluencersListResult]()
    var delegateVC: UIViewController?
    var clickedSegment: ((Int)->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func clickedInfu1(_ sender: Any) {
        let mainS = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
        vc.objInfluencers = arrInfluencersList[0]
        delegateVC?.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func clickedInfu2(_ sender: Any) {
        
        if Language.shared.isArabic {
            if arrInfluencersList.count == 1 {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
                vc.objInfluencers = arrInfluencersList[0]
                delegateVC?.navigationController?.pushViewController(vc, animated: true)
            } else {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
                vc.objInfluencers = arrInfluencersList[1]
                delegateVC?.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if arrInfluencersList.count == 1 {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
                vc.objInfluencers = arrInfluencersList[0]
                delegateVC?.navigationController?.pushViewController(vc, animated: true)
            } else {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
                vc.objInfluencers = arrInfluencersList[1]
                delegateVC?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    @IBAction func clickedInfu3(_ sender: Any) {
        
        if Language.shared.isArabic {
            if arrInfluencersList.count == 3 {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
                vc.objInfluencers = arrInfluencersList[2]
                delegateVC?.navigationController?.pushViewController(vc, animated: true)
            } else {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
                vc.objInfluencers = arrInfluencersList[1]
                delegateVC?.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if arrInfluencersList.count == 3 {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
                vc.objInfluencers = arrInfluencersList[2]
                delegateVC?.navigationController?.pushViewController(vc, animated: true)
            } else {
                let mainS = UIStoryboard(name: "Home", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ToolsVC") as! ToolsVC
                vc.objInfluencers = arrInfluencersList[1]
                delegateVC?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    @IBAction func clickedConstrucation(_ sender: Any) {
        viewConstrucatiom.backgroundColor = UIColor(hexString: "#F3CB97")
        viewCategories.backgroundColor = .white
        clickedSegment?(1)
    }
    @IBAction func clickedCategories(_ sender: Any) {
        viewCategories.backgroundColor = UIColor(hexString: "#F3CB97")
        viewConstrucatiom.backgroundColor = .white
        clickedSegment?(0)
    }
    
    
}


