//
//  CartViewMain.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 25/07/25.
//

import UIKit

class CartViewMain: UIView {

    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var lblPrie: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var lblTitleViewCart: UILabel! {
        didSet {
            lblTitleViewCart.text = "View Cart".localizeString(string: Language.shared.currentAppLang)
        }
    }
    
    var cartData: TBCartListResult? {
        didSet {
            lblCartCount.text = "\(cartData?.cartItems.count ?? 0)"
            lblPrie.text = "\(cartData?.total.cartTotal ?? "") KD"
        }
    }
    
    var tapedCart: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CartViewMain", owner: self, options: nil)
        addSubview(view)
        
        self.layoutIfNeeded()
        view.layoutIfNeeded()
        
    }
    
    @IBAction func clickedCart(_ sender: UIButton) {
        tapedCart?()
    }
    

}
