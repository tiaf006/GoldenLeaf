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
    
    var ref: DatabaseReference!
    //MARK: Outlets 🔌
    @IBOutlet weak var dateTimeLabel: UILabel!
    //MARK: Total price
    @IBOutlet weak var totalPriceLabel: UILabel!
    //MARK: Card info
    @IBOutlet weak var cardHolderName: UITextField!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var cardExpiryDate: UITextField!
    @IBOutlet weak var cardCVV: UITextField!
    //MARK: payment options
    override func viewDidLoad() {
        super.viewDidLoad()
        orderTimeAndDate()
                setPopUpButton()
                FirebaseApp.configure()
                //storing card info data
                ref = Database.database().reference().child("Cards");
    }
    //MARK: Action Pick payment method 💳
    
    @IBOutlet weak var pickPaymentMethod: UIButton!
    
    //MARK: payment options list pop up button when user click he can choose the payment method
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
        saveCardInformation()
        showAlert()
    }
    
    //MARK: save card info
    func saveCardInformation() {
        let key = ref.childByAutoId().key
        let cards = [
            "id": key,
            "order date & time": dateTimeLabel.text! as String,
            "card holder name": cardHolderName.text! as String,
            "card number": cardNumber.text! as String,
            "card expiry date": cardExpiryDate.text! as String,
            "card cvv": cardCVV.text! as String
        ]
        ref.child(key!).setValue(cards)
    }
    //MARK: alert ‼️
    func showAlert() {
        let alert = UIAlertController(title: "Succesful Payment 🌱", message: "Your payment was successful and your order is on its way 🛵", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok 🍃", style: .default, handler: { action in
            print("Ok button is pressed 🍃")
        }))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Date and time of order ⏰
       func orderTimeAndDate() {
           let currentTime = Date()
           let formatter = DateFormatter()
           let dateTimeString = formatter.string(from: currentTime)
           dateTimeLabel.text = dateTimeString
       }
}
