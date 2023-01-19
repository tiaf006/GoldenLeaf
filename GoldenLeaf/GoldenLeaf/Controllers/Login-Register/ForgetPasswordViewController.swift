//
//  ForgetPasswordViewController.swift
//  GoldenLeaf

import UIKit
import Firebase

class ForgetPasswordViewController: UIViewController {
    
    //IBOutlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Send button style
        sendButton.layer.cornerRadius = sendButton.frame.height / 2
        sendButton.layer.borderWidth = 2
        sendButton.backgroundColor = .systemBlue
        sendButton.layer.borderColor = UIColor.white.cgColor
        
    }
    
    @IBAction func forgotPassButton (_ sender: Any) {
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: emailTextField.text!) { error in
            // Check if any error will show error message
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
                return
            }
            
            // Else will show susuccess message and open login view controller
            let alertController = UIAlertController(title: "Success", message: "A password reset email has been sent ", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel) { (action) -> Void in
                
                // Show LogInViewController
                let logInVC = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
                logInVC.modalPresentationStyle = .fullScreen
                self.present(logInVC, animated: true)
              }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
        }
    }
}
