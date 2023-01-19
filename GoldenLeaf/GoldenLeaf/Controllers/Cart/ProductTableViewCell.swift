//
//  ProductTableViewCell.swift
//  GoldenLeaf
//
//  Created by Shatha on 22/06/1444 AH.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
   
    
    //MARK: - Outlet
    @IBOutlet private weak var plantNameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var plantImageView: UIImageView!
    
    @IBOutlet private weak var incrementButton: UIButton!
    @IBOutlet private weak var decrementButton: UIButton!
    @IBOutlet private weak var quantityLabel: UILabel!
    
    
    
    //MARK: - var
    var plantItem : PlantElement?
    static let identifier = "ProductTableViewCell"
    var delegate: CartItemDelegate?
    var quantity: Int = 1
    

    
    
    //MARK: - Action
    @IBAction func updateCartItemQuantity(_ sender: Any) {
        if (sender as! UIButton).tag == 0 {
            quantity = quantity + 1
        } else if quantity > 0 {
            quantity = quantity - 1
        }
        
        decrementButton.isEnabled = quantity > 0
        
        self.quantityLabel.text = String(describing: quantity)
        self.delegate = Cart.shared
        self.delegate?.updateCartItem(cell: self, quantity: quantity)
    }
    
    
//    //MARK: - Action
    func setup(){
        if let plantImage = plantItem?.img {
            let imageURL = URL(string: plantImage)
            plantImageView.kf.setImage(with: imageURL)
        }
        plantNameLabel.text = plantItem?.latinName
        priceLabel.text = "\(plantItem?.heightAtPurchase!.cm!)$"
    }
}



