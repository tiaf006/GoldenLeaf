//
//  PaymentViewController.swift
//  GoldenLeaf
//
//  Created by TAIF Al-zahrani on 22/06/1444 AH.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase

class PaymentViewController: UIViewController {
    
    //MARK: Outlets 🔌
    @IBOutlet weak var totalPriceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setPopUpButton()
        // Do any additional setup after loading the view.
    }
    //MARK: Action Pick payment method 💳
    
    @IBOutlet weak var pickPaymentMethod: UIButton!
    
    func setPopUpButton() {
        let optionClosure = {(action: UIAction) in print(action.title)}
        //set option titles
        pickPaymentMethod.menu = UIMenu(children: [
            UIAction(title: "Card", state: .on, handler: optionClosure), UIAction(title: "Mada", handler: optionClosure), UIAction(title: "Apple Pay", handler: optionClosure)])
        
        pickPaymentMethod.showsMenuAsPrimaryAction = true
        pickPaymentMethod.changesSelectionAsPrimaryAction = true
    }
    //MARK: 🚀 Action Pay items and save >> date and plant names and pricess to firebase 🔥
    @IBAction func payButtonPressed(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
