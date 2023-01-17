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
    var PlantArray : [PlantElement] = []
    static let identifier = "ProductTableViewCell"
    //var delegate: CartItemDelegate?
    var quantity: Int = 1
    

    
    
    //MARK: - Action
    @IBAction func updateCartItemQuantity(_ sender: Any) {
        if (sender as! UIButton).tag == 0 {
            quantity = quantity + 1
        } else if quantity > 0 {
            quantity = quantity - 1
        }
        
        decrementButton.isEnabled = quantity > 0
        decrementButton.backgroundColor = !decrementButton.isEnabled ? .gray : .black
        
        self.quantityLabel.text = String(describing: quantity)
     //   self.delegate?.updateCartItem(cell: self, quantity: quantity)
    }
    
    
    //MARK: - Action
//    func setup(){
//        plantImageView.kf.setImage(with: strURL)
//        plantNameLabel.text = PlantArray[indexPath.row].latinName
//        priceLabel.text = "\(PlantArray[indexPath.row].heightAtPurchase!.cm!)$"
//    }
}
